#' addFiles
#' @rdname addFiles
#'
#' @description Add the file paths of all raw data to be analysed to a \code{Skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod("addFiles", signature = "Skyline",
          function(object,filepath){

            objectName <- as.list(match.call())$object

            all_files <- list.files(filepath, pattern = c('.raw|.RAW'), full = "TRUE")
            object@filepaths <- all_files

            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)

            print(paste(length(object@filepaths), "files added to", objectName, sep = " "))

          }
)
