#' quantify
#' @rdname quantify
#'
#' @description Calculate quantitation results for all non-calibrant samples
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "quantify", signature = "skyline",
          function(object, area){
            objectName <- as.list(match.call())$object
            cls_idx <- which(object@runinfo$class != "calibrant")

			
			quant_x <- NULL
			for(i in seq_along(object@calibration[[1]][,"id"])){
			
				tmp <- object@peakInfo$area[i,cls_idx + 1]
				rownames(tmp) <- object@peakInfo$area[i,1]
				
				if(area == "ratio"){
					is_match <- match(names(tmp), rownames(object@internalstd))
					tmpR  <- tmp / object@internalstd[is_match,"area"]
			
					cidx <- match(rownames(tmpR),object@calibration[[1]][,"id"])
			
					calMod <-  fitCurve(object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"conc"],
							object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"ratio"], 
							type = object@calibration[[1]][cidx,"function"])
			}
				if(area == "raw"){
					tmpR <- tmp

					cidx <- match(rownames(tmpR),object@calibration[[1]][,"id"])
			
					calMod <-  fitCurve(object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"conc"],
							object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"area"], 
							type = object@calibration[[1]][cidx,"function"])
	
			
			}
				
				for_pred <- data.frame(t(tmpR))

				
				quant_x[[i]] <- predictModel(calMod, for_pred[,1])
				}
				
			
		  quant <- data.frame(do.call("rbind", quant_x))
		  rownames(quant) <- object@peakInfo$area[,"id"]
	      names(quant) <- object@runinfo[cls_idx,"name"]
          object@quant <- quant
          assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
      }
)
