#' add_path
#' @rdname add_path
#'
#' @description Add a `path` location which will be used as a temporay save to write-out `Skyline` result files
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "add_path", signature = "skyline",
          function(object, path){

            objectName <- as.list(match.call())$object

            if(!isTRUE(dir.exists(path))){
              stop(deparse(substitute(path)), " must be an exisiting directory path", call. = FALSE)
            }

            if(length(list.files(path) != 0)){
              stop(deparse(substitute(path)), " must be an empty directory", call. = FALSE)
            }

            object@path <- path
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
