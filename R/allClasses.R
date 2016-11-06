#' Skyline
#'
#' An \code{S4} class for performing quantitative analysis of SRM-MS data using \code{skyline}
#'
#' @slot env
#' @slot SkylinePath
#' @slot SkylineTransition
#' @slot tempPath
#' @slot runinfo
#' @slot transitions
#' @slot filepaths
#' @slot peakInfo
#' @slot calibrants
#' @slot quant


setClass(Class = "Skyline", representation = representation(
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
