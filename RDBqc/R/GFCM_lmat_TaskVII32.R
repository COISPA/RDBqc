#' Plot of the maturity stages per length for each sex and species
#'
#' @description Function to plot the lengths at maturity stages by species and sex to easily identify outliers.
#' @param data GFCM Task VII.3.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function return a plot of the maturity stages per length and sex per species.
#' @export
#' @import ggplot2
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_lmat_TaskVII.3.2(task_vii32, MS = "ITA", GSA = "18", SP = "CTC")
check_lmat_TaskVII.3.2 <- function(data, MS, GSA, SP, verbose = TRUE) {
  FAU_stage <- Length <- Sex <- NULL

  data <- data[data$CPC == MS & data$GSA %in% GSA & data$Species %in% SP, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message("No data for the selected Country and GSA combination. ")
    }
    return(NULL)
  } else {
    # Simplication of the variable
    data$CATFAU_REV <- substr(data$Maturity, 1, 5)

    absent <- strsplit(data$Maturity, "/")
    absent <- as.data.frame(do.call(rbind, absent))
    colnames(absent) <- c("parte1", "stage")
    data$FAU_stage <- paste(data$CATFAU_REV, absent$stage)

    # Creation of the plot
    plot <- ggplot(data, aes(x = FAU_stage, y = Length, color = Sex, shape = Sex)) +
      geom_point(size = 2, position = position_dodge(0.9)) +
      theme(
        axis.text.x = element_text(size = 15, angle = 270, colour = "black", hjust = 0),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, size = 15)
      ) +
      facet_wrap(~Species, ncol = 4, scales = "free") +
      ylab("Length") +
      xlab("Maturity")
    return(plot)
  }
}
