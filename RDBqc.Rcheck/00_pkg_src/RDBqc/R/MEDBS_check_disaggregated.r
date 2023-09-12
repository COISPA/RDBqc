#' Check for disaggregated data rows in landings, discards and catch tables
#'
#' @param data data frame containing either landings, discards or catch data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards; "c" for catch table.
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the presence of disaggregated data (same stratum but with different volumes of landings and discards) rows in MED & BS landings, discards and catch tables.
#' @return The function returns a data frame containing the disaggregated rows to be likely aggregated  in the data.
#' @examples
#' MEDBS_check_disaggregated(
#'   data = Discard_tab_example, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_check_disaggregated(
#'   data = Landing_tab_example, type = "l", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_check_disaggregated(
#'   data = Catch_tab_example, type = "c", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @export MEDBS_check_disaggregated
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @importFrom plyr match_df

MEDBS_check_disaggregated <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    # data <- Catch_tab_example
    # type <- "c"
    # MS <- "ITA"
    # GSA <- "GSA 9"
    # SP <- "DPS"
    # verbose <- TRUE
    # data <- rbind(data[1,],data)
    # data <- rbind(data[4,],data)
    # data[2,"landings"] <- 2
    # MEDBS_check_disaggregated(data = data, type = "c", MS = "ITA", GSA = "GSA 9", SP = "DPS", verbose = FALSE)
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
    duplicated_rows <- table(duplicated(data[, c(2:13)]))
    row_duplicated <- which(duplicated(data[, c(2:13)]))
    if (length(row_duplicated)>0) {
      data <- data[-row_duplicated, ]
    }

    disaggregated_rows <- table(duplicated(data[, c(2:11)]))
    row_to_check <- which(duplicated(data[, c(2:11)]))

    if (length(row_to_check)!=0){
      disaggr <- data.frame(matrix(ncol=13, nrow=0))
      colnames(disaggr) <- colnames(data[,c(1:13)])
      disaggregated_rows <- NULL
      n=1
      for (n in 1: length(row_to_check)){
        rows <- rownames(match_df(data[,c(2:11)], data[row_to_check[n],c(2:11)]))
        disaggr <- rbind(disaggr,data[rownames(data) %in% rows, c(1:13)])
      }
    } else {
      disaggr <- NULL
    }
  } else if (type == "c") {
    duplicated_rows <- table(duplicated(data[, c(2:24)]))
    row_duplicated <- which(duplicated(data[, c(2:24)]))
    if (length(row_duplicated)>0) {
      data <- data[-row_duplicated, ]
    }

    disaggregated_rows <- table(duplicated(data[, c(2:11)]))
    row_to_check <- which(duplicated(data[, c(2:11)]))

        if (length(row_to_check)!=0){
        disaggr <- data.frame(matrix(ncol=13, nrow=0))
        colnames(disaggr) <- colnames(data[,c(1:13)])
        disaggregated_rows <- NULL
        n=1
        for (n in 1: length(row_to_check)){
          rows <- rownames(match_df(data[,c(2:11)], data[row_to_check[n],c(2:11)]))
          disaggr <- rbind(disaggr,data[rownames(data) %in% rows, c(1:13)])
        }
        }  else {
          disaggr <- NULL
        }
  }


    if (!is.null(disaggr)){
    if (verbose) {
      message(paste("There is/are", nrow(disaggr), "disaggregated row/rows in the data."))
      return(disaggr)
    } else {
      return(disaggr)
    }
    } else {
      return(disaggr)
    }




}
