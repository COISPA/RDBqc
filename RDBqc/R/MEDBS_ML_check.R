#' Check of ML_tab (maturity at length) table
#' @param data maturity at length table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the maturity at length (ML) table providing a summary table of the data coverage and plots for the selected species of the proportion of matures for age class by sex and year.
#' @return a summary table and plots
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @import ggplot2 dplyr
#' @examples MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "GSA 99")
MEDBS_ML_check <- function(data, SP, MS, GSA, verbose = TRUE) {
  AREA <- Summary_ML_tab <- LENGTHCLASS <- PRM <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX <- NULL

  colnames(data) <- toupper(colnames(data))
  ML_tab <- data
  ML_tab <- ML_tab[ML_tab$SPECIES == SP & ML_tab$COUNTRY == MS & ML_tab$AREA == GSA, ]

  if (nrow(ML_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(ML_tab) > 0) {
    ML_tab$SEX <- as.character(ML_tab$SEX)
    ML_tab[ML_tab$SEX == FALSE, "SEX"] <- "F"

    Summary_ML_tab <- suppressMessages(data.frame(ML_tab %>% group_by(COUNTRY, AREA, START_YEAR, END_YEAR, SPECIES, SEX) %>% summarise(COUNT = length(SEX))))

    Summary_table_ML <- Summary_ML_tab
    Summary_ML_tab <- Summary_ML_tab[1:nrow(Summary_ML_tab), 1:(ncol(Summary_ML_tab) - 1)]

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_table_ML
    names(output)[[l]] <- "summary table"

    for (i in unique(as.character(ML_tab$SEX))) {
      p <- ggplot(data = ML_tab[ML_tab$SEX %in% i, ], aes(x = LENGTHCLASS, y = PRM, col = factor(START_YEAR))) +
        geom_line(stat = "identity") +
        geom_point(stat = "identity") +
        theme(legend.position = "bottom") +
        expand_limits(x = 0, y = 0) +
        theme(legend.text = element_text(color = "blue", size = 6)) +
        guides(col = guide_legend(title = paste(SP, GSA, MS))) +
        xlab("Lenght class") +
        ylab("PRM") +
        ggtitle(paste(SP, i, sep = " - "))
      print(p)
      l <- length(output) + 1
      output[[l]] <- p
      names(output)[[l]] <- paste("ML_sex", SP, MS, GSA, i, sep = " _ ")
    }
    return(output) # Summary_ML_tab
  }
}
