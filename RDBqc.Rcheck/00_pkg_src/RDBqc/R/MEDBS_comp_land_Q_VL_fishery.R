#' Comparison between landings in weight by quarter and fishery accounting for vessel length
#'
#' @param land data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters and fishery accounting for the presence of vessel length
#' @return The function returns a data frame for the comparison of landings aggregated by quarters and fishery accounting for the presence of vessel length information.
#' @export MEDBS_comp_land_Q_VL_fishery
#'
#' @examples MEDBS_comp_land_Q_VL_fishery(land = Landing_tab_example, MS = "ITA", GSA = 9, SP = "DPS")
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
MEDBS_comp_land_Q_VL_fishery <- function(land, MS, GSA, SP, verbose = TRUE) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- 9
    SP <- "DPS"
    # verbose=TRUE
    land <- Landing_tab_example
    MEDBS_comp_land_Q_VL_fishery(land = Landing_tab_example, MS = "ITA", GSA = 9, SP = "DPS")
  }

  gear <- landings <- quarter <- vessel_length <- year <- tmp1 <- tot_VL <- tot_NoVL <- fishery <- NULL

  land$area <- as.numeric(gsub("[^0-9.-]+", "\\1", land$area))
  land <- land[which(land$area == as.numeric(GSA) & land$country == MS & land$species == SP), ]

  if (nrow(land) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(land) > 0) {
    land$landings[land$landings == -1] <- 0
    compLand2 <- list()
    c2 <- 1
    i <- 1
    for (i in unique(land$year)) {
      # i=2019
      tmp2 <- land[land$year %in% i, ]
      VL <- tmp2 %>%
        filter(!vessel_length %in% "NA") %>%
        group_by(year, gear, fishery, quarter) %>%
        summarize(tot_VL = sum(landings))
      NoVL <- tmp2 %>%
        filter(vessel_length %in% "NA") %>%
        group_by(year, gear, fishery, quarter) %>%
        summarize(tot_NoVL = sum(landings))
      final_check2 <- full_join(VL, NoVL)
      final_check2 <- final_check2 %>% mutate(ratio = tot_VL / tot_NoVL)
      compLand2[[c2]] <- final_check2
      c2 <- c2 + 1
    }
    compLandings2 <- do.call(rbind, compLand2)
    return(as.data.frame(compLandings2))
  } # nrow(land) >0
}
