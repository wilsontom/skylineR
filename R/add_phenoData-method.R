#' add_phenoData
#' @rdname add_phenoData
#'
#' @description Add the runinfo \code{data.frame} to a \code{skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "add_phenoData", signature = "skyline",
          function(object, phenoData){

            objectName <- as.list(match.call())$object

            if(nrow(phenoData) != length(object@filePaths)){
              stop("")
            }

            object@phenoData <- phenoDta
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
