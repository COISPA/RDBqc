#' Check on numbers in ALK
#'
#' @param data ALK table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned.
#' @description The function allows to verify the numbers of individuals in the ALK table by sex and age for a selected species
#' @return a list of recrods with mismatches is return.
#' @export
#' @importFrom dplyr mutate group_by summarise case_when
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_remove str_detect
#' @importFrom tidyselect starts_with
#' @importFrom magrittr %>%
#' @importFrom readr parse_number
#' @author Isabella Bitetto <bitetto@fondazionecoispa.org>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_ALK_NB(data = ALK_tab_example, SP = "MUT", MS = "ITA", GSA = "GSA 99")
MEDBS_ALK_NB <- function(data, SP, MS, GSA, verbose = TRUE) {
  AGE <- len <- START_YEAR <- END_YEAR<-SEX<- AREA<-length_cm<-TOTAL_NUMBER_OF_HARD_STRUCTURE_READ_BY_AGE<-YEARS<-LENGTHCLASS<-NULL
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

    #

    df_long <- ALK %>%
        pivot_longer(
            cols = starts_with("LENGTHCLASS"),
            names_to = "LENGTHCLASS",
            values_to = "count"
        ) %>%
        mutate(
            LENGTHCLASS = as.character(LENGTHCLASS),
            length_cm   = readr::parse_number(LENGTHCLASS)
        )

    # estimation of total numbers
    nb_total <- df_long %>%
        group_by(START_YEAR, END_YEAR,SEX, AREA,TOTAL_NUMBER_OF_HARD_STRUCTURE_READ_BY_AGE, LENGTHCLASS) %>%
        summarise(
            #num_reported = sum(TOTAL_NUMBER_OF_HARD_STRUCTURE_READ_BY_AGE, na.rm = TRUE),
            total_n = sum(count, na.rm = TRUE),
            .groups = "drop"
        )
    #mean_lengths$YEARS=""
    #mean_lengths$YEARS=paste(mean_lengths$START_YEAR,"-", mean_lengths$END_YEAR)
    nb_total$diff=nb_total$TOTAL_NUMBER_OF_HARD_STRUCTURE_READ_BY_AGE-nb_total$total_n
    errors=data.frame(nb_total[which(nb_total$diff!=0),])

if (nrow(data)>0){

return(errors)

}
  } else {
    if (verbose & nrow(data)==0) {
      message("No data for the selected combination of SP, MS, GSA ")
    }
  }
}
