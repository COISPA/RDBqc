#' Check the coverage of Catch table
#'
#' @param data Catch table in MEDBS format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the coverage of Catch table by mean of summary tables summarizing both landing and discard volumes and producing relative plots for the selected species.
#' @return The function returns two summary tables: one for landing coverage and the other for discard coverage. Furthermore, plots of landings and discards by gear are also returned
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_Catch_coverage(Catch_tab_example, "DPS", "ITA", "GSA 9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables

MEDBS_Catch_coverage <- function(data, SP, MS, GSA, verbose = TRUE) {
  colnames(data) <- tolower(colnames(data))
  data[is.na(data$vessel_length), "vessel_length"] <- "NA"
  data[is.na(data$gear), "gear"] <- "NA"
  data[is.na(data$mesh_size_range), "mesh_size_range"] <- "NA"
  data[is.na(data$fishery), "fishery"] <- "NA"

  discards <- landings <- country <- area <- year <- quarter <- vessel_length <- gear <- mesh_size_range <- fishery <- species <- NULL
  catch <- data
  catch <- catch[catch$species == SP & catch$country == MS & catch$area == GSA, ]

  if (nrow(catch) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(catch) > 0) {
    Summary_land_wt <- data.frame(catch[catch$landings != -1, ] %>% group_by(
      country, year, quarter, vessel_length, gear,
      mesh_size_range, fishery, area, species
    ) %>% summarise(landings = sum(landings, na.rm = TRUE)))

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_land_wt
    names(output)[[l]] <- "summary_landing_table"

    Summary_disc_wt <- data.frame(catch[catch$discards != -1, ] %>% group_by(country, year, quarter, vessel_length, gear, mesh_size_range, fishery, area, species) %>% summarise(discards = sum(discards, na.rm = TRUE)))

    if (length(which(round(Summary_disc_wt$discards, 2) == -1)) > 0) {
      Summary_disc_wt <- Summary_disc_wt[-which(round(Summary_disc_wt$discards, 2) == -1), ]
    }

    l <- length(output) + 1
    output[[l]] <- Summary_disc_wt
    names(output)[[l]] <- "summary_discard_table"

    # Plot 1
    ## LANDINGS ##
    catch$landings[catch$landings == -1] <- 0
    catch_land_wt <- catch %>%
      group_by(country, area, year, quarter, vessel_length, gear, mesh_size_range, fishery) %>%
      summarize(landings = sum(landings, na.rm = TRUE))

    data <- catch %>%
      group_by(year, gear) %>%
      summarise(landings = sum(landings, na.rm = TRUE))

    gr <- data.frame("year" = seq(min(data$year), max(data$year), 1), "gear" = rep(unique(data$gear), each = max(data$year) - min(data$year) + 1))

    data <- full_join(gr, data)

    data[is.na(data)] <- 0


    p <- ggplot(data, aes(x = year, y = landings, fill = gear)) +
      geom_area(size = 0.5, colour = "black") +
      ggtitle(paste0("Landings in catch of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$year), max(data$year), 2))

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- "landings"



    # Plot 2
    ## DISCARDS ##
    catch$discards[catch$discards == -1] <- 0
    catch_disc_wt <- catch %>%
      group_by(country, area, year, quarter, vessel_length, gear, mesh_size_range, fishery) %>%
      summarize(discards = sum(discards, na.rm = TRUE))

    data <- catch %>%
      group_by(year, gear) %>%
      summarise(discards = sum(discards))

    gr <- data.frame("year" = seq(min(data$year), max(data$year), 1), "gear" = rep(unique(data$gear), each = max(data$year) - min(data$year) + 1))

    data <- full_join(gr, data)

    data[is.na(data)] <- 0

    p <- ggplot(data, aes(x = year, y = discards, fill = gear)) +
      geom_area(size = 0.5, colour = "black") +
      theme_bw() +
      ggtitle(paste0("Discards in catch of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$year), max(data$year), 2))
    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- "discards"
    return(output)
  }
}
