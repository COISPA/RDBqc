#' Comparison between discards in weight by quarter and -1
#'
#' @param disc data frame containing discards data
#' @param MS member state code as it is reported in the discards data
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @description The function allows to compare the discards weights aggregated by quarter and by year for a selected species at the gear level.
#' @return The function returns a data frame  for the comparison of discards aggregated by quarters and by year
#' @export MEDBS_comp_disc_YQ
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_disc_YQ(disc=Discard_tab_example,MS="ITA",GSA=9,SP="DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_disc_YQ <- function(disc,MS,GSA,SP) {

    if (FALSE) {
        MS <- "ITA"
        GSA <- 9
        SP <- "DPS"
        # verbose=TRUE
        disc=Discard_tab_example
        MEDBS_comp_disc_YQ(disc,MS="ITA",GSA=18,SP="MUT")
    }

     gear <- discards <- quarter <- tot_q <- tot_yr <- year <- NULL

     disc$area <- as.numeric(gsub("[^0-9.-]+","\\1",disc$area))
     disc=disc[which(disc$area==as.numeric(GSA) & disc$country==MS & disc$species==SP),]
     disc$discards[disc$discards==-1] <- 0

  if (nrow(disc)>0){
    compLand <- list()
    c <- 1
    i=2009

    for (i in unique(disc$year)){
        tmp <- disc[disc$year%in%i,]
        suppressMessages(quarters <- tmp %>%
            filter(quarter>0) %>% group_by(year,gear) %>% summarize(tot_q=sum(discards)))
        suppressMessages(annual <- tmp %>%
            filter(quarter<0) %>% group_by(year,gear) %>% summarize(tot_yr=sum(discards)))
        suppressMessages(final_check <- full_join(quarters,annual))
        suppressMessages(final_check <- final_check %>% mutate(ratio=tot_q/tot_yr))
        compLand[[c]] <-final_check
        c <- c+1
    }

    compLandings <- do.call(rbind,compLand)
    return(as.data.frame(compLandings))
  } else {
      message("No discard data in the subset.\n")
  }
}
