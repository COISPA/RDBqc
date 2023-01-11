#' Plot of total discards
#'
#' @param data data frame containing discard data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param by string defining the temporal aggregation level of discard data to be plotted. Allowed values are: "year" and "quarter
#' @description The function estimates the total discard time series by both year and quarters for a selected combination of member state, GSA and species.
#' @return The function returns a plot of the total discard time series by year or by quarters. The plot by year also reports the landing by gear.
#' @export MEDBS_plot_discard_ts
#' @examples MEDBS_plot_discard_ts(data = Discard_tab_example, SP = "DPS",
#' MS = "ITA", GSA = "GSA 9", by = "quarter")
#' MEDBS_plot_discard_ts(data = Discard_tab_example, SP = "DPS",
#' MS = "ITA", GSA = "GSA 9", by = "year")
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @importFrom ggplot2 ggplot aes geom_area theme_bw scale_x_continuous ggtitle labs
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize
#' @importFrom utils globalVariables
MEDBS_plot_discard_ts <- function(data, SP, MS, GSA, by = "year") {
  if (FALSE) {
    MS <- "GRC"
    GSA <- "GSA 22"
    SP <- "MUT"
    by <- "year" # "quarter"
    verbose <- TRUE
    data <- discards # Discard_tab_example
    Discard_tab_example$gear <- NA
    MEDBS_plot_discard_ts(data = discards, SP = "MUT", MS = "GRC", GSA = "GSA 22", by = "year")
  }

  year <- gear <- discards <- quarter <- tot <- NULL # in combination with @importFrom utils globalVariables

  colnames(data) <- tolower(colnames(data))
  disc <- data
  # disc$area <- as.numeric(gsub("[^0-9.-]+","\\1",disc$area))
  disc <- disc[which(disc$area == as.character(GSA) & disc$country == MS & disc$species == SP), ]


  if (nrow(disc) > 0) {
    disc[is.na(disc$gear), "gear"] <- "NA"
    disc$discards[disc$discards == -1] <- 0

    suppressMessages(disc_tmp <- as.data.frame(disc %>% group_by(year, gear) %>% summarize(tot = sum(discards))))
    gear_tmp <- data.frame("year" = rep(min(disc_tmp$year):max(disc_tmp$year)), "gear" = rep(unique(disc_tmp$gear), each = (max(disc_tmp$year) - min(disc_tmp$year) + 1))) # unique(disc_tmp$year)
    suppressMessages(discqrt_tmp <- as.data.frame(disc %>% group_by(year, quarter) %>% summarize(tot = sum(discards))))
    quarter_tmp <- data.frame("year" = rep(min(disc_tmp$year):max(disc_tmp$year)), "quarter" = rep(unique(discqrt_tmp$quarter), each = (max(disc_tmp$year) - min(disc_tmp$year) + 1))) # unique(discqrt_tmp$year)

    suppressMessages(tmpdiscq <- dplyr::left_join(quarter_tmp, discqrt_tmp))
    tmpdiscq[is.na(tmpdiscq[, 3]), 3] <- 0

    if (by == "quarter") {
      plot <- ggplot(tmpdiscq, aes(x = year, y = tot, fill = as.factor(quarter))) +
        geom_area(colour = "black", size = .2, alpha = .8) +
        theme_bw() +
        scale_x_continuous(breaks = seq(min(quarter_tmp$year), max(quarter_tmp$year), 2)) +
        ggtitle(paste0(SP, " ", MS, " ", GSA, " Total discard by quarter")) +
        labs(x = "", y = "Tonnes", fill = "Quarter")
    } else if (by == "year") {
      suppressMessages(tmpdisc <- dplyr::left_join(gear_tmp, disc_tmp))
      tmpdisc[is.na(tmpdisc[, 3]), 3] <- 0
      tmpdisc$gear <- as.factor(tmpdisc$gear)
      plot <- ggplot(tmpdisc, aes(x = year, y = tot, fill = gear)) +
        geom_area(colour = "black", size = .2, alpha = .8) +
        theme_bw() +
        scale_x_continuous(breaks = seq(min(disc_tmp$year), max(gear_tmp$year), 2)) +
        ggtitle(paste0(SP, " ", MS, " ", GSA, " Total discard by gear")) +
        labs(x = "", y = "Tonnes", fill = "Gear")
    }

    print(plot)
  } else {
    message("No discard data in the subset.\n")
  }
}
