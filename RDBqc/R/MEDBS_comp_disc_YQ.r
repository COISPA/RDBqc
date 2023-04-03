#' Comparison between discards in weight by quarter and -1
#'
#' @param data data frame containing discards data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function compares the discards weights aggregated by quarter and by year for a selected species at gear level.
#' @return The function returns a data frame with the comparison of discards aggregated by quarters and by year
#' @export MEDBS_comp_disc_YQ
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_comp_disc_YQ(data = Discard_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join

MEDBS_comp_disc_YQ <- function(data, MS, GSA, SP, verbose = FALSE) {
  gear <- discards <- quarter <- tot_q <- tot_yr <- year <- NULL
  colnames(data) <- tolower(colnames(data))
  disc <- data
  disc <- disc[which(disc$area == as.character(GSA) & disc$country == MS & disc$species == SP), ]
  disc$discards[disc$discards == -1] <- 0

  if (nrow(disc) > 0) {
    compDisc <- list()
    c <- 1
    i <- 2009

    for (i in unique(disc$year)) {
      tmp <- disc[disc$year %in% i, ]
      suppressMessages(quarters <- tmp %>%
        filter(quarter > 0) %>% group_by(year, gear) %>% summarize(tot_q = sum(discards)))
      suppressMessages(annual <- tmp %>%
        filter(quarter < 0) %>% group_by(year, gear) %>% summarize(tot_yr = sum(discards)))
      suppressMessages(final_check <- full_join(quarters, annual))
      suppressMessages(final_check <- final_check %>% mutate(ratio = tot_q / tot_yr))
      compDisc[[c]] <- final_check
      c <- c + 1
    }

    compDiscards <- do.call(rbind, compDisc)
    colnames(compDiscards) <- toupper(colnames(compDiscards))
    return(as.data.frame(compDiscards))
  } else {
    if (verbose) {
      message("No discard data in the subset.\n")
    }
    empty <- data.frame(matrix(ncol = 5, nrow = 0))
    colnames(empty) <- c("YEAR", "GEAR", "TOT_Q", "TOT_YR", "RATIO")
    return(empty)
  }
}
