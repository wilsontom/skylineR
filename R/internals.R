#' Validate phenoData
#'
#' @param x a `data.frame` of `fileName` and `sampleName`
#' @param object a `skyline` object containing filepaths
#' @return NULL
#' @keywords internal

validate_phenoData <- function(x, object)
  {
  name_dict <- c("fileName", "name")

  name_check <- names(x) == c("fileName", "sampleName")

  if(any(name_check) == FALSE){
    stop(deparse(substitute(x)), " is not named correctly")
  }

  if(length(object@filepaths) == 0){
    stop("unable to validate ",deparse(substitute(x)), " no filepaths found in ", deparse(substitute(object)), call. = FALSE)
  }

  filename_check <- x[,"fileName"] == basename(object@filepaths)

  if(any(filename_check) == FALSE){
    stop("filenames do not match")
  }

  return(invisible(NULL))

  }

#' Validate transitions
#'
#' @param x a `data.frame` of Skyline formatted transition data
#' @return NULL
#' @keywords internal

validate_transitions <- function(x)
  {
  # check column names first
  nmRef <- c("PrecursorName", "PrecursorRT","PrecursorMz", "ProductMz","PrecursorCharge", "ProductCharge")

  nmCh <- names(x) == nmRef

  if(any(nmCh == FALSE)){
    stop(deparse(substitute(x))," has incorrect column names. Refere to ... for more hep", call. = FALSE)
  }

  # check values
  transCh <- x[,"ProductMz"] < x[,"PrecursorMz"]

  if(any(transCh == FALSE)){
    message("WARNING: Product m/z value (Q3mz) found which is greater than precursor m/z value (Q1mz)")
  }

  return(invisible(NULL))
  }

#' Skyline CommandLine Runner
#'
#' @param x a character vector 
#' @return NULL
#' @keywords internal
   
skyline_runner <- function(x)
	{
	object <- getOption("SkylineObject")

	SKYLINE <- object@SkylinePath
	SKYD <- paste0("--in=", object@SkylineTransition)
	TRANSITIONS <- paste0("--import-transition-list=",paste0(object@path,"/transitions_temp.csv"))
	IN <- paste0("--import-file=", x)
	nmtp <- paste0(strsplit(basename(x), "\\.")[[1]][1], ".csv")
	REPORT_NAME <- paste0(object@path, "/",nmtp)
	REPORT_a <- paste0("--report-name=\"Transition Results\" --report-file=",REPORT_NAME, " --report-invariant")
	ANALYSE_CMD <- paste(SKYLINE,TRANSITIONS,SKYD,IN,REPORT_a, sep = " ")

	system(ANALYSE_CMD, intern = FALSE)
	}

  
  
  
  
  
  
  
