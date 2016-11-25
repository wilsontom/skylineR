#' calibrate
#' @rdname calibrate
#'
#' @description Generate optimised calibration curves for each transition
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "calibrate", signature = "skyline",
          function(object, type){

          objectName <- as.list(match.call())$object
				  cali_tmp <- NULL
	       for(i in seq_along(object@calibrants)){
			          cali_tmp[[i]] <- data.frame(x = object@calibrants[[i]][,"conc"],y = object@calibrants[[i]][,"ratio"])
	        }

  	     names(cali_tmp) <- names(object@calibrants)

			   calibration_tmp <- lapply(cali_tmp, curveOptimise,type = type)

			   calibration_optimise <- lapply(calibration_tmp, function(x)(x$res))
			   
					
		calib_df <- data.frame(matrix(nrow = length(calibration_optimise), ncol = 5))
          names(calib_df) <- c("id", "Rsq", "n", "err", "range")
          for(i in seq_along(calibration_optimise)){
            calib_df[i,"id"] <- names(calibration_optimise)[i]
            calib_df[i,"Rsq"] <- as.numeric(calibration_optimise[[i]][["rsq"]])
            calib_df[i,"n"] <- as.numeric(calibration_optimise[[i]][["pts"]])
            calib_df[i,"err"] <- as.numeric(calibration_optimise[[i]][["error"]])
			      calib_df[i,"range"] <- calibration_optimise[[i]][["quant_range"]]
          }

		  
		  calibration_ind <- NULL
		  for(i in seq_along(calibration_tmp)){
		  calibration_ind[[i]] <- match(calibration_tmp[[i]]$conc, object@calibrants[[i]][,"conc"])
		  }
		  
		  names(calibration_ind) <- calib_df[,"id"]
		  
		  object@calibration  <- list(calib_df,calibration_ind)
		  
		  assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
		 }
)
		 
