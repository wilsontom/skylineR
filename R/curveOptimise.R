#' curveOptimise
#'
#' Optimise calibration curve
#'
#' @param x a \code{data.frame}
#' @return a \code{data.frame}
#'
#' @keywords internal
#'

curveOptimise <- function(x)
{

  idx <- seq(from = 1, to = nrow(x), by = 1)

  pmin <- round(0.7 * length(idx), digits = 0)
  pmax <- length(idx)

  prange <- c(pmin:pmax)

  pcombinations <- NULL
  for(k in seq_along(prange)){
    pcombinations[[k]] <- data.frame(combn(idx,prange[k]))
  }

  pcom_vec <- do.call("c", pcombinations)
  names(pcom_vec) <- seq(from = 1, to = length(pcom_vec), by = 1)

  # make up list of combination data.frames

  combn_dfs <- NULL
  for(i in seq_along(pcom_vec)){
    combn_dfs[[i]] <- data.frame(x = x[pcom_vec[[i]],"x"], y = x[pcom_vec[[i]],"y"])
  }


  opt_rsq <- round(unlist(lapply(combn_dfs,function(x)(
      summary(fitCurve(x$y, x$x, type = "Quad-LogLog"))$r.sq))), digits = 5)

  opt_err <- round(unlist(lapply(combn_dfs, function(x){
                    predy <- predictModel(fitCurve(x$x,x$y, type = "Quad-LogLog"),x$y)
                        median(abs(predy - x$x) / x$x) * 100})), digits = 3)

  rsq_id <- which(opt_rsq > 0.98)
  err_id <- which(opt_err < 15)


  id_intersect <- intersect(rsq_id,err_id)

  if(length(id_intersect) == 0){
    err_min_idx <- err_id[which(err_id == min(err_id))]
  }else{
  err_min_idx <- id_intersect[which(opt_err[id_intersect] == min(opt_err[id_intersect]))]
  }

  opt_cali <- combn_dfs[[err_min_idx]]

  opt_res <- c(rsq = opt_rsq[[err_min_idx]], error = opt_err[[err_min_idx]], pts = nrow(opt_cali),
               quant_range = paste(min(combn_dfs[[err_min_idx]]$x), max(combn_dfs[[err_min_idx]]$x), sep = " - ")
  )

  return(opt_res)
}
