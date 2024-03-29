#' Check weights -1 in landings
#'
#' @param data data.table object containing landing or discards data
#' @param type type of table: "l" for landings; "d" for discards
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned.
#' @description The function checks landings in weight equal to -1 having length class filled in
#' @return The function returns a table of rows with -1 values in landing weights having length class filled in.
#' @examples MEDBS_weight_minus1(
#'   data = Landing_tab_example, type = "l",
#'   SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_weight_minus1(
#'   data = Discard_tab_example, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @importFrom utils globalVariables
#' @export MEDBS_weight_minus1
MEDBS_weight_minus1 <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  poi <- NULL
  colnames(data) <- tolower(colnames(data))
  data <- data[which(data$area == as.character(GSA) & data$country == MS & data$species == SP), ]

  if (type == "l") {
    if (length(which(data$landings == -1)) > 0) {
      land_vs_length_minus1 <- data[data$landings == -1, ]
      land_vs_length_minus1 <- as.data.frame(land_vs_length_minus1)
      var_land1 <- grep("lengthclass", names(land_vs_length_minus1), value = TRUE)
      sel_nl_1 <- c(var_land1)
      poi1 <- (land_vs_length_minus1[, which(names(land_vs_length_minus1) %in% sel_nl_1)])
      poi1[is.na(poi1)] <- 0
      poi1[poi1 == -1] <- 0
      poi1[poi1 == ""] <- 0
      poi1[poi == "-"] <- 0
      ck_nbl_1a <- rowSums(poi1)
      land_vs_length_minus1 <- cbind(land_vs_length_minus1[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)], ck_nbl_1a)
      land_vs_length_minus1$diff <- (land_vs_length_minus1$landings - land_vs_length_minus1$ck_nbl_1a)
      n_minus1 <- length(which(land_vs_length_minus1$diff != -1))
      df <- land_vs_length_minus1[which(land_vs_length_minus1$diff != -1), c(1:13)]
      colnames(df)[13] <- "sum_individuals"

      if (verbose) {
        message(paste0(n_minus1, " cases in which length class number differ from zero and landing = -1"))
      }
    } else {
      if (verbose) {
        message("There aren\'t -1 landings")
      }
      df <- data[0, c(1:13)]
    }
  }

  if (type == "d") {
    if (length(which(data$discards == -1)) > 0) {
      land_vs_length_minus1 <- data[data$discards == -1, ]
      land_vs_length_minus1 <- as.data.frame(land_vs_length_minus1)
      var_land1 <- grep("lengthclass", names(land_vs_length_minus1), value = TRUE)
      sel_nl_1 <- c(var_land1)
      poi1 <- (land_vs_length_minus1[, which(names(land_vs_length_minus1) %in% sel_nl_1)])
      poi1[is.na(poi1)] <- 0
      poi1[poi1 == -1] <- 0
      poi1[poi1 == ""] <- 0
      poi1[poi == "-"] <- 0
      ck_nbl_1a <- rowSums(poi1)
      land_vs_length_minus1 <- cbind(land_vs_length_minus1[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)], ck_nbl_1a)
      land_vs_length_minus1$diff <- (land_vs_length_minus1$discards - land_vs_length_minus1$ck_nbl_1a)
      n_minus1 <- length(which(land_vs_length_minus1$diff != -1))
      df <- land_vs_length_minus1[which(land_vs_length_minus1$diff != -1), c(1:13)]
      colnames(df)[13] <- "sum_individuals"
      if (verbose) {
        message(paste0(n_minus1, " cases in which length class number differ from zero and discard = -1"))
      }
    } else {
      if (verbose) {
        message("There aren\'t -1 discards")
      }
      df <- data[0, c(1:13)]
    }
  }
  return(df)
}
