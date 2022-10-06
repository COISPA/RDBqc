#' Comparison between landings in weight by quarter and fishery, accounting for vessel length
#'
#' @param data data frame containing landing data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function performs the comparison of landings of a selected species aggregated by quarters and fishery, accounting for the presence of vessel length
#' @return The function returns a data frame for the comparison of landings aggregated by quarters and fishery accounting for the presence of vessel length information.
#' @export MEDBS_comp_land_Q_VL_fishery
#' @examples MEDBS_comp_land_Q_VL_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_Q_VL_fishery <- function(data, SP, MS, GSA, verbose = TRUE) {


  colnames(data) <- toupper(colnames(data))
  data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
  data[is.na(data$GEAR), "GEAR"] <- "NA"
  data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
  data[is.na(data$FISHERY), "FISHERY"] <- "NA"

  land <- data

  GEAR <- LANDINGS <- QUARTER <- VESSEL_LENGTH <- YEAR <- tmp1 <- tot_VL <- tot_NoVL <- FISHERY <- NULL

  # land$area <- as.numeric(gsub("[^0-9.-]+", "\\1", land$area))
  land <- land[which(land$AREA == as.character(GSA) & land$COUNTRY == MS & land$SPECIES == SP), ]

  if (nrow(land) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(land) > 0) {
    land$LANDINGS[land$LANDINGS == -1] <- 0
    compLand2 <- list()
    c2 <- 1
    i <- 1
    for (i in unique(land$YEAR)) {
      # i=2019
      tmp2 <- land[land$YEAR %in% i, ]
      suppressMessages(VL <- tmp2 %>%
        filter(!VESSEL_LENGTH %in% "NA") %>%
        group_by(YEAR, GEAR, FISHERY, QUARTER) %>%
        summarize(tot_VL = sum(LANDINGS)))
      suppressMessages(NoVL <- tmp2 %>%
        filter(VESSEL_LENGTH %in% "NA") %>%
        group_by(YEAR, GEAR, FISHERY, QUARTER) %>%
        summarize(tot_NoVL = sum(LANDINGS)))
      suppressMessages(final_check2 <- full_join(VL, NoVL))
      final_check2 <- final_check2 %>% mutate(ratio = tot_VL / tot_NoVL)
      compLand2[[c2]] <- final_check2
      c2 <- c2 + 1
    }
    compLandings2 <- do.call(rbind, compLand2)
    return(as.data.frame(compLandings2))
  } # nrow(land) >0
}
