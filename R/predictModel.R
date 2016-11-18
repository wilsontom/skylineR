#' Predict values
#'
#' Predict concentration values using response variable and a calibration model
#'
#' @param m a \code{lm} model object. \seealso{\link{fitCurve}}
#' @param y a numeric vector of the response variable (peak area)
#' @return a numeric vector of predicted values
#'
#' @author Tom Wilson \email{tpw2@@aber.ac.uk}
#' @keywords internal

predictModel <- function(m, y)
  {

  if(!inherits(m, "lm")){stop("model input (m) must be `lm` class", call. = FALSE)}

   if(m$call == "lm(formula = log10(x) ~ log10(y) + I(log10(y)^2))" | m$call == "lm(formula = log10(x) ~ log10(y))"){
    new_x <- 10 ^ predict(m, data.frame(y))
  }

  if(m$call == "lm(formula = x ~ y)" | m$call == "lm(formula = x ~ y + I(y)^2)"){
    new_x <- predict(m, data.frame(y))
  }

  return(as.numeric(new_x))
  }
