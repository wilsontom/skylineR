#' plotCalibrant
#' @rdname plotCalibrant
#'
#' @description Plot calibration curves
#'
#' @include allGenerics.R
#' @include allClasses.R

setMethod(f = "plotCalibrant", signature = "skyline",
          function(object, name, type){

					cali_plot <- object@calibrants[[name]]

					if(type == "raw"){
						cali_plot <- data.frame(x = cali_plot[,"conc"], y = cali_plot[,"area"])
					}
					if(type == "ratio"){
						cali_plot <- data.frame(x = cali_plot[,"conc"], y = cali_plot[,"area"])
					}

					plot1 <- ggplot(cali_plot, aes_string(x = 'x', y = 'y')) + geom_point(size = 1.5) + theme_bw() +
													geom_smooth(se = FALSE,method = "lm", colour = "red", size = 0.7)

            xcoord <- 0.25 * max(cali_plot[,"x"])
            ycoord <- 0.75 * max(cali_plot[,"y"])

            eqlabel <- lmeqn(x = cali_plot[,"x"], y = cali_plot[,"y"])

            plot2 <-  plot1 + geom_text(aes(x = xcoord, y = ycoord, label = eqlabel), parse = TRUE)

            if(type == "ratio"){
              plot3  <- plot2 + labs(x = expression(paste("Concentration (",mu,"g/ml)")), y = "Area (ratio to IS)")
            }

            if(type == "raw"){
              plot3  <- plot2 + labs(x = expression(paste("Concentration (",mu,"g/ml)")), y = "Area")
            }

            print(plot3)

            return(invisible(NULL))
          }
)
