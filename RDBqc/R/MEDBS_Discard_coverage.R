#' Check the coverage of discard data
#'
#' @param Discard_tab Discard table in MED&BS format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the coverage of the time series in discard table for a selected species.
#' @return A summary table and a plot of discard time series by year and gear are returned.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_discard_coverage(Discard_tab_example, "DPS", "ITA", "GSA 9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
MEDBS_discard_coverage <- function(Discard_tab, SP, MS, GSA, verbose = TRUE) {
  discards <- landings <- country <- area <- year <- quarter <- vessel_length <- gear <- mesh_size_range <- species <- fishery <- NULL

  colnames(Discard_tab) <- tolower(colnames(Discard_tab))
  Discard_tab <- Discard_tab[Discard_tab$species == SP & Discard_tab$country == MS & Discard_tab$area == GSA, ]

  Discard_tab[is.na(Discard_tab$vessel_length), "vessel_length"] <- "NA"
  Discard_tab[is.na(Discard_tab$gear), "gear"] <- "NA"
  Discard_tab[is.na(Discard_tab$mesh_size_range), "mesh_size_range"] <- "NA"
  Discard_tab[is.na(Discard_tab$fishery), "fishery"] <- "NA"

  if (nrow(Discard_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    if (length(Discard_tab$Discard_tab[Discard_tab$discards == -1, "discards"]) > 0) {
      Discard_tab$Discard_tab[Discard_tab$discards == -1, "discards"] <- 0
    }
    Summary_land_wt <- data.frame(Discard_tab %>% group_by(country, year, quarter, vessel_length, gear, mesh_size_range, fishery, area, species) %>% summarise(discards = sum(discards, na.rm = TRUE)))

    if (length(which(round(Summary_land_wt$discards, 2) == -1)) > 0) {
      Summary_land_wt <- Summary_land_wt[-which(round(Summary_land_wt$discards, 2) == -1), ]
    }

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_land_wt
    names(output)[[l]] <- "summary table"

    Discard_tab$Discard_tab[Discard_tab$discards == -1] <- 0
    suppressMessages(land_wt <- Discard_tab %>%
      group_by(country, area, year, quarter, vessel_length, gear, mesh_size_range, fishery) %>% summarize(discards = sum(discards, na.rm = TRUE)))

    suppressMessages(data <- Discard_tab %>%
      group_by(year, gear) %>%
      summarise(discards = sum(discards, na.rm = TRUE)))

    gr <- data.frame("year" = seq(min(data$year), max(data$year), 1), "gear" = rep(unique(data$gear), each = max(data$year) - min(data$year) + 1))

    suppressMessages(data <- full_join(gr, data))

    data[is.na(data)] <- 0

    p <- ggplot(data, aes(x = year, y = discards, fill = gear)) +
      geom_area(size = 0.5, colour = "black") +
      theme_bw() +
      ggtitle(paste0("Discards of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$year), max(data$year), 2))

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("Discards_GEAR", SP, MS, GSA, sep = " _ ")

    return(output) # Summary_land_wt
  }
}
