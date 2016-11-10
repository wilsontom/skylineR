#' addFiles
#' @rdname addFiles
#'
#' @param object a \code{skyline} object
#' @param filepath a valid filepath to directory of \code{.raw} files
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export

setGeneric(name = "addFiles",
           def = function(object, filepath)
           {standardGeneric("addFiles")}
)


#' addInfo
#' @rdname addInfo
#'
#' @param object a \code{skyline} object
#' @param a runinfo \code{data.frame}
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export


setGeneric(name = "addInfo",
           def = function(object, runinfo)
           {standardGeneric("addInfo")}

)


#' addTransitions
#' @rdname addTransitions
#'
#' @param object a \code{skyline} object
#' @param a \code{data.frame} of transition information. The \code{data.frame} must contain the following columns;
#' PrecursorName, PrecursorRT, PrecursorMz, ProductMz,PrecursorCharge and ProductCharge
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export


setGeneric(name = "addTransitions",
           def = function(object, transitionList)
           {standardGeneric("addTransitions")}

)
