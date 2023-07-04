#' Check for missing years in MED & BS tables
#'
#' @param data data frame containing either landings, discards or catch data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards; "c" for catch table; "gp" for growth parameters table; "alk" for age-length keys table; "ma" for maturity at age table; "ml" for maturity at length table; "sra" for sex ratio at age table; "srl" for maturity at length table..
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the presence of missing years in MED & BS tables data.
#' @return The function returns a vector containing the missing years in data. NULL is returned in case no data were available for the selected combination of country, GSA and species. A vector of length 0 is returned in case there are no missing years in the data.
#' @examples
#' df <- Discard_tab_example[-which(Discard_tab_example$year==2011),]
#' MEDBS_check_missing_years(
#'   data = df, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @export MEDBS_check_missing_years
#' @author Walter Zupa <zupa@@coispa.it>

MEDBS_check_missing_years <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- Landing_tab_example
    type <- "l"
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    verbose <- TRUE

    MEDBS_check_missing_years(data = data, type = "l", MS = "ITA", GSA = "GSA 18", SP = "NEP", verbose = FALSE)
  }

  data <- as.data.frame(data)
  colnames(data) <- toupper(colnames(data))
  data <- data[data$AREA %in% as.character(GSA) & data$COUNTRY == MS & data$SPECIES %in% SP, ]
  if (type %in% c("l", "d", "c")) {
    if (nrow(data)>0) {
       ry <- range(data$YEAR)
       ry <- seq(ry[1],ry[2],1)
       observed <- sort(unique(data$YEAR))
       missing <- ry[which(! ry %in% observed)]
    } else {
      if (verbose) {
        message(paste0("No data available for the selected combination of country, GSA and species."))

      }
      missing <- NULL
    }
    return(missing)
  } else {
    if (verbose) {
      message(paste0("Wrong table format selected."))

    }
    missing <- NULL
  }
}
