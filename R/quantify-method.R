#' quantify
#' @rdname quantify
#'
#' @description Calculate quantitation results for all non-calibrant samples
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "quantify", signature = "skyline",
          function(object){
            objectName <- as.list(match.call())$object
            cls_idx <- which(object@runinfo$class != "calibrant")

			
			quant_x <- NULL
			for(i in seq_along(object@calibration[[1]][,"id"])){
			
				tmp <- object@peakInfo$area[i,cls_idx + 1]
				rownames(tmp) <- object@peakInfo$area[i,1]
			
				is_match <- match(names(tmp), rownames(object@internalstd))
				tmpR  <- tmp / object@internalstd[is_match,"area"]
			
				cidx <- match(rownames(tmpR),object@calibration[[1]][,"id"])
			
				calMod <-  fitCurve(object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"conc"],
											object@calibrants[[cidx]][object@calibration[[2]][[cidx]],"ratio"])
				
				
				for_pred <- data.frame(t(tmpR))
				
				
				quant_x[[i]] <- predictModel(calMod, for_pred[,1])
				}
				
			
			
			
            # quant <- NULL
			# calmods <- NULL
            # for(i in seq_along(cls_idx)){
                # dftmp <- data.frame(id = object@peakInfo$area[,1],
                                  # area = object@peakInfo$area[cls_idx[i] + 1])

				# convert to ratios here !
				# is_match <- match(names(dftmp)[2], rownames(object@internalstd))

				# dftmp[,2] <- dftmp[,2] / object@internalstd[is_match,"area"]

				# calmods[[i]] <- fitCurve(object@calibrants[[i]][object@calibration[[2]][[cidx]],"conc"],
											# object@calibrants[[i]][object@calibration[[2]][[cidx]],"ratio"])
    
				
				
				# cidx <- match(dftmp[,"id"],object@calibration[[1]][,"id"])
				
				# quant[[i]] <- predictModel(calmods[[i]],dftmp[,2])
				
				
				
				
				
                # quant[[i]] <- (dftmp[,2] - object@calibration[cidx,"c"]) / object@calibration[cidx,"m"]



				# }

			quant <- data.frame(do.call("rbind", quant_x))
			rownames(quant) <- object@peakInfo$area[,"id"]
			names(quant) <- object@runinfo[cls_idx,"name"]
				
            # result_lyt_qn <- data.frame(matrix(ncol = length(quant) + 1, nrow = length(quant[[1]])))

            # names(result_lyt_qn) <- c("id",object@runinfo[cls_idx,"name"])

            # result_lyt_qn[,"id"] <- object@calibration[cidx,"id"]

           # for(i in seq_along(quant)){
                # result_lyt_qn[,i + 1] <- quant[[i]]
            # }

          object@quant <- quant
          assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
      }
)
