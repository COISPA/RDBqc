#' Check of MA_tab (maturity at age) table
#' @param data maturity at AGE table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the maturity at age (MA) table providing a summary table of the data coverage and plots for the selected species of the proportion of matures for age class by sex and year.
#' @return A summary table and plots are returned by the function.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @import ggplot2 dplyr
#' @examples MEDBS_MA_check(MA_tab_example, "DPS", "ITA", "GSA 99")
MEDBS_MA_check <- function(data, SP, MS, GSA, verbose = TRUE) {


  if (FALSE) {
    data=MA_tab_example
    SP="DPS"
    MS="ITA"
    GSA="GSA 99"
    MEDBS_MA_check(data, SP, MS, GSA, verbose = TRUE)
  }
  AREA <- Summary_MA_tab <- AGECLASS <- PRM <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX <- NULL

  colnames(data) <- toupper(colnames(data))
  MA_tab <- data
  MA_tab <- MA_tab[MA_tab$SPECIES == SP & MA_tab$COUNTRY == MS & MA_tab$AREA == GSA, ]

  if (nrow(MA_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(MA_tab) > 0) {
    MA_tab$SEX <- as.character(MA_tab$SEX)
    MA_tab[MA_tab$SEX == "FALSE", "SEX"] <- "F"

    Summary_MA_tab <- suppressMessages(data.frame(MA_tab %>% group_by(COUNTRY, AREA, START_YEAR, END_YEAR, SPECIES, SEX) %>% summarise(COUNT = length(SEX))))

    Summary_table_MA <- Summary_MA_tab
    Summary_MA_tab <- Summary_MA_tab[1:nrow(Summary_MA_tab), 1:(ncol(Summary_MA_tab) - 1)]

    output <- list()
    l <- length(output) + 1
    output[[l]] <- Summary_table_MA
    names(output)[[l]] <- "summary table"

    p <- ggplot(data = MA_tab, aes(
      x = AGECLASS,
      y = PRM,
      col = factor(START_YEAR)
    )) +
      geom_line(stat = "identity") +
      geom_point(stat = "identity") +
      facet_grid(AREA + COUNTRY ~ SEX) +
      labs(color = "Years") +
      ggtitle(SP) +
      xlab("Age class") +
      ylab("PRM")
    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("MA", SP, MS, GSA, sep = " _ ")

    for (i in unique(as.character(MA_tab$SEX))) {
      p <- ggplot(data = MA_tab[MA_tab$SEX %in% i, ], aes(
        x = AGECLASS,
        y = PRM,
        col = factor(START_YEAR)
      )) +
        geom_line(stat = "identity") +
        geom_point(stat = "identity") +
        theme(legend.position = "bottom") +
        expand_limits(x = 0, y = 0) +
        theme(legend.text = element_text(color = "blue", size = 6)) +
        guides(col = guide_legend(title = "Years")) +
        ggtitle(paste(SP, i, sep = " - ")) +
        xlab("Age class") +
        ylab("PRM")
      l <- length(output) + 1
      output[[l]] <- p
      names(output)[[l]] <- paste("MA_sex", SP, MS, GSA, i, sep = " _ ")
    }
    return(output) # Summary_MA_tab
  }
}
