#' Check LW parameters in GP table
#' @param data growth params table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the length-weight parameters included in the GP table for a selected species.
#' @return A summary table and plots of the LW parameters are returned by the function.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @import ggplot2 dplyr
#' @importFrom grDevices dev.off
#' @examples MEDBS_LW_check(GP_tab_example, "MUT", "ITA", "GSA 18")
MEDBS_LW_check <- function(data, SP, MS, GSA, verbose = TRUE) {
  A <- AREA <- COUNTRY <- END_YEAR <- SPECIES <- START_YEAR <- LENGTH <- WEIGHT <- SEX <- ID <- NULL

  colnames(data) <- toupper(colnames(data))
  GP_tab <- data
  GP_tab <- GP_tab[GP_tab$SPECIES == SP & GP_tab$COUNTRY == MS & GP_tab$AREA == GSA, ]
  GP_tab <- GP_tab[!is.na(GP_tab$A) & GP_tab$A != -1 & !is.na(GP_tab$B) & GP_tab$B != -1 & GP_tab$A >=0 & GP_tab$B >= 0, ]
  if (nrow(GP_tab) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(GP_tab) > 0) {
    Summary_LW <- aggregate(GP_tab$A, by = list(GP_tab$COUNTRY, GP_tab$AREA, GP_tab$START_YEAR, GP_tab$END_YEAR, GP_tab$SPECIES, GP_tab$SEX), FUN = "length")
    colnames(Summary_LW) <- c("COUNTRY", "AREA", "START_YEAR", "END_YEAR", "SPECIES", "SEX", "COUNT")

    Summary_LW <- suppressMessages(data.frame(GP_tab %>% group_by(COUNTRY, AREA, START_YEAR, END_YEAR, SPECIES, SEX) %>% summarise(COUNT = length(A))))
    GP_tab$ID <- paste0(GP_tab$START_YEAR, " a = ", GP_tab$A, ", b = ", GP_tab$B)

    Linf <- GP_tab[!is.na(GP_tab$VB_LINF) & GP_tab$VB_LINF != -1 & GP_tab$VB_LINF != -999, "VB_LINF"]
    if (length(Linf) > 0) {
      Linf <- max(Linf)
    } else {
      Linf <- 80
    }

    len <- seq(1, Linf, 1)

    ## FEMALE LW####
    F_wt <- list()
    counter <- 1
    i <- "F"
    for (i in unique(GP_tab$SEX)) {
      LW_F <- GP_tab[
        !GP_tab$A %in% -1 &
          !GP_tab$B %in% -1 &
          GP_tab$SEX %in% i,
      ]

      LW_F$WEIGHT <- NA
      j <- 1
      for (j in 1:nrow(LW_F)) {
        F_wt[[counter]] <- data.frame("ID" = LW_F$ID[j], "COUNTRY" = LW_F$COUNTRY[j], "AREA" = LW_F$AREA[j], "START_YEAR" = LW_F$START_YEAR[j], "SPECIES" = LW_F$SPECIES[j], "SEX" = LW_F$SEX[j], "LENGTH" = len, "WEIGHT" = LW_F$A[j] * len^LW_F$B[j], "UNITS" = LW_F$L_W_UNITS[j])
        counter <- counter + 1
      }
    }
    LW_final <- do.call("rbind", F_wt)
    LW_final <- LW_final[!LW_final$WEIGHT %in% NA, ]
    steps <- seq(0, 80, 20)

    ### plot by year and sex
    plots <- list()
    l <- length(plots) + 1
    plots[[l]] <- Summary_LW
    names(plots)[[l]] <- "summary table"

    p <- ggplot(LW_final, aes(x = LENGTH, y = WEIGHT, col = SEX)) +
      geom_point() +
      geom_line() +
      facet_wrap(~START_YEAR) +
      ggtitle(paste0("LW curve of ", SP, " in ", MS, " - ", GSA)) +
      theme(legend.position = "bottom") +
      scale_x_continuous(breaks = steps) +
      expand_limits(x = 0, y = 0) +
      xlab(paste0("Length (", unique(LW_final$UNITS)[1], ")")) +
      ylab("Weight (g)")

    l <- length(plots) + 1
    plots[[l]] <- p
    names(plots)[[l]] <- paste("LW_cum", SP, MS, GSA, sep = " _ ")

    i <- "M"
    for (i in unique(LW_final$SEX)) {
      if (nrow(LW_final[LW_final$SEX %in% i, ]) > 0) {
        p <- ggplot(LW_final[LW_final$SEX %in% i, ], aes(x = LENGTH, y = WEIGHT, col = ID)) +
          geom_point() +
          geom_line() +
          facet_wrap(~START_YEAR) +
          ggtitle(paste0("LW curve of ", i, " ", SP, " in ", MS, " - ", GSA)) +
          scale_x_continuous(breaks = steps) +
          expand_limits(x = 0, y = 0) +
          theme(legend.text = element_text(color = "blue", size = 6)) +
          guides(col = guide_legend(title = paste(SP, GSA, MS))) +
          xlab(paste0("Length (", unique(LW_final$UNITS)[1], ")")) +
          ylab("Weight (g)")

        l <- length(plots) + 1
        plots[[l]] <- p
        names(plots)[[l]] <- paste("LW_year", SP, MS, GSA, i, sep = " _ ")
      }
    }

    for (i in unique(LW_final$SEX)) {
      if (nrow(LW_final[LW_final$SEX %in% i, ]) > 0) {
        p <- ggplot(LW_final[LW_final$SEX %in% i, ], aes(x = LENGTH, y = WEIGHT, col = ID)) +
          geom_point() +
          geom_line() +
          ggtitle(paste0("LW curve of ", i, " ", SP, " in ", MS, " - ", GSA)) +
          scale_x_continuous(breaks = steps) +
          expand_limits(x = 0, y = 0) +
          theme(legend.text = element_text(color = "blue", size = 6)) +
          guides(col = guide_legend(title = paste(SP, GSA, MS))) +
          xlab(paste0("Length (", unique(LW_final$UNITS)[1], ")")) +
          ylab("Weight (g)")

        l <- length(plots) + 1
        plots[[l]] <- p
        names(plots)[[l]] <- paste("LW_cum", SP, MS, GSA, i, sep = " _ ")
      }
    }
    return(plots)
  } # nrow(GP_tab) > 0
}
