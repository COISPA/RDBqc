#' Check of weights 0 in landings and discards
#'
#' @param data data.table object containing landing or discard data
#' @param type type of table: "l" for landings; "d" for discards
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks landings or discards in weight equal to 0 having length classes filled in
#' @return The function returns a table of rows with 0 values in weights having length classes filled in.
#' @examples MEDBS_weight_0(
#'   data = Landing_tab_example, type = "l",
#'   SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_weight_0(
#'   data = Discard_tab_example, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @importFrom utils globalVariables
#' @export MEDBS_weight_0
#'

MEDBS_weight_0 <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  poi <- NULL
  colnames(data) <- tolower(colnames(data))
  data <- data[data$area == as.character(GSA) & data$country == MS & data$species == SP, ]

  if (type == "l") {
    if (length(which(data$landings == 0)) > 0) {
      land_vs_length <- data[data$landings == 0, ]
      land_vs_length <- as.data.frame(land_vs_length)
      var_land <- grep("lengthclass", names(land_vs_length), value = TRUE)
      sel_nl_1 <- c(var_land)
      poi <- (land_vs_length[, which(names(land_vs_length) %in% sel_nl_1)])
      poi[is.na(poi)] <- 0
      poi[poi == -1] <- 0
      poi[poi == ""] <- 0
      poi[poi == "-"] <- 0
      ck_nbl_1 <- rowSums(poi, na.rm = TRUE)
      land_vs_length <- cbind(land_vs_length[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)], ck_nbl_1)
      land_vs_length$diff <- (land_vs_length$landings - land_vs_length$ck_nbl_1)
      n_0 <- length(which(land_vs_length$diff != 0))
      df <- land_vs_length[which(land_vs_length$diff != 0), c(1:14)]
      colnames(df)[14] <- "sum_individuals"
      if (verbose) {
        message(paste0(n_0, " cases in which length class number differ from zero if landing = 0"))
      }
    } else {
      if (verbose) {
        message("There aren\'t 0 landings")
      }
      df <- data[0, c(1:13)]
    }
  }

  if (type == "d") {
    #-----------------------------
    data <- as.data.frame(data)
    var_no_landed <- grep("lengthclass", names(data), value = TRUE)
    sel_nl <- c(var_no_landed)
    cols_no_length <- colnames(data)[which(!colnames(data) %in% sel_nl)]
    length_cols <- (data[, which(names(data) %in% sel_nl)])
    length_cols = suppressWarnings(apply(length_cols, 2, function(x) as.numeric(as.character(x))))
    length_cols[is.na(length_cols)] <- 0
    no_lenght_col <- data[, which(colnames(data) %in% cols_no_length)]
    data <- cbind(no_lenght_col, length_cols)
    data
    #-----------------------------
    if (length(which(data$discards == 0)) > 0) {
      land_vs_length <- data[data$discards == 0, ]
      land_vs_length <- as.data.frame(land_vs_length)
      var_land <- grep("lengthclass", names(land_vs_length), value = TRUE)
      sel_nl_1 <- c(var_land)
      poi <- (land_vs_length[, which(names(land_vs_length) %in% sel_nl_1)])
      poi[is.na(poi)] <- 0
      poi[poi == -1] <- 0
      poi[poi == ""] <- 0
      poi[poi == "-"] <- 0
      ck_nbl_1 <- rowSums(poi, na.rm = TRUE)
      land_vs_length <- cbind(land_vs_length[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)], ck_nbl_1)
      land_vs_length$diff <- (land_vs_length$discards - land_vs_length$ck_nbl_1)
      n_0 <- length(which(land_vs_length$diff != 0))
      df <- land_vs_length[which(land_vs_length$diff != 0), c(1:14)]
      colnames(df)[14] <- "sum_individuals"
      if (verbose) {
        message(paste0(n_0, " cases in which length class number differ from zero if discard = 0"))
      }
    } else {
      if (verbose) {
        message("There aren\'t 0 discards")
      }
      df <- data[0, c(1:13)]
    }
  }
  return(df)
}
