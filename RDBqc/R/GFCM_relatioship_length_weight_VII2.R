#' Plot of the length-weight relationship
#'
#' @description Function to check the consistency of length-weight relationship in the GFCM Task VII.2 table for the selected species.
#' @param data GFCM Task VII.2 table
#' @param MS country code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @return The function return a plot of the length weight relationship for the selected species.
#' @export
#' @import ggplot2
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")
check_lw_TaskVII.2 <- function(data, MS, GSA, SP, verbose = TRUE) {

  # check format of headers
  data <- GFCM_check_headers(data, "task7.2")

  Length <- Reference_Year <- WeightIndividualsSampled <- NULL
  data <- data[data$CPC %in% MS & data$GSA %in% GSA & data$Species %in% SP, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No landing data available for the selected species (", SP, ")"))
    }
  } else {
    data$Length <- as.numeric(data$Length)
    data$WeightIndividualsSampled <- as.numeric(data$WeightIndividualsSampled)
    data$Reference_Year <- as.factor(data$Reference_Year)
    plot <- ggplot(data, aes(x = Length, y = WeightIndividualsSampled, color = Reference_Year)) +
      geom_point(size = 2) +
      facet_wrap(Reference_Year ~ ., ncol = 5, scales = "free") +
      theme(
        axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, size = 15)
      ) +
      xlab("Length") +
      ylab("Weight (kg)") +
      guides(color = guide_legend(title = "Year")) +
      ggtitle(SP)

    return(plot)
  }
}
