#' Check for duplicated data rows in landings, discards and catch tables
#'
#' @param data data frame containing either landings, discards or catch data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards; "c" for catch table; "gp" for growth parameters table; "alk" for age-length keys table; "ma" for maturity at age table; "ml" for maturity at length table; "sra" for sex ratio at age table; "srl" for maturity at length table..
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the presence of duplicated rows in MED & BS tables data.
#' @return The function returns a data frame containing the duplicated rows to be likely deleted from the data.
#' @examples
#' MEDBS_check_duplicates(
#'   data = Discard_tab_example, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_check_duplicates(
#'   data = Landing_tab_example, type = "l", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_check_duplicates(
#'   data = Catch_tab_example, type = "c", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @export MEDBS_check_duplicates
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>

MEDBS_check_duplicates <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- GP_tab_example
    type <- "gp"
    MS <- "ITA"
    GSA <- "GSA 18"
    SP <- "MUT"
    verbose <- TRUE

    MEDBS_check_duplicates(data = data, type = "l", MS = "ITA", GSA = "GSA 18", SP = "NEP", verbose = FALSE)
  }

  data <- as.data.frame(data)
  colnames(data) <- toupper(colnames(data))
  data <- data[data$AREA %in% as.character(GSA) & data$COUNTRY == MS & data$SPECIES %in% SP, ]

  if (type == "l") {
    data$LANDINGS[data$LANDINGS == -1] <- 0
  }

  if (type == "d") {
    data$DISCARDS[data$DISCARDS == -1] <- 0
  }

  if (type == "c") {
    data$DISCARDS[data$DISCARDS == -1] <- 0
    data$LANDINGS[data$LANDINGS == -1] <- 0
  }

  if (type %in% c("l", "d")) {
    duplicate_rows <- table(duplicated(data[, c(2:13)])) # FALSE means no duplicated records are present
    row_to_del <- which(duplicated(data[, c(2:13)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:13)]    }
  } else if (type == "c") {
    duplicate_rows <- table(duplicated(data[, c(2:24)])) # FALSE means no duplicated records are present
    row_to_del <- which(duplicated(data[, c(2:24)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:24)]
    }
  } else if (type=="gp") {
    duplicate_rows <- table(duplicated(data[, c(1:6)]))
    row_to_del <- which(duplicated(data[, c(1:6)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:6)]
    }
  } else if (type=="alk") {
    duplicate_rows <- table(duplicated(data[, c(1:7,12)]))
    row_to_del <- which(duplicated(data[, c(1:7,12)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:7,12)]
    }
  } else if (type=="ma" | type=="ml") {
    duplicate_rows <- table(duplicated(data[, c(1:7)]))
    row_to_del <- which(duplicated(data[, c(1:7)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:7)]
    }
  }  else if (type=="sra" | type=="srl") {
    duplicate_rows <- table(duplicated(data[, c(1:6)]))
    row_to_del <- which(duplicated(data[, c(1:6)]))
    if (length(row_to_del)!=0){
      dupl <- data[row_to_del, c(1:6)]
    }
  }

  if (verbose) {
    if (length(row_to_del) != 0) {
      message(paste("There is/are", length(row_to_del), "replicated row/rows in the data."))
      return(dupl)
    } else if (length(row_to_del) == 0) {
      message(paste("No duplicated records in the data."))
      return(NULL)
    }
  } else {
    if (length(row_to_del) != 0) {
      return(dupl)
    } else if (length(row_to_del) == 0) {
      return(NULL)
    }
  }
}
