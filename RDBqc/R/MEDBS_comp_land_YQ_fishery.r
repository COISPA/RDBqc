#' Comparison between landings in weight by quarter, quarter -1 and by fishery
#'
#' @param data data frame containing landing data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters, and by year and fishery
#' @return The function returns a data frame for the comparison of landings aggregated by quarters, and by year and fishery
#' @export MEDBS_comp_land_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_comp_land_YQ_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_YQ_fishery <- function(data, SP, MS, GSA, verbose = TRUE) {
  GEAR <- LANDINGS <- QUARTER <- tot_q <- tot_yr <- YEAR <- FISHERY <- NULL
  colnames(data) <- toupper(colnames(data))
  data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
  data[is.na(data$GEAR), "GEAR"] <- "NA"
  data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
  data[is.na(data$FISHERY), "FISHERY"] <- "NA"
  land <- data
  land <- land[which(land$AREA == as.character(GSA) & land$COUNTRY == MS & land$SPECIES == SP), ]

  if (nrow(land) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
    compLandings0 <- data.frame(matrix(ncol = 6, nrow = 0))
    colnames(compLandings0) <- c("YEAR", "GEAR", "FISHERY", "tot_q", "tot_yr", "ratio")
  } else {
    land$LANDINGS[land$LANDINGS == -1] <- 0
    compLand0 <- list()
    c0 <- 1
    for (i in unique(land$YEAR)) {
      tmp0 <- land[land$YEAR %in% i, ]
      suppressMessages(quarters <- tmp0 %>%
        filter(QUARTER > 0) %>%
        group_by(YEAR, GEAR, FISHERY) %>%
        summarize(tot_q = sum(LANDINGS)))
      suppressMessages(annual <- tmp0 %>%
        filter(QUARTER < 0) %>%
        group_by(YEAR, GEAR, FISHERY) %>%
        summarize(tot_yr = sum(LANDINGS)))
      suppressMessages(final_check0 <- full_join(quarters, annual))
      suppressMessages(final_check0 <- final_check0 %>% mutate(ratio = tot_q / tot_yr))
      compLand0[[c0]] <- final_check0
      c0 <- c0 + 1
    }
    compLandings0 <- do.call(rbind, compLand0)
    compLandings0 <- as.data.frame(compLandings0)
  }
  return(as.data.frame(compLandings0))
}
