#' addFiles
#' @rdname addFiles
#'
#' @param object a \code{Skyline} object
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
#' @param object a \code{Skyline} object
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
#' @param object a \code{Skyline} object
#' @param a \code{data.frame} of transition information
#' @return NULL
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @export


setGeneric(name = "addTransitions",
           def = function(object, transitionList)
           {standardGeneric("addTransitions")}

)
