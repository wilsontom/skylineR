#' get_internalStd
#' @rdname get_internalStd
#'
#' @description extract peak data (area, noise and Rt) for the internal standard (IS) from every sample.
#' Once IS peak data has been added to the \code{internalstd} slot in a \code{skyline} object; it is removed
#' from the peak tables in the \code{peakInfo} slot.
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "get_internalStd", signature = "skyline",
          function(object){

		objectName <- as.list(match.call())$object

		ISidx <- which(object@peakInfo$area[,"id"] == "IS")

		if(length(ISidx) == 1){
			row_lables <- names(object@peakInfo$area[ISidx,-1])
			ISarea <- t(object@peakInfo$area[ISidx,-1])
			ISrt <- t(object@peakInfo$Rt[ISidx,-1])
			ISnoise <- t(object@peakInfo$noise[ISidx,-1])
		}else{
			row_lables <- names(object@peakInfo$area[ISidx,-1])
			ISarea <- object@peakInfo$area[ISidx,-1]
			ISrt <- object@peakInfo$Rt[ISidx,-1]
			ISnoise <- object@peakInfo$noise[ISidx,-1]
		}
		if(length(ISidx) > 1){
			ISarea <- apply(ISarea,2,sum)
			ISrt <- apply(ISrt,2,mean)
			ISnoise <- apply(ISnoise,2,sum)
		}


		ISdf <- data.frame(area = ISarea, noise = ISnoise, Rt = ISrt)
		names(ISdf) <- c("area", "noise", "rt")
		rownames(ISdf) <- row_lables
		object@internalstd <- ISdf

		object@peakInfo$area <- object@peakInfo$area[-ISidx,]
		object@peakInfo$Rt <- object@peakInfo$Rt[-ISidx,]
		object@peakInfo$noise <- object@peakInfo$noise[-ISidx,]

		assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
		}
)
