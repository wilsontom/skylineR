#' add_files
#'
#' @rdname add_files
#' @param object a \code{skyline} object
#' @param files a vector of valid file (`.raw`, `.mzML` or `.mxXML`) locations for analysis
#' @return NULL
#'
#' @export

setGeneric(name = "add_files",
             def = function(object, files)
               {standardGeneric("add_files")}
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
#' name, rt, parent, product, charge
#' @return NULL
#'
#' @export


setGeneric(name = "add_transitions",
           def = function(object, transitions)
           {standardGeneric("add_transitions")}

)



#' add_path
#'
#' @rdname add_path
#' @param object a \code{skyline} object
#' @param path a character string a an existing directory to be used for temporary file writing
#' @return NULL

#' @export

setGeneric(name = "add_path",
           def = function(object, path)
           {standardGeneric("add_path")}

)



#' get_peakInfo
#' @rdname get_peakInfo
#' @param object a \code{skyline} object
#' @return NULL
#'
#' @export
#' @importFrom utils read.csv write.csv
#' @importFrom dplyr  %>% bind_rows
#' @importFrom purrr map

setGeneric(name = "get_peakInfo",
			def = function(object)
			{standardGeneric("get_peakInfo")}
)


