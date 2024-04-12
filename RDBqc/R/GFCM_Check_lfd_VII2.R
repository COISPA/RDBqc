#'  Consistency of length frequency distributions
#'
#' @description Function to verify the consistency of the length frequency distributions (LFD) reported in the TaskVII.2 table. The functions generates plots of the LFD by species, source, segment and year.
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
#' @examples check_ldf_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "HKE")
check_ldf_TaskVII.2 <- function(data, MS, GSA, SP, verbose = TRUE) {

  # check format of headers
  data <- GFCM_check_headers(data, "task7.2")

  CPC <- Gear <- L50 <- Length <- NumberAlive <- NumberCaught <- NumberDead <-
    NumberIndividuals <- NumberIndividualsExpanded <- NumberReleased <-
    Reference_Year <- Segment <- Sex <- Source <- Species <- WeightCaught <- tot_Caught <- NULL

  data <- data[data$CPC == MS & data$GSA %in% GSA & data$Species %in% SP, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message("No data for the selected Country and GSA combination. ")
    }
    return(NULL)
  } else {
    data1 <- suppressMessages(
      data %>% group_by(Reference_Year, Source, Segment, Length) %>% summarise(NumberIndividuals = sum(NumberIndividualsExpanded, na.rm = TRUE))
    )

    plots <- list()
    data_BS <- data1[data1$Source == "BS", ]
    if (nrow(data_BS)>0){
    source <- "BS"
    data_BS$Segment[is.na(data_BS$Segment)] <- "NA"
    # Plot of tot_Caught
    suppressMessages(plot1 <- data_BS %>%
      ggplot(aes(x = Length, y = NumberIndividuals, col = Segment)) +
      geom_line(size = 0.8) +
      scale_x_continuous(breaks = seq(trunc(min(data_BS$Length)), trunc(max(data_BS$Length)), (max(data_BS$Length) - min(data_BS$Length)) %/% 5)) +
      theme(
        axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, size = 15)
      ) +
      ggtitle(paste(MS, " - Total individuals caught (expanded) in GSA", GSA, "(BS)")) +
      ylab("Total individuals caught") +
      xlab("Year") +
      facet_wrap(~Reference_Year))

      plots[[1]] <- plot1
    } else {
      n <- length(plots)
      plots[[1]] <- NA
     }

    data_SU <- data1[data1$Source == "SU", ]
    if (nrow(data_SU)>0){
    source <- "SU"
    data_SU$Segment[is.na(data_SU$Segment)] <- "NA"
    # Plot of tot_Caught
    suppressMessages(plot2 <- data_SU %>%
      ggplot(aes(x = Length, y = NumberIndividuals, col = Segment)) +
      geom_line(size = 0.8) +
      scale_x_continuous(breaks = seq(trunc(min(data1$Length)), trunc(max(data1$Length)), (max(data_SU$Length) - min(data_SU$Length)) %/% 5)) +
      theme(
        axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
        axis.text.y = element_text(size = 15, colour = "black"),
        axis.title = element_text(size = 15),
        plot.title = element_text(hjust = 0.5, size = 15)
      ) +
      ggtitle(paste(MS, " - Total individuals caught (expanded) in GSA", GSA, "(SU)")) +
      ylab("Total individuals caught") +
      xlab("Year") +
      facet_wrap(~Reference_Year))

    plots[[2]] <- plot2
    } else {
      n <- length(plots)
      plots[[2]] <- NA
      # plots[[2]] <- NULL
    }
    return(plots) # list(plot1, plot2)
  }
}
