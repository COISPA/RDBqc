#' Comparison between discards in weight by quarter, quarter -1 and by fishery
#'
#' @param disc data frame containing discards data
#' @param MS member state code as it is reported in the discards data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#'
#' @return The function returns a dataframe  for the comparison of discards aggregated by quarters and by year and fishery
#' @export EWG_comp_disc_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples EWG_comp_disc_YQ(disc=discards,MS="ITA",GSA=18,SP="MUT")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

EWG_comp_disc_YQ_fishery <- function(disc,MS,GSA,SP) {
    if (FALSE) {
        MS <- "ITA"
        GSA <- 11
        SP <- "ARA"
        # verbose=TRUE
        disc=discards
        EWG_comp_disc_YQ_fishery(disc=discards,MS="ITA",GSA=18,SP="MUT")
    }

    gear <- discards <- quarter <- tot_q <- tot_yr <- year <- fishery <- NULL

    land <- disc
    land$area <- as.numeric(gsub("[^0-9.-]+","\\1",land$area))
    land=land[which(land$area==as.numeric(GSA) & land$country==MS & land$species==SP),]
    land$landings[land$discards==-1] <- 0

if (nrow(land)>0) {
    compLand0 <- list()
    c0 <- 1
    for (i in unique(land$year)){
        tmp0 <- land[land$year%in%i,]
        suppressMessages(quarters <- tmp0 %>% filter(quarter>0) %>% group_by(year,gear,fishery) %>% summarize(tot_q=sum(discards)))
        suppressMessages(annual <- tmp0 %>% filter(quarter<0) %>% group_by(year,gear,fishery) %>% summarize(tot_yr=sum(discards)))
        suppressMessages(final_check0 <- full_join(quarters,annual))
        suppressMessages(final_check0 <- final_check0 %>% mutate(ratio=tot_q/tot_yr))
        compLand0[[c0]] <-final_check0
        c0 <- c0+1
    }
    compLandings0 <- do.call(rbind,compLand0)

    return(as.data.frame(compLandings0))

} else {
    message("No discard data in the subset.\n")
}
}

