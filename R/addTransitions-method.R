#' addTransitions
#' @rdname addTransitions
#'
#' @description Add a transition \code{data.frame} to a \code{skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "addTransitions", signature = "skyline",
          function(object, transitionList){

            objectName <- as.list(match.call())$object

            ext <- strsplit(basename(transitionList), "\\.")[[1]][2]
            if(ext != "csv"){stop("transition list input must be in a .csv format", call. = FALSE)}

            transitions <- read.csv(transitionList, head = TRUE, stringsAsFactors = FALSE)

            nmRef <- c("PrecursorName", "PrecursorRT","PrecursorMz", "ProductMz","PrecursorCharge", "ProductCharge")

            nmCh <- names(transitions) == nmRef

            if(any(nmCh == FALSE)){
              stop("transition list is not named correctly, refer to ... for help", call. = FALSE)
            }

            transCh <- transitions[,"ProductMz"] < transitions[,"PrecursorMz"]

            if(any(transCh == FALSE)){
              message("WARNING: Product m/z value (Q3mz) found which is greater than precursor m/z value (Q1mz)")
            }
            transitions2 <- data.frame(MoleculeGroup = transitions[,"PrecursorName"], transitions)
            object@transitions <- transitions2
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
