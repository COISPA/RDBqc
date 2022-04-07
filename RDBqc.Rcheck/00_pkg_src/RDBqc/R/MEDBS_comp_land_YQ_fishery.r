#' Comparison between landings in weight by quarter, quarter -1 and by fishery
#'
#' @param land data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters and by year and fishery
#' @return The function returns a dataframe  for the comparison of landings aggregated by quarters and by year and fishery
#' @export MEDBS_comp_land_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_YQ_fishery(land = Landing_tab_example, MS = "ITA", GSA = 9, SP = "DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_YQ_fishery <- function(land, MS, GSA, SP,verbose=TRUE) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- 9
    SP <- "DPS"
    # verbose=TRUE
    land <- Landing_tab_example
    MEDBS_comp_land_YQ_fishery(land = Landing_tab_example, MS = "ITA", GSA = 9, SP = "DPS")
  }

  gear <- landings <- quarter <- tot_q <- tot_yr <- year <- fishery <- NULL

  land$area <- as.numeric(gsub("[^0-9.-]+", "\\1", land$area))
  land <- land[which(land$area == as.numeric(GSA) & land$country == MS & land$species == SP), ]

  if (nrow(land)==0) {
      if (verbose){
          message(paste0("No data available for the selected species (",SP,")") )
      }
  } else {

  land$landings[land$landings == -1] <- 0

  compLand0 <- list()
  c0 <- 1
  for (i in unique(land$year)) {
    tmp0 <- land[land$year %in% i, ]
    quarters <- tmp0 %>%
      filter(quarter > 0) %>%
      group_by(year, gear, fishery) %>%
      summarize(tot_q = sum(landings))
    annual <- tmp0 %>%
      filter(quarter < 0) %>%
      group_by(year, gear, fishery) %>%
      summarize(tot_yr = sum(landings))
    final_check0 <- full_join(quarters, annual)
    final_check0 <- final_check0 %>% mutate(ratio = tot_q / tot_yr)
    compLand0[[c0]] <- final_check0
    c0 <- c0 + 1
  }
  compLandings0 <- do.call(rbind, compLand0)

  return(as.data.frame(compLandings0))
  }
 }
