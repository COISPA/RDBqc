#' SA_tab (sex ratio at age) table check
#' @param SA_tab sex ratio at age table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the sex ratio at age (SA) table providing a summary table of the data coverage and plots for the selected species of the proportion of sex ratio for age class by year.
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "9")
MEDBS_SA_check <- function(SA_tab, SP, MS, GSA,verbose=TRUE) {

    if (FALSE) {
        SA_tab = SA_tab_example
        SP = "DPS"
        MS = "ITA"
        GSA = "9"
    }

  SA_tab <- SA_tab[SA_tab$SPECIES == SP & SA_tab$COUNTRY == MS & SA_tab$AREA == GSA, ]

  if (nrow(SA_tab)==0) {
      if (verbose){
          message(paste0("No data available for the selected species (",SP,")") )
      }
  } else if (nrow(SA_tab)>0) {

  SEXRATIO <- Summary_SA <- AGECLASS <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX_RATIO <- NULL

  Summary_SA <- aggregate(SA_tab$SEX_RATIO, by = list(SA_tab$COUNTRY, SA_tab$AREA, SA_tab$START_YEAR, SA_tab$END_YEAR, SA_tab$SPECIES), FUN = "length")
  colnames(Summary_SA) <- c("COUNTRY", "YEAR", "START_YEAR", "END_YEAR", "SPECIES", "SEX_RATIO")

  Summary_SA <- Summary_SA[1:nrow(Summary_SA), 1:(ncol(Summary_SA) - 1)]

  output <- list()
  l <- length(output)+1
  output[[l]] <- Summary_SA
  names(output)[[l]] <- "summary table"

  p <- ggplot(data = SA_tab, aes(x = AGECLASS, y = SEX_RATIO, col = factor(START_YEAR))) +
    geom_line(stat = "identity") +
    facet_grid(AREA + COUNTRY ~ .)+
    labs(color='Years') +
    ggtitle(SP) +
    xlab("Age class") +
    ylab("Sex ratio")

  print(p)
  l <- length(output)+1
  output[[l]] <- p
  names(output)[[l]] <- paste("SA_cum",SP,MS,GSA,sep=" _ ")

  p <- ggplot(SA_tab, aes(x = AGECLASS,y = SEX_RATIO, col = "red")) +
    geom_point() +
    geom_line() +
    scale_y_continuous(breaks = seq(0, 1, 0.25)) +
    expand_limits(x = 0, y = 0) +
    facet_wrap(~START_YEAR) +
    ggtitle(paste0("Sexratio by age class of ", SP, " in ", MS, "_GSA", GSA)) +
    theme(legend.position = "none") +
    xlab("Age class") +
    ylab("Sex ratio")
  print(p)
  l <- length(output)+1
  output[[l]] <- p
  names(output)[[l]] <- paste("SA",SP,MS,GSA,sep=" _ ")

  return(output)
  }
}
