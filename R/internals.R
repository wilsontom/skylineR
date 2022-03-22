#' Validate phenoData
#'
#' @param x a `data.frame` of `fileName` and `sampleName`
#' @param object a `skyline` object containing filepaths
#' @return NULL
#' @keywords internal

validate_phenoData <- function(x, object)
  {
  #name_dict <- c("fileName", "name")

  name_check <- names(x) == c("fileName", "name")

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
  #nmRef <- c("MoleculeGroup","PrecursorName", "PrecursorRT","PrecursorMz", "ProductMz","PrecursorCharge", "ProductCharge")
  nmRef <- c('name', 'rt', 'parent', 'product', 'charge')
  nmCh <- names(x) == nmRef

  if(any(nmCh == FALSE)){
    stop(deparse(substitute(x))," has incorrect column names. Refere to ... for more hep", call. = FALSE)
  }

  # check values
  transCh <- x[,'product'] < x[,'parent']

  if(any(transCh == FALSE)){
    message("WARNING: Product m/z value (Q3mz) found which is greater than precursor m/z value (Q1mz)")
  }


  transitions <- tibble::tibble(
    MoleculeGroup = x$name,
    PrecursorName = x$name,
    PrecursorRT = x$rt,
    PrecursorMz = x$parent,
    ProductMz = x$product,
    PrecursorCharge = x$charge,
    ProductCharge = x$charge
  )


  transitions$PrecursorCharge <-
    stringr::str_replace_all(transitions$PrecursorCharge, '\\+', '1')
  transitions$PrecursorCharge <-
    stringr::str_replace_all(transitions$PrecursorCharge, '\\-','-1')

  transitions$ProductCharge <-
    stringr::str_replace_all(transitions$ProductCharge, '\\+', '1')
  transitions$ProductCharge <-
    stringr::str_replace_all(transitions$ProductCharge, '\\-','-1')


  return(transitions)
  }





skyline_docker_runner <- function(object, x)
{

  filepath <- normalizePath(stringr::str_remove_all(x, basename(x)))

  docker_cmd <- glue::glue(
    'docker run --rm -e WINDEDEBUG=-all -v ',
    {
      normalizePath(object@path)
    },
    ':/data -v ',
    {
      filepath
    },
    ':/files chambm/pwiz-skyline-i-agree-to-the-vendor-licenses wine SkylineCmd'
  )

  renametmp <-
    stringr::str_replace(basename(x), '.mzML', '.csv')


  xfile <- glue::glue('/files/', {
    basename(x)
  })

  skyline_cmd <-
    glue::glue(
      '--in=',
      'skyline.sky --import-transition-list=',
      'transitions_temp.csv --import-file=',
      {
        xfile
      },
      ' --report-name=\"Transition Results\" --report-file=',
      {
        renametmp
      },
      ' --report-invariant'
    )


  full_cmd <- glue::glue({
    docker_cmd
  }, ' ', {
    skyline_cmd
  })

  system(full_cmd, intern = TRUE)


  return(invisible(NULL))


}
