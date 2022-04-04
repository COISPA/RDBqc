#' Comparison between landings in weight by quarter, quarter -1 and by fishery
#'
#' @param land data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#'
#' @return The function returns a dataframe  for the comparison of landings aggregated by quarters and by year and fishery
#' @export MEDBS_comp_land_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_YQ(land=landing,MS="ITA",GSA=11,SP="ARA")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_YQ_fishery <- function(land,MS,GSA,SP) {
    if (FALSE) {
        MS <- "ITA"
        GSA <- 11
        SP <- "ARA"
        # verbose=TRUE
        land=landing
        MEDBS_comp_land_YQ_fishery(land=landing,MS="ITA",GSA=11,SP="ARA",by="quarter")
    }

    gear <- landings <- quarter <- tot_q <- tot_yr <- year <- fishery <- NULL


    land$area <- as.numeric(gsub("[^0-9.-]+","\\1",land$area))
    land=land[which(land$area==as.numeric(GSA) & land$country==MS & land$species==SP),]
    land$landings[land$landings==-1] <- 0

compLand0 <- list()
c0 <- 1
for (i in unique(land$year)){
    tmp0 <- land[land$year%in%i,]
    quarters <- tmp0 %>%
        filter(quarter>0) %>% group_by(year,gear,fishery) %>% summarize(tot_q=sum(landings))
    annual <- tmp0 %>%
        filter(quarter<0) %>% group_by(year,gear,fishery) %>% summarize(tot_yr=sum(landings))
    final_check0 <- full_join(quarters,annual)
    final_check0 <- final_check0 %>% mutate(ratio=tot_q/tot_yr)
    compLand0[[c0]] <-final_check0
    c0 <- c0+1
}
compLandings0 <- do.call(rbind,compLand0)

return(as.data.frame(compLandings0))
}

