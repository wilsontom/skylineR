



#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "calibrate", signature = "skyline",
          function(object){

            objectName <- as.list(match.call())$object
            caIdx <- which(object@runinfo[,"class"] == "calibrant")
            caPA <- data.frame(id = object@peakInfo$area[,1], object@peakInfo$area[,caIdx + 1])

            names(caPA) <- c("id", names(object@peakInfo$area[,caIdx + 1]))

            caPA2 <- split(caPA, as.numeric(rownames(caPA)))
            caPA3 <- lapply(caPA2, t)

            caDF <- NULL
            for(i in seq_along(caPA3)){
              names(caPA3)[i] <- caPA3[[i]]["id",]
              caPA3[[i]] <- caPA3[[i]][-1,]

              names(caPA3[[i]]) <- gsub("\\.", "-", names(caPA3[[i]]))
              idm <- match(names(caPA3[[i]]), object@runinfo[,"name"])

              caDF[[i]] <- data.frame(conc = object@runinfo[idm,"conc"], value = as.numeric(caPA3[[i]]))
              caDF[[i]] <- caDF[[i]][order(caDF[[i]][,"conc"]),]
            }

            names(caDF) <- names(caPA3)
            caDF$IS <- NULL
            calibration_optimise <- lapply(caDF, linear_opt)

            calib_df <- data.frame(matrix(nrow = length(calibration_optimise), ncol = 6))
            names(calib_df) <- c("id", "R2", "c", "m", "n", "err")
            for(i in seq_along(calibration_optimise)){
              calib_df[i,"id"] <- names(calibration_optimise)[i]
              calib_df[i,"R2"] <- calibration_optimise[[i]]$r2
              calib_df[i,"c"] <- calibration_optimise[[i]]$c
              calib_df[i,"m"] <- calibration_optimise[[i]]$m
              calib_df[i,"n"] <- calibration_optimise[[i]]$pts
              calib_df[i,"err"] <- calibration_optimise[[i]]$error
            }

            object@calibrants <- calib_df

            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
