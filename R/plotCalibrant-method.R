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

					plot1 <- ggplot(cali_plot, aes_string(x = 'x', y = 'y')) + geom_point(size = 2) + theme_bw() +
													geom_smooth(se = FALSE,method = "lm" , colour = "red", size = 0.5) +
													geom_smooth(se = FALSE,method = "loess", colour = "blue", size = 0.5)


          if(type == "ratio"){
             plot2  <- plot1 + labs(x = expression(paste("Concentration (",mu,"g/ml)")), y = "Area (ratio to IS)")
          }
          if(type == "raw"){
              plot2  <- plot1 + labs(x = expression(paste("Concentration (",mu,"g/ml)")), y = "Area")
          }

            print(plot2)

            return(invisible(NULL))
          }
)
