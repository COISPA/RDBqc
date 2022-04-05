#' Comparison between landings in weight by quarter accounting for vessel length
#'
#' @param land data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters accounting for the presence of vessel length
#' @return The function returns a dataframe for the comparison of landings aggregated by quarters accounting for the presence of vessel length information.
#' @export MEDBS_comp_land_Q_VL
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_Q_VL(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join



MEDBS_comp_land_Q_VL <- function(land,MS,GSA,SP){

    if (FALSE) {
        MS <- "ITA"
        GSA <- 11
        SP <- "ARA"
        # verbose=TRUE
        land=Landing_tab_example
        MEDBS_comp_land_Q_VL(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
    }

    gear <- landings <- quarter <- vessel_length <- year <- tmp1 <- tot_VL <- tot_NoVL <- NULL

    land$area <- as.numeric(gsub("[^0-9.-]+","\\1",land$area))
    land=land[which(land$area==as.numeric(GSA) & land$country==MS & land$species==SP),]
    land$landings[land$landings==-1] <- 0

    compLand1 <- list()
    # i=2019
    c1 <- 1
    for (i in unique(land$year)){
        tmp1 <- land[land$year%in%i,]
        VL <- tmp1 %>%
            filter(!vessel_length%in%"NA") %>% group_by(year,gear,quarter) %>% summarize(tot_VL=sum(landings))
        NoVL <- tmp1 %>%
            filter(vessel_length%in%"NA") %>% group_by(year,gear,quarter) %>% summarize(tot_NoVL=sum(landings))
        final_check1 <- full_join(VL,NoVL)
        final_check1 <- final_check1 %>% mutate(ratio=tot_VL/tot_NoVL)
        compLand1[[c1]] <-final_check1
        c1 <- c1+1
    }
    compLandings1 <- do.call(rbind,compLand1)
    return(as.data.frame(compLandings1))
}
