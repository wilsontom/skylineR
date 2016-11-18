#' Fit equation to calibration curve
#'
#' Select an equation type to use during calibration and subsequent quantificatin
#'
#' @param x a numeric vector of the predictor variable (concentration)
#' @param y a numeric vector of the response variable (peak area)
#' @param type a character string indicating which equation to use; \code{Lin} = Linear. \code{Quad} = Quadratic,
#' \code{LogLog} = Logarithimic and \code{Quad-LogLog} = Quadratic-Logarithmic.
#' @return a \code{lm} model object
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @keywords internal


fitCurve <- function(x, y, type = "Quad-LogLog")
  {

  if(type == "Quad-LogLog"){
    fitMod <- lm(log10(x) ~ log10(y) + I(log10(y) ^ 2))
  }

  if(type == "LogLog"){
    fitMod <- lm(log10(x) ~ log10(y))
  }

  if(type == "Quad"){
    fitMod <- lm(x ~ y + I(y) ^ 2)
  }

  if(type == "Lin"){
    fitMod <- lm(x ~ y)
  }

  return(fitMod)
  }
