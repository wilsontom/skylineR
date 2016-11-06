#' addInfo
#' @rdname addInfo
#'
#' @description Add the runinfo \code{data.frame} to a \code{Skyline} object. The method writes to
#' the object in the global environment
#'
#' @include allGenerics.R
#' @include allClasses.R


setMethod(f = "addInfo", signature = "Skyline",
          function(object, runinfo){

            objectName <- as.list(match.call())$object

            ext <- strsplit(basename(runinfo), "\\.")[[1]][2]
            if(ext != "csv"){stop("...runinfo input must be in a .csv format", call. = FALSE)}
            info <- read.csv(runinfo, head = TRUE, stringsAsFactors = FALSE)

            if(length(grep("calibrant", info[,"class"])) == 0){
              message("WARNING: no calibrant files specified")
            }

            if(nrow(info) != length(object@filepaths)){
              message("WARNING: number of rows in runinfo does not equal the number of available raw files")
            }

            idx <- grep("calibrant", info[,"class"])
            if(length(idx) > 0){
              idconc <- info[idx,"conc"]
              if(!is.numeric(idconc)){
                message("WARNING: calibrant concentrations have been given in a non-numeric form")
              }
              if(any(idconc == 0)){
                message("WARNING: calibrant concentration must be greater than 0 (zero)")
              }

            }

            object@runinfo <- info
            assign(eval(paste(text = objectName)),object, envir = .GlobalEnv)
          }
)
