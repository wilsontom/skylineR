#' add_filePaths
#'
#' @rdname add_filePaths
#' @param object a \code{skyline} object
#' @param filePaths a vector of valid file (`.raw`, `.mzML` or `.mxXML`) locations for analysis
#' @return NULL
#'
#' @export

setGeneric(name = "add_filePaths",
             def = function(object, filePaths)
               {standardGeneric("add_filePaths")}
)


#' add_phenoData
#'
#' @rdname add_phenoData
#' @param object a \code{skyline} object
#' @param phenoData a runinfo \code{data.frame}
#' @return NULL
#'
#' @export


setGeneric(name = "add_phenoData",
           def = function(object, phenoData)
           {standardGeneric("add_phenoData")}
)


#' add_transitions
#'
#'
#' @rdname add_transitions
#' @param object a \code{skyline} object
#' @param transitions a \code{data.frame} of transition information. The \code{data.frame} must contain the following columns;
#' PrecursorName, PrecursorRT, PrecursorMz, ProductMz,PrecursorCharge and ProductCharge
#' @return NULL
#'
#' @export


setGeneric(name = "add_transitions",
           def = function(object, transitions)
           {standardGeneric("add_transitions")}

)

#' get_peakInfo
#' @rdname get_peakInfo
#' @param object a \code{skyline} object
#' @return NULL
#'
#' @export

setGeneric(name = "get_peakInfo",
			def = function(object)
			{standardGeneric("get_peakInfo")}
)


#' get_internalSTD
#'
#' @rdname get_internalSTD
#' @param object a \code{skyline} object
#' @return NULL
#'
#' @export

setGeneric(name = "get_internalStd",
           def = function(object)
           {standardGeneric("get_internalStd")}
)
