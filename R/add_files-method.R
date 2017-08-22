#' add_filePaths
#' @rdname add_filePaths
#'
#' @description Add the file paths of all raw data to be analysed to a \code{skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod("add_filePaths", signature = "skyline",
          function(object,filePaths){

            if(!is.vector(filePaths)){
              stop(deparse(substitute(filePaths)), " must be a vecotr of files", call. = FALSE)
            }

            objectName <- as.list(match.call())$object

            object@filePaths <- filePaths
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)

            print(paste(length(object@filePaths), "files added to", objectName, sep = " "))

          }
)
