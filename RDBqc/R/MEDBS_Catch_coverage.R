#' Catch_cov: function to check the coverage in Catch table
#'
#' @param data Catch table in MEDBS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the coverage in Catch table by mean of summary tables summarizing both landing and discard volumes and producing relative plots for the selected species.
#' @return summary table and plots
#' @export
#' @examples MEDBS_Catch_coverage(Catch_tab_example, "DPS", "ITA", "GSA 9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables

MEDBS_Catch_coverage <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- Catch # Catch_tab_example
    SP <- "DPS"
    MS <- "ITA"
    GSA <- "GSA 18"
    verbose <- TRUE
  }


  DISCARDS <- LANDINGS <- COUNTRY <- AREA <- YEAR <- QUARTER <- VESSEL_LENGTH <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- NULL

  catch <- data
  colnames(catch) <- toupper(colnames(catch))

  catch <- catch[catch$SPECIES == SP & catch$COUNTRY == MS & catch$AREA == GSA, ]

  if (nrow(catch) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(catch) > 0) {
    catch[is.na(catch$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
    catch[is.na(catch$GEAR), "GEAR"] <- "NA"
    catch[is.na(catch$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
    catch[is.na(catch$FISHERY), "FISHERY"] <- "NA"

    Summary_land_wt <- aggregate(catch$LANDINGS, by = list(catch$COUNTRY, catch$YEAR, catch$QUARTER, catch$VESSEL_LENGTH, catch$GEAR, catch$MESH_SIZE_RANGE, catch$FISHERY, catch$AREA, catch$SPECIES), FUN = "sum") # [,2:13]
    colnames(Summary_land_wt) <- c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY", "AREA", "SPECIES", "LANDINGS")

    # Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_land_wt
    names(output)[[l]] <- "summary_landing_table"


    Summary_disc_wt <- aggregate(catch[, 2:13]$DISCARDS, by = list(catch$COUNTRY, catch$YEAR, catch$QUARTER, catch$VESSEL_LENGTH, catch$GEAR, catch$MESH_SIZE_RANGE, catch$FISHERY, catch$AREA, catch$SPECIES), FUN = "sum")
    colnames(Summary_disc_wt) <- c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY", "AREA", "SPECIES", "DISCARDS")

    Summary_disc_wt <- Summary_disc_wt[-which(round(Summary_disc_wt$DISCARDS, 2) == -1), ]
    # Summary_disc_wt[1:nrow(Summary_disc_wt),1:ncol(Summary_disc_wt)]

    l <- length(output) + 1
    output[[l]] <- Summary_disc_wt
    names(output)[[l]] <- "summary_discard_table"

    # Plot 1
    ## LANDINGS AT AGE ####
    catch$LANDINGS[catch$LANDINGS == -1] <- 0
    catch_land_wt <- catch %>%
      group_by(COUNTRY, AREA, YEAR, QUARTER, VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE, FISHERY) %>%
      summarize(LANDINGS = sum(LANDINGS, na.rm = TRUE))

    data <- catch %>%
      group_by(YEAR, GEAR) %>%
      summarise(LANDINGS = sum(LANDINGS, na.rm = TRUE))

    gr <- data.frame("YEAR" = seq(min(data$YEAR), max(data$YEAR), 1), "GEAR" = rep(unique(data$GEAR), each = max(data$YEAR) - min(data$YEAR) + 1), "LAND" = 0)

    data <- full_join(gr, data)

    data[is.na(data)] <- 0


    p <- ggplot(data, aes(x = YEAR, y = LANDINGS, fill = GEAR)) +
      geom_area(size = 0.5, colour = "black") +
      ggtitle(paste0("Landings in catch of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$YEAR), max(data$YEAR), 2))

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- "landings_at_age"



    # Plot 2
    ## DISCARDS AT AGE ####
    catch$DISCARDS[catch$DISCARDS == -1] <- 0
    catch_disc_wt <- catch %>%
      group_by(COUNTRY, AREA, YEAR, QUARTER, VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE, FISHERY) %>%
      summarize(DISCARDS = sum(DISCARDS, na.rm = TRUE))

    data <- catch %>%
      group_by(YEAR, GEAR) %>%
      summarise(DISCARDS = sum(DISCARDS))

    gr <- data.frame("YEAR" = seq(min(data$YEAR), max(data$YEAR), 1), "GEAR" = rep(unique(data$GEAR), each = max(data$YEAR) - min(data$YEAR) + 1), "LAND" = 0)

    data <- full_join(gr, data)

    data[is.na(data)] <- 0

    p <- ggplot(data, aes(x = YEAR, y = DISCARDS, fill = GEAR)) +
      geom_area(size = 0.5, colour = "black") +
      theme_bw() +
      ggtitle(paste0("Discards in catch of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$YEAR), max(data$YEAR), 2))
    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- "discards_at_age"
    return(output) # list(Summary_land_wt,Summary_disc_wt)
  }
}
