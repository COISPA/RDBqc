#' Check coverage of GFCM task II.2 table
#'
#' @description The function checks and count the numbers of records data in the given task II.2 table grouped by year, GSA, MS, species, and segment for two variables (Total landing (ton) and total discards (ton)). If SP and segment are not specified by the user the function combines those by default.
#' @param data GFCM task II.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format ("COMBINED" values perform the analysis for all species present in data)
#' @param segment segment code ("COMBINED" values perform the analysis for all segments present in data)
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list. The first element gives the summary table of records number. From the second to the third element gives 2 plots for total live landing and total discards (ton)).
#' @export
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples GFCM_cov_II2(data = task_ii2, MS = "ITA", GSA = "18", SP = "HKE", segment = "COMBINED")
#' @import tidyverse
#' @importFrom tidyr drop_na

GFCM_cov_II2 <- function(data, MS, SP = "COMBINED", segment = "COMBINED", GSA, verbose = TRUE) {

  colnames(data) <- tolower(colnames(data))
  reference_year <- gsa <- cpc <- species <-  landing <- discards <- tot_landing <- tot_discards <- NULL

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available"))
    }
    output <- NULL
  } else {


  # check of the species, combined vs specific species defined by the user
  if (length(SP) == 1 & SP[1] == "COMBINED") {
    data$species <- "COMBINED"
  } else {
    data <- data[data$species %in% SP, ]
  }


  # check of the segment, combined vs specific segment defined by the user
  if (length(segment) == 1 & segment[1] == "COMBINED") {
    data$segment <- "COMBINED"
  } else {
    data <- data[data$segment %in% segment, ]
  }

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for selected metiers and fishing techniques"))
    }
  } else {

    data$landing <- as.numeric(data$landing)

    # Summary Table of records number
    suppressMessages(data1 <- data %>%
      # drop_na(reference_year, gsa, cpc, species, segment) %>%
      select(reference_year, gsa, cpc, species, segment, landing, discards) %>%
      filter(gsa %in% GSA & cpc %in% MS & species %in% SP) %>%
      group_by(reference_year, gsa, cpc, species, segment) %>%
      summarise(total_landing = sum(!is.na(landing)), tot_discards = sum(!is.na(discards))))

    if (nrow(data1) == 0) {
      if (verbose) {
        message(paste0("No data available for the selected species (", SP, ")"))
      }
      output <- NULL
    } else {
      data2 <- data
      data2[is.na(data2)] <- 0
      suppressMessages(data3 <- data2 %>%
        # drop_na(reference_year, gsa, cpc, species, segment) %>%
        select(reference_year, gsa, cpc, species, segment, landing, discards) %>%
        filter(gsa %in% GSA & cpc %in% MS & species %in% SP) %>%
        group_by(reference_year, gsa, cpc, species, segment) %>%
        summarise(
          tot_landing = sum(landing,na.rm=TRUE),
          tot_discards = sum(discards,na.rm=TRUE)
        ))

      # Plots
      ny <- length(seq(min(data$reference_year),max(data$reference_year),1))
      if (ny < 4) {
        ny <- 1
      } else {
        ny <- 4
      }

      suppressMessages(plot1 <- data3 %>%
        ggplot(aes(x = reference_year, y = tot_landing, col = segment)) +
        geom_point() +
        geom_line() +
        scale_x_continuous(breaks = seq(min(data3$reference_year), max(data3$reference_year), ny)) +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste(MS, "total landing of", SP, "in GSA", GSA)) +
        ylab("Total landing (tonnes)") +
        xlab("year")
        # + facet_wrap(~segment)
        )


      suppressMessages(plot2 <- data3 %>%
        ggplot(aes(x = reference_year, y = tot_discards, col = segment)) +
        geom_point() +
        geom_line() +
        scale_x_continuous(breaks = seq(min(data3$reference_year), max(data3$reference_year), ny)) +
        theme(
          axis.text.x = element_text(size = 15, angle = 0, colour = "black"),
          axis.text.y = element_text(size = 15, colour = "black"),
          axis.title = element_text(size = 15),
          plot.title = element_text(hjust = 0.5, size = 15)
        ) +
        ggtitle(paste(MS, "total discards of", SP, "in GSA", GSA)) +
        ylab("Total discards (tonnes)") +
        xlab("year")
        # + facet_wrap(~segment)
        )

      output <- list(as.data.frame(data1), as.data.frame(data3), suppressMessages(plot1), suppressMessages(plot2))
      names(output) <- c("number_of_records", "summary_table", "total_landings", "total_discards")


    }
  }
  }

  return(output)
}
