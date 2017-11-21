#' Skyline
#'
#' An \code{S4} class for performing quantitative analysis of SRM-MS data using \code{skyline}
#'
#' @slot env class environment
#' @slot SkylinePath character of path to \code{SkylineRunner.exe}
#' @slot SkylineTransition character of path to Skyline transition file (\code{.sky})
#' @slot path character of path where temporary files are written to
#' @slot phenoData a runinfo \code{data.frame}
#' @slot transitions a \code{data.frame} of transition information. The transitions must be identical to those in the \code{SkyTransitionFile.sky}
#' @slot filepaths a character vector of \code{.raw} filepaths
#' @slot peakInfo a list of peak picking results

setClass(Class = "skyline", slots = c(
  env = "environment",
  SkylinePath = "character",
  SkylineTransition = "character",
  path = "character",
  phenoData = "data.frame",
  transitions = "data.frame",
  filepaths = "character",
  peakInfo = "list"
  ),
  prototype = prototype(
    SkylineTransition = system.file("extdata/skyline.sky", package = "skylineR")
  )
)
