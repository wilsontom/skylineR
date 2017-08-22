#' Skyline
#'
#' An \code{S4} class for performing quantitative analysis of SRM-MS data using \code{skyline}
#'
#' @slot env class environment
#' @slot SkylinePath character of path to \code{SkylineRunner.exe}
#' @slot SkylineTransition character of path to Skyline transition file (\code{.sky})
#' @slot tempPath character of path where temporary files are written to
#' @slot phenoData a runinfo \code{data.frame}
#' @slot transitions a \code{data.frame} of transition information. The transitions must be identical to those in the \code{SkyTransitionFile.sky}
#' @slot filePaths a character vector of \code{.raw} filepaths
#' @slot peakInfo a list of peak picking results
#' @slot internalStd a \code{data.frame} of peak information for the internal standard (IS) in each sample

setClass(Class = "skyline", representation = representation(
  env = "environment",
  SkylinePat = "character",
  SkylineTransition = "character",
  tempPath = "character",
  phenoData = "data.frame",
  transitions = "data.frame",
  filePaths = "character",
  peakInfo = "list",
  internalStd = "data.frame"
  )
)
