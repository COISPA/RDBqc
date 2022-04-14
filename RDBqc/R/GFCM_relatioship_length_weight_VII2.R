#' Plot of the relationship length weight for each species
#'
#' @description Function to check the consistency of length-weight relationship in the GFCM Task VII.2 table per species.
#' @param data GFCM Task VII.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @return The function return a plot of the length weight relationship per species.
#' @export
#' @import ggplot2
#'
#' @examples check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")
#'
check_lw_TaskVII.2 <- function(data, MS, GSA, SP, verbose = TRUE) {
  if (FALSE) {
    data <- task_vii2
    MS <- "ITA"
    GSA <- "18"
    SP <- "BOG"
  }
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
    plot <- ggplot(data, aes(x = Length, y = WeightIndividualsSampled, color=Reference_Year)) +
      geom_point(size = 1) +
      facet_wrap(Reference_Year~., ncol = 5, scales = "free") +
      theme(
        strip.text = element_text(size = 7, lineheight = 1.0),
        strip.background = element_rect(
          fill = "grey", colour = "black",
          size = 1
        )
      ) +
      xlab("Length") +
      ylab("Weight (kg)") +
      guides(color=guide_legend(title="Year")) +
        ggtitle(SP)

    return(plot)
  }
}
