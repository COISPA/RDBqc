#' Check for missing years in MED & BS tables
#'
#' @param data data frame containing either landings, discards or catch data
#' @param end_year numeric value reporting the final year of the time series for the given country
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards; "c" for catch table.
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the presence of missing years in MED & BS tables data.
#' @return The function returns a vector containing the missing years in data. NULL is returned in case no data were available for the selected combination of country, GSA and species. A vector of length 0 is returned in case there are no missing years in the data.
#' @examples
#' df <- Discard_tab_example[-which(Discard_tab_example$year==2011),]
#' MEDBS_check_missing_years(
#'   data = df, end_year=2002, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @export MEDBS_check_missing_years
#' @author Walter Zupa <zupa@@coispa.it>

MEDBS_check_missing_years <- function(data, end_year, type = "l", SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- Landing_tab_example
    type <- "l"
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    verbose <- TRUE
    end_year <- 2022

    MEDBS_check_missing_years(data = data, end_year, type = "l", MS = "ITA", GSA = "GSA 18", SP = "NEP", verbose = FALSE)
  }

  COUNTRY <- AREA <- NULL

  start_survey <- data.frame(
    countries = c(
      "BGR",
      "CYP",
      "ESP",
      "FRA",
      "GRC",
      "HRV",
      "ITA",
      "MLT",
      "ROU",
      "SVN"
    ),
    start_year = c(
      2008,
      2005,
      2002,
      2002,
      2003,
      2012,
      2002,
      2005,
      2008,
      2005
    )
  )

  data <- as.data.frame(data)
  colnames(data) <- toupper(colnames(data))

  # d <- data[data$COUNTRY ==MS, ]
  # if (nrow(d)>0){
  #   d <- as.data.frame(suppressMessages(d %>% group_by(COUNTRY,AREA) %>% summarise()))
  # } else {
  #   d = NULL
  # }

  data <- data[data$AREA %in% as.character(GSA) & data$COUNTRY == MS & data$SPECIES %in% SP, ]
  if (type %in% c("l", "d", "c")) {
    if (nrow(data)>0) {
       ry <- range(start_survey[start_survey$countries==MS, "start_year"]:end_year)
       ry <- seq(ry[1],ry[2],1)
       observed <- sort(unique(data$YEAR))
       missing <- ry[which(! ry %in% observed)]
    } else {
      if (verbose) {
        message(paste0("No data available for the selected combination of country, GSA and species."))
      }
      missing <- NULL
    }
    return(missing) # ,d
  } else {
    if (verbose) {
      message(paste0("Wrong table format selected."))

    }
    missing <- NULL
  }
}
