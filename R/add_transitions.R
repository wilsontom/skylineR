#' add_transitions
#' @rdname add_transitions
#'
#' @description Add a transition \code{data.frame} to a \code{skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "add_transitions", signature = "skyline",
          function(object, transitions){

            objectName <- as.list(match.call())$object

            transitions <- validate_transitions(transitions)

            #skyline_transitions <- data.frame(MoleculeGroup = transitions[,"PrecursorName"], transitions)
            object@transitions <- transitions
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
