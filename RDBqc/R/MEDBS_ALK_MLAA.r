#' Plot of Age-Length Keys
#'
#' @param data ALK table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned.
#' @description The function allows to check the data in the ALK table providing plots of the mean length by age by sex for a selected species
#' @return a list of ALK plots by sex is return.
#' @export
#' @importFrom data.table as.data.table
#' @importFrom dplyr mutate group_by summarise case_when
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_remove
#' @importFrom tidyselect starts_with
#' @importFrom stats weighted.mean
#' @importFrom magrittr %>%
#' @importFrom ggplot2 ggplot aes geom_point ggtitle labs xlab ylab facet_wrap theme
#' @author Isabella Bitetto <bitetto@fondazionecoispa.org>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_ALK_MLAA(data = ALK_tab_example, SP = "MUT", MS = "ITA", GSA = "GSA 99")
MEDBS_ALK_MLAA <- function(data, SP, MS, GSA, verbose = TRUE) {

  AGE <- len <- START_YEAR <- END_YEAR<-SEX<- AREA<-length_cm<-mean_length<-YEARS<-NULL
  colnames(data) <- toupper(colnames(data))

  data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, ]
  ALK <- data
  if (nrow(ALK) > 0) {

    alk_LENGTH <- ALK[,c(14:114)]
    alk_LENGTH[alk_LENGTH == -1] <- 0
    ALK <- cbind( ALK[,c(1:13)],alk_LENGTH)
    unit <- unique(ALK$UNIT)
    sexes <- unique(ALK$SEX)
    plots <- list()

    # estimation of the mean length at age

    df_long <- data.frame(ALK %>%
        pivot_longer(
            cols = starts_with("LENGTHCLASS"),
            names_to = "LENGTHCLASS",
            values_to = "count"
        ) %>%
        mutate(
            # Estrai il numero dalla colonna LENGTHCLASS
            length_cm = case_when(
                LENGTHCLASS == "LENGTHCLASS100_PLUS" ~ 100,
                TRUE ~ as.numeric(str_remove(LENGTHCLASS, "LENGTHCLASS"))
            )
        ))

    # Calcolo media pesata per anno, sesso ed età
    mean_lengths <- df_long %>%
        group_by(START_YEAR, END_YEAR,SEX, AGE,AREA) %>%
        summarise(
            mean_length = weighted.mean(length_cm, count, na.rm = TRUE),
            total_n = sum(count, na.rm = TRUE),
            .groups = "drop"
        )
    mean_lengths$YEARS=""
    mean_lengths$YEARS=paste(mean_lengths$START_YEAR,"-", mean_lengths$END_YEAR)


    if ("F" %in% sexes) {
        mean_lengths_F <- mean_lengths[mean_lengths$SEX == "F", ]
      #unit <- unique(ALK_F$UNIT)
      mean_lengths_F <- as.data.table(mean_lengths_F)
      p <- ggplot(data = mean_lengths_F, aes(x = AGE, y = mean_length, col = YEARS)) +
        geom_point(stat = "identity") +
        ggtitle(paste("Females", SP, MS, GSA, sep = " - ")) +
        labs(col = "Year") +
        xlab("Age") +
        ylab(paste("Length (", unit, ")")) +
        facet_wrap(YEARS ~ .) +
        theme(legend.position = "none")

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("Females", SP, MS, GSA, sep = " - ")
    }

    if ("M" %in% sexes) {
        mean_lengths_M <- mean_lengths[mean_lengths$SEX == "M", ]
        #unit <- unique(ALK_F$UNIT)
        mean_lengths_M <- as.data.table(mean_lengths_M)
        p <- ggplot(data = mean_lengths_M, aes(x = AGE, y = mean_length, col = YEARS)) +
            geom_point(stat = "identity") +
            ggtitle(paste("Males", SP, MS, GSA, sep = " - ")) +
            labs(col = "Year") +
            xlab("Age") +
            ylab(paste("Length (", unit, ")")) +
            facet_wrap(YEARS ~ .) +
            theme(legend.position = "none")

        l <- length(plots) + 1
        plots[[l]] <- p
        names(plots)[[l]] <- paste("Males", SP, MS, GSA, sep = " - ")
    }

    if ("C" %in% sexes) {
        mean_lengths_C <- mean_lengths[mean_lengths$SEX == "C", ]
        #unit <- unique(ALK_F$UNIT)
        mean_lengths_C <- as.data.table(mean_lengths_C)
        p <- ggplot(data = mean_lengths_C, aes(x = AGE, y = mean_length, col = YEARS)) +
            geom_point(stat = "identity") +
            ggtitle(paste("Combined", SP, MS, GSA, sep = " - ")) +
            labs(col = "Year") +
            xlab("Age") +
            ylab(paste("Length (", unit, ")")) +
            facet_wrap(YEARS ~ .) +
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
  }
}
