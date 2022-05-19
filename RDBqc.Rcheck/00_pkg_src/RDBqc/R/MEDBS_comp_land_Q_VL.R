#' Comparison between landings in weight by quarter accounting for vessel length
#'
#' @param data data frame containing landing data
#' @param SP species reference code in the three alpha code format
#' @param MS member state code
#' @param GSA GSA code
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters accounting for the presence of vessel length
#' @return The function returns a dataframe for the comparison of landings aggregated by quarters accounting for the presence of vessel length information.
#' @export MEDBS_comp_land_Q_VL
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_Q_VL(data = Landing_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join



MEDBS_comp_land_Q_VL <- function(data, SP, MS, GSA,verbose=TRUE) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- "GSA 18"
    SP <- "ANE"
    verbose=TRUE
    data <- Land # Landing_tab_example
    MEDBS_comp_land_Q_VL(data = Land, MS = "ITA", GSA = "GSA 18", SP = "ANE")
  }

  GEAR <- LANDINGS <- QUARTER <- VESSEL_LENGTH <- YEAR <- tmp1 <- tot_VL <- tot_NoVL <- NULL

  colnames(data) <- toupper(colnames(data))
  data[is.na(data$VESSEL_LENGTH),"VESSEL_LENGTH"] <- "NA"
  data[is.na(data$GEAR),"GEAR"] <- "NA"
  data[is.na(data$MESH_SIZE_RANGE),"MESH_SIZE_RANGE"] <- "NA"
  data[is.na(data$FISHERY),"FISHERY"] <- "NA"


  land <- data
  # land$area <- as.numeric(gsub("[^0-9.-]+", "\\1", land$area))
  land <- land[which(land$AREA == as.character(GSA) & land$COUNTRY == MS & land$SPECIES == SP), ]

  if (nrow(land)==0) {
      if (verbose){
          message(paste0("No data available for the selected species (",SP,")") )
      }
  } else {

  land$LANDINGS[land$LANDINGS == -1] <- 0

  compLand1 <- list()
  # i=2019
  c1 <- 1
  for (i in unique(land$YEAR)) {
    tmp1 <- land[land$YEAR %in% i, ]
    VL <- tmp1 %>%
      filter(!VESSEL_LENGTH %in% "NA") %>%
      group_by(YEAR, GEAR, QUARTER) %>%
      summarize(tot_VL = sum(LANDINGS))
    NoVL <- tmp1 %>%
      filter(VESSEL_LENGTH %in% "NA") %>%
      group_by(YEAR, GEAR, QUARTER) %>%
      summarize(tot_NoVL = sum(LANDINGS))
    final_check1 <- full_join(VL, NoVL)
    final_check1 <- final_check1 %>% mutate(ratio = tot_VL / tot_NoVL)
    compLand1[[c1]] <- final_check1
    c1 <- c1 + 1
  }
  compLandings1 <- do.call(rbind, compLand1)
  return(as.data.frame(compLandings1))
  } # nrow(land)>0
}
