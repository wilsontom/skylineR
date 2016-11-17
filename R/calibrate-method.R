#' calibrate
#' @rdname calibrate
#'
#' @description Generate optimised calibration curves for each transition
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "calibrate", signature = "skyline",
          function(object){

          objectName <- as.list(match.call())$object
				  cali_tmp <- NULL
	       for(i in seq_along(object@calibrants)){
			          cali_tmp[[i]] <- data.frame(x = object@calibrants[[i]][,"conc"],y = object@calibrants[[i]][,"ratio"])
	        }

  	     names(cali_tmp) <- names(object@calibrants)
			   calibration_optimise <- lapply(cali_tmp, linear_opt)

          calib_df <- data.frame(matrix(nrow = length(calibration_optimise), ncol = 7))
          names(calib_df) <- c("id", "R2", "c", "m", "n", "err", "range")
          for(i in seq_along(calibration_optimise)){
            calib_df[i,"id"] <- names(calibration_optimise)[i]
            calib_df[i,"R2"] <- calibration_optimise[[i]]$r2
            calib_df[i,"c"] <- calibration_optimise[[i]]$c
            calib_df[i,"m"] <- calibration_optimise[[i]]$m
            calib_df[i,"n"] <- calibration_optimise[[i]]$pts
            calib_df[i,"err"] <- calibration_optimise[[i]]$error
			      calib_df[i,"range"] <- calibration_optimise[[i]]$quant_range
          }

          object@calibration <- calib_df
          assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
