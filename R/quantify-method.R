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


            quant <- NULL
            for(i in seq_along(cls_idx)){
                dftmp <- data.frame(id = object@peakInfo$area[,1],
                                  area = object@peakInfo$area[cls_idx[i] + 1])

				# convert to ratios here !
				is_match <- match(names(dftmp)[2], rownames(object@internalstd))



				dftmp[,2] <- dftmp[,2] / object@internalstd[is_match,"area"]
                cidx <- match(dftmp[,"id"],object@calibration[,"id"])
                quant[[i]] <- (dftmp[,2] - object@calibration[cidx,"c"]) / object@calibration[cidx,"m"]
              }

            result_lyt_qn <- data.frame(matrix(ncol = length(quant) + 1, nrow = length(quant[[1]])))

            names(result_lyt_qn) <- c("id",object@runinfo[cls_idx,"name"])

            result_lyt_qn[,"id"] <- object@calibration[cidx,"id"]

           for(i in seq_along(quant)){
                result_lyt_qn[,i + 1] <- quant[[i]]
            }

          object@quant <- result_lyt_qn
          assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
      }
)
