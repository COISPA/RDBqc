#' MA_tab (maturity at age) table check
#' @param MA_tab maturity at AGE table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the maturity at age (MA) table providing a summary table of the data coverage and plots for the selected species of the proportion of matures for age class by sex and year.
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples MEDBS_MA_check(MA_tab_example,"DPS","ITA","9")
MEDBS_MA_check <- function(MA_tab, SP, MS, GSA, verbose=TRUE) {

    if (FALSE) {
        MA_tab <- MA_tab_example
        SP <- "DPS"
        MS <- "ITA"
        GSA <- "9"
    }

    MA_tab = MA_tab[MA_tab$SPECIES == SP & MA_tab$COUNTRY == MS & MA_tab$AREA == GSA, ]

if (nrow(MA_tab)==0){
    if (verbose){
        message(paste0("No data available for the selected species (",SP,")") )
    }
    } else if (nrow(MA_tab)>0) {
    MA_tab[MA_tab$SEX == FALSE, ]$SEX = "F"
    Summary_MA_tab <- AGECLASS <- PRM <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX <- NULL
    Summary_MA_tab = aggregate(
        MA_tab$SEX,
        by = list(
            MA_tab$COUNTRY,
            MA_tab$AREA,
            MA_tab$START_YEAR,
            MA_tab$END_YEAR,
            MA_tab$SPECIES,
            MA_tab$SEX
        ),
        FUN = "length"
    )
    colnames(Summary_MA_tab) = c("COUNTRY",
                                 "YEAR",
                                 "START_YEAR",
                                 "END_YEAR",
                                 "SPECIES",
                                 "SEX")

Summary_MA_tab =  Summary_MA_tab[1:nrow(Summary_MA_tab), 1:(ncol(Summary_MA_tab)-1)]

output <- list()
l <- length(output)+1
output[[l]] <- Summary_MA_tab
names(output)[[l]] <- "summary table"

    p <- ggplot(data = MA_tab, aes(
            x = AGECLASS,
            y = PRM,
            col = factor(START_YEAR)
        )) + geom_line(stat = "identity") +
        facet_grid(AREA + COUNTRY ~ SEX)+
        labs(color='Years') +
        ggtitle(SP) +
        xlab("Age class") +
        ylab("PRM")
    print(p)
    l <- length(output)+1
    output[[l]] <- p
    names(output)[[l]] <- paste("MA",SP,MS,GSA,sep=" _ ")

    for (i in unique(as.character(MA_tab$SEX))) {
        p <- ggplot(data = MA_tab[MA_tab$SEX %in% i, ], aes(
                x = AGECLASS,
                y = PRM,
                col = factor(START_YEAR)
            )) +
            geom_line(stat = "identity") +
            theme(legend.position = "bottom") +
            expand_limits(x = 0, y = 0) +
            theme(legend.text = element_text(color = "blue", size = 6)) +
            guides(col = guide_legend(title = "Years")) +
            ggtitle(paste(SP,i,sep=" - ")) +
            xlab("Age class") +
            ylab("PRM")
        print(p)
        l <- length(output)+1
        output[[l]] <- p
        names(output)[[l]] <- paste("MA_sex",SP,MS,GSA,i,sep=" _ ")

    }
    return(output) # Summary_MA_tab
}
}
