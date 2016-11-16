



linear_error <- function(x,y)
{

  lm_model <- lm(y ~ x)
  lmodCf <- coefficients(lm_model)
  y_intercept <- lmodCf[["(Intercept)"]]
  gradient <- lmodCf[[2]]
  Rsq <- summary(lm_model)$r.sq
  pnts <- length(lm_model$fitted.values)

  new_x <- (y - y_intercept) / gradient
  x_diff <- abs((x - new_x) / x)
  err <- mean(x_diff)
  return(err)
}


linear_model <- function(x,y)
{
  lm_model <- lm(y ~ x)
  lmodCf <- coefficients(lm_model)
  y_intercept <- lmodCf[["(Intercept)"]]
  gradient <- lmodCf[[2]]
  Rsq <- summary(lm_model)$r.sq
  pnts <- length(lm_model$fitted.values)
  return(list(r2 = Rsq, m = gradient, c = y_intercept, pts = pnts))
}


linear_opt <- function(x)
{

  idx <- seq(from = 1, to = nrow(x), by = 1)

  pmin <- round(0.8 * length(idx), digits = 0)
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
    combn_dfs[[i]] <- data.frame(conc = x[pcom_vec[[i]],"conc"], value = x[pcom_vec[[i]],"value"])
  }

  opt_rsq <- unlist(lapply(combn_dfs, function(x)linear_model(x = x$conc, y = x$value)$r2))

  opt_err <- unlist(lapply(combn_dfs, function(x)linear_error(x = x$conc, y = x$value)))

  rsq_id <- which(opt_rsq > 0.99)
  err_id <- which(opt_err < 5.0)

  id_intersect <- intersect(rsq_id,err_id)

  err_min_idx <- id_intersect[which(opt_err[id_intersect] == min(opt_err[id_intersect]))]

  opt_cali <- combn_dfs[[err_min_idx]]

  opt_res <- c(linear_model(x = opt_cali$conc, y = opt_cali$value), error = opt_err[err_min_idx])

  return(opt_res)
}
