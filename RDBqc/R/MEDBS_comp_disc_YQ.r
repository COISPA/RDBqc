#' Comparison between discards in weight by quarter and -1
#'
#' @param data data frame containing discards data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @description The function compares the discards weights aggregated by quarter and by year for a selected species at gear level.
#' @return The function returns a data frame with the comparison of discards aggregated by quarters and by year
#' @export MEDBS_comp_disc_YQ
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_comp_disc_YQ(data = Discard_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_disc_YQ <- function(data, MS, GSA, SP) {
  if (FALSE) {
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    # verbose=TRUE
    data <- Discard_tab_example
    MEDBS_comp_disc_YQ(data, MS = "ITA", GSA = GSA, SP = SP)
  }

  GEAR <- DISCARDS <- QUARTER <- tot_q <- tot_yr <- YEAR <- NULL

  colnames(data) <- toupper(colnames(data))
  disc <- data
  # disc$area <- as.numeric(gsub("[^0-9.-]+","\\1",disc$area))
  disc <- disc[which(disc$AREA == as.character(GSA) & disc$COUNTRY == MS & disc$SPECIES == SP), ]
  disc$DISCARDS[disc$DISCARDS == -1] <- 0

  if (nrow(disc) > 0) {
    compLand <- list()
    c <- 1
    i <- 2009

    for (i in unique(disc$YEAR)) {
      tmp <- disc[disc$YEAR %in% i, ]
      suppressMessages(quarters <- tmp %>%
        filter(QUARTER > 0) %>% group_by(YEAR, GEAR) %>% summarize(tot_q = sum(DISCARDS)))
      suppressMessages(annual <- tmp %>%
        filter(QUARTER < 0) %>% group_by(YEAR, GEAR) %>% summarize(tot_yr = sum(DISCARDS)))
      suppressMessages(final_check <- full_join(quarters, annual))
      suppressMessages(final_check <- final_check %>% mutate(ratio = tot_q / tot_yr))
      compLand[[c]] <- final_check
      c <- c + 1
    }

    compLandings <- do.call(rbind, compLand)
    return(as.data.frame(compLandings))
  } else {
    message("No discard data in the subset.\n")
  }
}
