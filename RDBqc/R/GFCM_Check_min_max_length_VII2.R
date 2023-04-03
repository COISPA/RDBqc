#'  Comparison between min/max observed for each species with theoretical values
#'
#' @description Function to verify the consistency of the lengths reported in the TaskVII.2 table with the theoretical values reported in the minmaxLtaskVII2 table. The function allows to identify the records in which the observed lengths are greater or lower than the expected ones.
#' @param data GFCM Task II.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a table with the comparison between min/max lengths observed for each species with theoretical values.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_minmaxl_TaskVII.2(task_vii2, minmaxLtaskVII2, MS = "ITA", GSA = "18")
check_minmaxl_TaskVII.2 <- function(data, MS, GSA, SP, verbose = TRUE) {
  CPC <- Gear <- L50 <- Length <- NumberAlive <- NumberCaught <- NumberDead <-
    NumberIndividuals <- NumberIndividualsExpanded <- NumberReleased <-
    Reference_Year <- Segment <- Sex <- Source <- Species <- WeightCaught <- tot_Caught <- NULL

  data <- data[data$CPC %in% MS & data$GSA %in% GSA, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message("No data for the selected Country and GSA combination. ")
    }
    return(NULL)
  } else {
    data1 <- suppressMessages(
      data %>% group_by(Reference_Year, Source, Segment, Length) %>% summarise(NumberIndividuals = sum(NumberIndividualsExpanded, na.rm = TRUE))
    )

    # Plot of tot_Caught
    suppressMessages(plot1 <- data1 %>%
      ggplot(aes(x = Length, y = NumberIndividuals, col = Source, linetype = Source)) +
      geom_point(size = 2) +
      geom_line() +
      scale_x_continuous(breaks = seq(min(data1$Length), max(data1$Length), 4)) +
      theme(
        axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, size = 15)
      ) +
      ggtitle(paste(MS, " - Total individuals caught (expanded) in GSA", GSA)) +
      ylab("Total individuals caught") +
      xlab("Year") +
      facet_wrap(Reference_Year ~ Source))
  }
}
