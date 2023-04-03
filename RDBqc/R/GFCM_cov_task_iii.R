#' Check number of individuals in GFCM Task III table
#'
#' @description The function checks the consistencies of the total number of individual caught in comparison with the sum of the individuals alive, dead and released reported in Task III table.
#' @param data Task III table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list. The first element is a table reporting the inconsistencies of the total individual caught in comparison to the sum of the individuals alive, dead and released. The second element of the list is a plot of the time series of the individuals caught by year, source, and gear.
#' @export
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples
#' GFCM_cov_task_iii(
#'   data = task_iii, SP = "Dasyatis pastinaca",
#'   MS = "ITA", GSA = "18"
#' )
#' @import tidyverse
#' @importFrom tidyr drop_na

GFCM_cov_task_iii <- function(data, MS, GSA, SP = "COMBINED", verbose = TRUE) {
  CPC <- Gear <- L50 <- Length <- NumberAlive <- NumberCaught <- NumberDead <-
    NumberIndividuals <- NumberIndividualsExpanded <- NumberReleased <-
    Reference_Year <- Segment <- Sex <- Source <- Species <- WeightCaught <- tot_Caught <- NULL
  year <- country <- species <- segment <- NULL

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available"))
    }
    output <- NULL
  } else {

    # check of the species, combined vs specific species defined by the user
    if (length(SP) == 1 & SP[1] == "COMBINED") {
      data$Species <- "COMBINED"
    } else {
      data <- data[data$Species %in% SP, ]
    }

    if (nrow(data) == 0) {
      if (verbose) {
        message(paste0("No data available for selected segments"))
      }
    } else {
      data[data == "NA"] <- NA
      data[data$Gear == "", "Gear"] <- "NA"

      # Summary Table
      suppressMessages(data1 <- data %>%
        drop_na(Reference_Year, GSA, CPC, Species) %>%
        select(
          Reference_Year, GSA, CPC, Species, Source, Segment, Gear, NumberCaught, WeightCaught,
          NumberAlive, NumberDead, NumberReleased
        ) %>%
        filter(GSA %in% GSA & CPC %in% MS & Species %in% SP) %>%
        group_by(Reference_Year, Source, Gear) %>%
        summarise(tot_Caught = sum(NumberCaught, na.rm = TRUE), NumberAlive = sum(NumberAlive, na.rm = TRUE), NumberDead = sum(NumberDead, na.rm = TRUE), NumberReleased = sum(NumberReleased, na.rm = TRUE)))

      data1$Sum_Individuals <- rowSums(data1[, c(5:7)])
      data1 <- data1[, c(1:4, 8)]
      data1$check <- data1$tot_Caught - data1$Sum_Individuals

      # summary table of inconsistencies between total individuals caught and the sum of the individuals alive, dead and released
      table1 <- as.data.frame(data1)
      table1 <- table1[table1$check != 0, ]

      if (nrow(table1) > 0) {
        table1$check <- "Inconsitence in the number of individuals reported"
      }

      if (nrow(data1) == 0) {
        if (verbose) {
          message(paste0("No data available for the selected species (", SP, ")"))
        }
        output <- NULL
      } else {
        data2 <- data1
        data2[is.na(data2)] <- 0

        # Plot of tot_Caught
        suppressMessages(plot1 <- data1 %>%
          ggplot(aes(x = Reference_Year, y = tot_Caught, col = Gear, linetype = Gear)) +
          geom_point(size = 2) +
          geom_line() +
          scale_x_continuous(breaks = seq(min(data1$Reference_Year), max(data1$Reference_Year), 4)) +
          theme(
            axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
            axis.text.y = element_text(size = 15, colour = "black"),
            axis.title = element_text(size = 15),
            plot.title = element_text(hjust = 0.5, size = 15)
          ) +
          ggtitle(paste(MS, " - Total individuals caught in GSA", GSA)) +
          ylab("Total individuals caught") +
          xlab("Year") +
          facet_wrap(~Source))

        output <- list(as.data.frame(table1), suppressMessages(plot1))
        names(output) <- c("summary_of_inconsistencies", "plot")
      }
    }
  }
  return(output)
}
