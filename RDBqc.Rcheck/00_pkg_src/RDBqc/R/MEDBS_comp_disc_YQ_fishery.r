#' Comparison between discards in weight by quarter, quarter -1 and by fishery
#'
#' @param data data frame containing discards data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allow to estimates the discards in weight for a selected species by quarter and fishery
#' @return The function returns a data frame with the comparison of discards aggregated by quarters and by year and fishery
#' @export MEDBS_comp_disc_YQ_fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_comp_disc_YQ_fishery(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_disc_YQ_fishery <- function(data, SP, MS, GSA, verbose = TRUE) {
  gear <- discards <- quarter <- tot_q <- tot_yr <- year <- fishery <- NULL
  colnames(data) <- tolower(colnames(data))
  disc <- data
  disc <- disc[which(disc$area == as.character(GSA) & disc$country == MS & disc$species == SP), ]
  if (nrow(disc) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
    empty <- data.frame(matrix(ncol = 6, nrow = 0))
    colnames(empty) <- c("YEAR", "GEAR", "FISHERY", "TOT_Q", "TOT_YR", "RATIO")
    return(empty)
  } else {
    disc$discards[disc$discards == -1] <- 0

    compdisc0 <- list()
    c0 <- 1
    for (i in unique(disc$year)) {
      tmp0 <- disc[disc$year %in% i, ]
      suppressMessages(quarters <- tmp0 %>% filter(quarter > 0) %>% group_by(year, gear, fishery) %>% summarize(tot_q = sum(discards)))
      suppressMessages(annual <- tmp0 %>% filter(quarter < 0) %>% group_by(year, gear, fishery) %>% summarize(tot_yr = sum(discards)))
      suppressMessages(final_check0 <- full_join(quarters, annual))
      suppressMessages(final_check0 <- final_check0 %>% mutate(ratio = tot_q / tot_yr))
      compdisc0[[c0]] <- final_check0
      c0 <- c0 + 1
    }
    compdiscards0 <- do.call(rbind, compdisc0)
    colnames(compdiscards0) <- toupper(colnames(compdiscards0))
    return(as.data.frame(compdiscards0))
  }
}
