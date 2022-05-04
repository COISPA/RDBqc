#' ML_tab (maturity at length) table check
#' @param ML_tab maturity at length table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the maturity at length (ML) table providing a summary table of the data coverage and plots for the selected species of the proportion of matures for age class by sex and year.
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "9")
MEDBS_ML_check <- function(ML_tab, SP, MS, GSA,verbose=TRUE) {
    if(FALSE){
        ML_tab <- ML_tab_example
        verbose=TRUE
        SP <- "DPS"
        MS <- "ITA"
        GSA <- "9"
    }

    colnames(ML_tab) <- toupper(colnames(ML_tab))

  ML_tab <- ML_tab[ML_tab$SPECIES == SP & ML_tab$COUNTRY == MS & ML_tab$AREA == GSA, ]

  if (nrow(ML_tab)==0){
      if (verbose){
          message(paste0("No data available for the selected species (",SP,")") )
      }
  } else if (nrow(ML_tab)>0){
  ML_tab[ML_tab$SEX == FALSE, ]$SEX <- "F"
  Summary_ML_tab <- LENGTHCLASS <- PRM <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX <- NULL
  Summary_ML_tab <- aggregate(ML_tab$SEX, by = list(ML_tab$COUNTRY, ML_tab$AREA, ML_tab$START_YEAR, ML_tab$END_YEAR, ML_tab$SPECIES, ML_tab$SEX), FUN = "length")
  colnames(Summary_ML_tab) <- c("COUNTRY", "YEAR", "START_YEAR", "END_YEAR", "SPECIES", "SEX")

  Summary_ML_tab <- Summary_ML_tab[1:nrow(Summary_ML_tab), 1:(ncol(Summary_ML_tab) - 1)]

  output <- list()
  l <- length(output)+1
  output[[l]] <- Summary_ML_tab
  names(output)[[l]] <- "summary table"

  p <- ggplot(data = ML_tab, aes(x = LENGTHCLASS, y = PRM, col = factor(START_YEAR))) +
    geom_line(stat = "identity") +
    facet_grid(AREA + COUNTRY ~ SEX) +
    labs(color='Years') +
      ggtitle(SP)
  print(p)

  l <- length(output)+1
  output[[l]] <- p
  names(output)[[l]] <- paste("ML",SP,MS,GSA,sep=" _ ")

  for (i in unique(as.character(ML_tab$SEX))) {
    p <- ggplot(data = ML_tab[ML_tab$SEX %in% i, ], aes(x = LENGTHCLASS, y = PRM, col = factor(START_YEAR))) +
      geom_line(stat = "identity") +
      theme(legend.position = "bottom") +
      expand_limits(x = 0, y = 0) +
      theme(legend.text = element_text(color = "blue", size = 6)) +
      guides(col = guide_legend(title = paste(SP, GSA, MS))) +
        xlab("Lenght class") +
        ylab("PRM") +
        ggtitle(paste(SP,i,sep=" - "))
    print(p)
    l <- length(output)+1
    output[[l]] <- p
    names(output)[[l]] <- paste("ML_sex",SP,MS,GSA,i,sep=" _ ")
  }
  return(output) # Summary_ML_tab
  }
}
