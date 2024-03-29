#' Plot of total landing time series
#'
#' @param data data frame containing landing data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param by string defining the temporal aggregation level of landing data to be plotted. Allowed values are: "year" and "quarter"
#' @param verbose boolean. If TRUE messages are returned
#' @description The function estimates the total landings time series by both year and quarters for a selected combination of member state, GSA and species.
#' @return The function returns a plot of the total landing time series by year or by quarters. The plot by year also reports the landing by gear.
#' @export MEDBS_plot_landing_ts
#' @examples MEDBS_plot_landing_ts(
#'   data = Landing_tab_example, SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", by = "quarter"
#' )
#' MEDBS_plot_landing_ts(
#'   data = Landing_tab_example, SP = "DPS", MS = "ITA",
#'   GSA = "GSA 9", by = "year"
#' )
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#'
#' @importFrom ggplot2 ggplot aes geom_area theme_bw scale_x_continuous ggtitle labs
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by summarize
#' @importFrom utils globalVariables
MEDBS_plot_landing_ts <- function(data, SP, MS, GSA, by = "year", verbose = TRUE) {
  year <- gear <- landings <- quarter <- tot <- NULL

  colnames(data) <- tolower(colnames(data))
  land <- data
  land <- land[which(land$area == as.character(GSA) & land$country == MS & land$species == SP), ]

  if (nrow(land) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    land[is.na(land$gear), "gear"] <- "NA"
    land$landings[land$landings == -1] <- 0
    land_tmp <- suppressMessages(as.data.frame(land %>% group_by(year, gear) %>% summarize(tot = sum(landings))))
    gear_tmp <- data.frame("year" = rep(seq(min(land_tmp$year), max(land_tmp$year))), "gear" = rep(unique(land_tmp$gear), each = (max(land_tmp$year) - min(land_tmp$year) + 1)))
    landqrt_tmp <- suppressMessages(as.data.frame(land %>% group_by(year, quarter) %>% summarize(tot = sum(landings))))
    quarter_tmp <- data.frame("year" = rep(seq(min(land_tmp$year), max(land_tmp$year))), "quarter" = rep(unique(landqrt_tmp$quarter), each = (max(land_tmp$year) - min(land_tmp$year) + 1)))

    tmplandq <- suppressMessages(dplyr::left_join(quarter_tmp, landqrt_tmp))
    tmplandq[is.na(tmplandq[, 3]), 3] <- 0

    if (by == "quarter") {
      plot <- ggplot(tmplandq, aes(x = year, y = tot, fill = as.factor(quarter))) +
        geom_area(colour = "black", size = .2, alpha = .8) +
        theme_bw() +
        scale_x_continuous(breaks = seq(min(quarter_tmp$year), max(quarter_tmp$year), 2)) +
        ggtitle(paste0(SP, " ", MS, " ", GSA, " Total landing by quarter")) +
        labs(x = "", y = "Tonnes", fill = "Quarter")
    } else if (by == "year") {
      tmpland <- suppressMessages(dplyr::left_join(gear_tmp, land_tmp))
      tmpland[is.na(tmpland[, 3]), 3] <- 0
      plot <- ggplot(tmpland, aes(x = year, y = tot, fill = gear)) +
        geom_area(colour = "black", size = .2, alpha = .8) +
        theme_bw() +
        scale_x_continuous(breaks = seq(min(gear_tmp$year), max(gear_tmp$year), 2)) +
        ggtitle(paste0(SP, " ", MS, " ", GSA, " Total landing by gear")) +
        labs(x = "", y = "Tonnes", fill = "Gear")
    }
    return(suppressMessages(plot))
  }
}
