#' Comparison between landings in weight by quarter, quarter -1 and by fishery
#'
#' @param data data frame containing landing data
#' @param SP species reference code in the three alpha code format
#' @param MS member state code
#' @param GSA GSA code
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters and by year and fishery
#' @return The function returns a data frame  for the comparison of landings aggregated by quarters and by year and fishery
#' @export MEDBS_comp_land_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_YQ_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_YQ_fishery <- function(data, SP, MS, GSA,verbose=TRUE) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    # verbose=TRUE
    land <- Landing_tab_example
    MEDBS_comp_land_YQ_fishery(land = Landing_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")
  }

  GEAR <- LANDINGS <- QUARTER <- tot_q <- tot_yr <- YEAR <- FISHERY <- NULL

  colnames(data) <- toupper(colnames(data))
  land <- data
  # land$area <- as.numeric(gsub("[^0-9.-]+", "\\1", land$area))
  land <- land[which(land$AREA == as.character(GSA) & land$COUNTRY == MS & land$SPECIES == SP), ]

  if (nrow(land)==0) {
      if (verbose){
          message(paste0("No data available for the selected species (",SP,")") )
      }
  } else {

  land$LANDINGS[land$LANDINGS == -1] <- 0

  compLand0 <- list()
  c0 <- 1
  for (i in unique(land$YEAR)) {
    tmp0 <- land[land$YEAR %in% i, ]
    quarters <- tmp0 %>%
      filter(QUARTER > 0) %>%
      group_by(YEAR, GEAR, FISHERY) %>%
      summarize(tot_q = sum(LANDINGS))
    annual <- tmp0 %>%
      filter(QUARTER < 0) %>%
      group_by(YEAR, GEAR, FISHERY) %>%
      summarize(tot_yr = sum(LANDINGS))
    final_check0 <- full_join(quarters, annual)
    final_check0 <- final_check0 %>% mutate(ratio = tot_q / tot_yr)
    compLand0[[c0]] <- final_check0
    c0 <- c0 + 1
  }
  compLandings0 <- do.call(rbind, compLand0)

  return(as.data.frame(compLandings0))
  }
 }
