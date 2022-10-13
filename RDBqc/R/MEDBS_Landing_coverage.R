#' Check the coverage of Landing table
#'
#' @param data Landing table in MED&BS format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the coverage in landing table providing a summary table and a plot of landing.
#' @return A list containing a summary table and coverage plot is provided.
#' @export

#' @examples MEDBS_Landing_coverage(Landing_tab_example, "DPS", "ITA", "GSA 9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
MEDBS_Landing_coverage <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- Land # Landing_tab_example
    SP <- "DPS"
    MS <- "ITA"
    GSA <- "GSA 18"
    verbose <- TRUE
  }

  colnames(data) <- tolower(colnames(data))
  data[is.na(data$vessel_length), "vessel_length"] <- "NA"
  data[is.na(data$gear), "gear"] <- "NA"
  data[is.na(data$mesh_size_range), "mesh_size_range"] <- "NA"
  data[is.na(data$fishery), "fishery"] <- "NA"

  Landing_tab <- data

  discards <- landings <- country <- area <- year <- quarter <- vessel_length <- gear <- mesh_size_range <- fishery <- species <- NULL

  Landing_tab <- Landing_tab[Landing_tab$species == SP & Landing_tab$country == MS & Landing_tab$area == GSA, ]



  if (nrow(Landing_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    if (length(Landing_tab$Landing_tab[Landing_tab$landings == -1,""])>0){
      Landing_tab[Landing_tab$landings == -1,"landings"] <- 0
    }

    Summary_land_wt <- data.frame(Landing_tab %>%  group_by(country, year, quarter, vessel_length, gear,
                                                            mesh_size_range, fishery, area, species) %>% summarise(landings = sum(landings, na.rm=TRUE)))


    # Summary_land_wt <- aggregate(Landing_tab$LANDINGS, by = list(Landing_tab$COUNTRY, Landing_tab$YEAR, Landing_tab$QUARTER, Landing_tab$VESSEL_LENGTH, Landing_tab$GEAR, Landing_tab$MESH_SIZE_RANGE, Landing_tab$FISHERY, Landing_tab$AREA, Landing_tab$SPECIES), FUN = "sum") # [,2:12]
    # colnames(Summary_land_wt) <- c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY", "AREA", "SPECIES", "LANDINGS")

    # Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_land_wt
    names(output)[[l]] <- "summary table"

    Landing_tab$Landing_tab[Landing_tab$landings == -1] <- 0
    suppressMessages(land_wt <- Landing_tab %>%
      group_by(country, area, year, quarter, vessel_length, gear, mesh_size_range, fishery) %>%
      summarize(landings = sum(landings, na.rm = TRUE)))

    suppressMessages(data <- Landing_tab %>%
      group_by(year, gear) %>%
      summarise(landings = sum(landings, na.rm = TRUE)))

    gr <- data.frame("year" = seq(min(data$year), max(data$year), 1), "gear" = rep(unique(data$gear), each = max(data$year) - min(data$year) + 1)) # , "LAND" = 0

    suppressMessages(data <- full_join(gr, data))

    data[is.na(data)] <- 0

    # data <-  data[data$Landing_tab>0,]


    p <- ggplot(data, aes(x = year, y = landings, fill = gear)) +
      geom_area(size = 0.5, colour = "black") +
      theme_bw() +
      ggtitle(paste0("Landings of ", SP, " in ", MS, " - ", GSA)) +
      xlab("") +
      ylab("tonnes") +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = seq(min(data$year), max(data$year), 2))

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("Landing", SP, MS, GSA, sep = " _ ")

    return(output) # Summary_land_wt
  }
}
