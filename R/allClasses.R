#' Skyline
#'
#' An \code{S4} class for performing quantitative analysis of SRM-MS data using \code{skyline}
#'
#' @slot env class environment
#' @slot SkylinePath character of path to \code{SkylineRunner.exe}
#' @slot SkylineTransition character of path to Skyline transition file (\code{.sky})
#' @slot tempPath character of path where temporary files are written to
#' @slot runinfo a runinfo \code{data.frame}
#' @slot transitions a \code{data.frame} of transition information. The transitions must be identical to those in the \code{SkyTransitionFile.sky}
#' @slot filepaths a character vector of \code{.raw} filepaths
#' @slot peakInfo a \code{data.frame} of peak picking results
#' @slot calibrants a \code{data.frame} of calibrant data
#' @slot quant a \code{data.frame} of results


setClass(Class = "skyline", representation = representation(
  env = "environment",
  SkylinePath = "character",
  SkylineTransition = "character",
  tempPath = "character",
  runinfo = "data.frame",
  transitions = "data.frame",
  filepaths = "character",
  peakInfo = "data.frame",
  calibrants = "data.frame",
  quant = "data.frame")
)
