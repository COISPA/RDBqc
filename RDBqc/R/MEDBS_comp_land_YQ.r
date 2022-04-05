#' Comparison between landings in weight by quarter and -1
#'
#' @param land data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @description The function allows to perform the comparison of landings of a selected species aggregated by quarters and by year
#' @return The function returns a data frame  for the comparison of landings aggregated by quarters and by year
#' @export MEDBS_comp_land_YQ
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_land_YQ(land=Landing_tab_example,MS="ITA",GSA=11,SP="ARA")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_land_YQ <- function(land,MS,GSA,SP) {

    if (FALSE) {
        MS <- "ITA"
        GSA <- 9
        SP <- "DPS"
        # verbose=TRUE
        land=Landing_tab_example
        MEDBS_comp_land_YQ(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
    }

     gear <- landings <- quarter <- tot_q <- tot_yr <- year <- NULL

    land$area <- as.numeric(gsub("[^0-9.-]+","\\1",land$area))
    land=land[which(land$area==as.numeric(GSA) & land$country==MS & land$species==SP),]
    land$landings[land$landings==-1] <- 0

    compLand <- list()
    c <- 1
    i=2009

    for (i in unique(land$year)){
        tmp <- land[land$year%in%i,]
        suppressMessages(quarters <- tmp %>%
            filter(quarter>0) %>% group_by(year,gear) %>% summarize(tot_q=sum(landings)))
        suppressMessages(annual <- tmp %>%
            filter(quarter<0) %>% group_by(year,gear) %>% summarize(tot_yr=sum(landings)))
        suppressMessages(final_check <- full_join(quarters,annual))
        suppressMessages(final_check <- final_check %>% mutate(ratio=tot_q/tot_yr))
        compLand[[c]] <-final_check
        c <- c+1
    }

    compLandings <- do.call(rbind,compLand)
    return(as.data.frame(compLandings))
}

