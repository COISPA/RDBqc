#' Plot of Age-Length Keys
#'
#' @param data ALK table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the data in the ALK table providing plots by sex for a selected species
#' @return a list of ALK plots by sex is returne
#' @export
#' @importFrom data.table melt
#'
#' @examples MEDBS_ALK(data = ALK_tab_example, SP = "MUT", MS = "ITA", GSA = "GSA 99")
MEDBS_ALK <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- ALK # ALK_tab_example
    SP <- "HKE"
    GSA <- "GSA 18"
    MS <- "ITA"
  }

  AGE <- len <- START_YEAR <- NULL

  colnames(data) <- toupper(colnames(data))


  data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, ]
  ALK <- data
  if (nrow(ALK) > 0) {
    sexes <- unique(ALK$SEX)

    plots <- list()

    if ("F" %in% sexes) {
      ALK_F <- ALK[ALK$SEX == "F", ]
      unit <- unique(ALK_F$UNIT)
      ALK_F <- as.data.table(ALK_F)
      ALK_F <- data.table::melt(ALK_F, id.vars = c("COUNTRY", "AREA", "START_YEAR", "SEX", "AGE"), measure.vars = colnames(ALK_F)[14:114])
      ALK_F$len <- as.numeric(substring(ALK_F$variable, 12, 14))
      ALK_F <- ALK_F[ALK_F$value != 0, ]
      ALK_F$START_YEAR <- factor(ALK_F$START_YEAR)
      p <- ggplot(data = ALK_F, aes(x = AGE, y = len, col = START_YEAR)) +
        geom_point(stat = "identity") +
        ggtitle(paste("Females", SP, MS, GSA, sep = " - ")) +
        labs(col = "Year") +
        xlab("Age") +
        ylab(paste("Length (", unit, ")")) +
        facet_wrap(START_YEAR ~ .) +
        theme(legend.position = "none")

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("Females", SP, MS, GSA, sep = " - ")
    }


    if ("M" %in% sexes) {
      ALK_M <- ALK[ALK$SEX == "M", ]
      unit <- unique(ALK_M$UNIT)
      ALK_M <- as.data.table(ALK_M)
      ALK_M <- data.table::melt(ALK_M, id.vars = c("COUNTRY", "AREA", "START_YEAR", "SEX", "AGE"), measure.vars = colnames(ALK_M)[14:114])
      ALK_M$len <- as.numeric(substring(ALK_M$variable, 12, 14))
      ALK_M <- ALK_M[ALK_M$value != 0, ]
      ALK_M$START_YEAR <- factor(ALK_M$START_YEAR)
      p <- ggplot(data = ALK_M, aes(x = AGE, y = len, col = START_YEAR)) +
        geom_point(stat = "identity") +
        ggtitle(paste("Males", SP, MS, GSA, sep = " - ")) +
        labs(col = "Year") +
        xlab("Age") +
        ylab(paste("Length (", unit, ")")) +
        facet_wrap(START_YEAR ~ .) +
        theme(legend.position = "none")

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("Males", SP, MS, GSA, sep = " - ")
    }

    if ("C" %in% sexes) {
      ALK_C <- ALK[ALK$SEX == "C", ]
      unit <- unique(ALK_C$UNIT)
      ALK_C <- as.data.table(ALK_C)
      ALK_C <- data.table::melt(ALK_C, id.vars = c("COUNTRY", "AREA", "START_YEAR", "SEX", "AGE"), measure.vars = colnames(ALK_C)[14:114])
      ALK_C$len <- as.numeric(substring(ALK_C$variable, 12, 14))
      ALK_C <- ALK_C[ALK_C$value != 0, ]
      ALK_C$START_YEAR <- factor(ALK_C$START_YEAR)
      p <- ggplot(data = ALK_C, aes(x = AGE, y = len, col = START_YEAR)) +
        geom_point(stat = "identity") +
        ggtitle(paste("Combined sexes", SP, MS, GSA, sep = " - ")) +
        labs(col = "Year") +
        xlab("Age") +
        ylab(paste("Length (", unit, ")")) +
        facet_wrap(START_YEAR ~ .) +
        theme(legend.position = "none")

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("Combined", SP, MS, GSA, sep = " - ")
    }

    return(plots)
  } else {
    if (verbose) {
      message("No data for the selected combination of SP, MS, GSA ")
    }
    # -------------
  }
}
