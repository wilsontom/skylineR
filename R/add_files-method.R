#' add_files
#' @rdname add_files
#'
#' @description Add the file paths of all raw data to be analysed to a \code{skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod("add_files", signature = "skyline",
          function(object,files){

            if(!is.vector(files)){
              stop(deparse(substitute(filepaths)), " must be a vecotr of files", call. = FALSE)
            }

            objectName <- as.list(match.call())$object

            object@filepaths <- files
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)

            print(paste(length(object@filepaths), "files added to", objectName, sep = " "))

          }
)
