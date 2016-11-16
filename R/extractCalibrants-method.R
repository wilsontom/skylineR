#' extractCalibrants
#' @rdname extractCalibrants
#'
#' @description extact calibrant data from peak integration tables
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "extractCalibrants", signature = "skyline",
          function(object){

					objectName <- as.list(match.call())$object

					calibrant_id <- which(object@runinfo[,"class"] == "calibrant")
					calibrant_area <- data.frame(object@peakInfo$area[,calibrant_id + 1])
					rownames(calibrant_area) <- object@peakInfo$area[,"id"]

					names(calibrant_area) <- object@runinfo[calibrant_id,"name"]

					## order
					calibrant_split <- split(calibrant_area, rownames(calibrant_area))

					calibrant_df <- lapply(calibrant_split, t)

					for(i in seq_along(calibrant_df)){
						calibrant_df[[i]] <- data.frame(calibrant_df[[i]], object@runinfo[calibrant_id,"conc"])
						names(calibrant_df[[i]]) <- c("area", "conc")
					}

					IS_area <- calibrant_df$IS1[,"area"]

					for(i in seq_along(calibrant_df)){
						calibrant_df[[i]] <- data.frame(calibrant_df[[i]],ratio = calibrant_df[[i]][,"area"] / IS_area)
					}
					object@calibrants <- calibrant_df

					assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
				}
)
