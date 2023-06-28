#' Check of SA_tab (sex ratio at age) table
#' @param data sex ratio at age table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the sex ratio at age (SA) table providing a summary table of the data coverage and plots for the selected species of the proportion of sex ratio for age class by year.
#' @return a summary table and plots
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @export
#' @import ggplot2 dplyr
#' @examples MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "GSA 99")
MEDBS_SA_check <- function(data, SP, MS, GSA, verbose = TRUE) {
  AREA <- SEXRATIO <- Summary_SA <- AGECLASS <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX_RATIO <- NULL

  colnames(data) <- toupper(colnames(data))

  if(any(colnames(data)=="SEXRATIO")){
    colnames(data)[which(colnames(data)=="SEXRATIO")] <- "SEX_RATIO"
  }

  SA_tab <- data
  SA_tab <- SA_tab[SA_tab$SPECIES %in% SP & SA_tab$COUNTRY %in% MS & SA_tab$AREA %in% GSA, ]

  if (nrow(SA_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(SA_tab) > 0) {
    Summary_SA <- suppressMessages(data.frame(SA_tab %>% group_by(COUNTRY, AREA, START_YEAR, END_YEAR, SPECIES) %>% summarise(SEX_RATIO = length(SEX_RATIO))))

    Summary_SA <- Summary_SA[1:nrow(Summary_SA), 1:(ncol(Summary_SA) - 1)]
    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_SA
    names(output)[[l]] <- "summary table"

    p <- ggplot(data = SA_tab, aes(x = AGECLASS, y = SEX_RATIO, col = factor(START_YEAR))) +
      geom_line(stat = "identity") +
      facet_grid(AREA + COUNTRY ~ .) +
      labs(color = "Years") +
      ggtitle(SP) +
      xlab("Age class") +
      ylab("Sex ratio")

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("SA_cum", SP, MS, GSA, sep = " _ ")

    p <- ggplot(SA_tab, aes(x = AGECLASS, y = SEX_RATIO, col = "red")) +
      geom_point() +
      geom_line() +
      scale_y_continuous(breaks = seq(0, 1, 0.25)) +
      expand_limits(x = 0, y = 0) +
      facet_wrap(~START_YEAR) +
      ggtitle(paste0("Sexratio by age class of ", SP, " in ", MS, " - ", GSA)) +
      theme(legend.position = "none") +
      xlab("Age class") +
      ylab("Sex ratio")
    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("SA", SP, MS, GSA, sep = " _ ")

    return(output)
  }
}
