#' Checks length classes numbers with zeros in landings and discards
#'
#' @param data data frame containing landing  or discards data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards.
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks landings and discards for the presence of length class filled in having weigth > 0.
#' @return The function returns a data frame with the rows with 0 values length class having weigth > 0.
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_lengthclass_0(
#'   data = Landing_tab_example, type = "l",
#'   SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' MEDBS_lengthclass_0(
#'   data = Discard_tab_example, type = "d", SP = "DPS",
#'   MS = "ITA", GSA = "GSA 9", verbose = TRUE
#' )
#' @importFrom utils globalVariables
#' @export MEDBS_lengthclass_0

MEDBS_lengthclass_0 <- function(data, type = "l", SP, MS, GSA, verbose = TRUE) {
  poi2 <- NULL # in combination with @importFrom utils globalVariables
  colnames(data) <- tolower(colnames(data))
  data <- data[which(data$area == as.character(GSA) & data$country == MS & data$species == SP), ]

  if (type == "l") {

    if (length(which(data$landings > 0))>0) {
      land <- data
      land_vs_length_minus2 <- land[land$landings > 0, ]
      land_vs_length_minus2 <- as.data.frame(land_vs_length_minus2)

      var_land2 <- grep("lengthclass", names(land_vs_length_minus2), value = TRUE)
      sel_nl_2 <- c(var_land2)
      poi2 <- (land_vs_length_minus2[, which(names(land_vs_length_minus2) %in% sel_nl_2)])
      poi2[is.na(poi2)] <- 0
      poi2[poi2 == -1] <- 0
      poi2[poi2 == ""] <- 0
      poi2[poi2 == "-"] <- 0
      ck_nbl_1b <- rowSums(poi2)
      land_vs_length_minus2 <- cbind(land_vs_length_minus2[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)], ck_nbl_1b)
      colnames(land_vs_length_minus2)[ncol(land_vs_length_minus2)] <- "ck_0_length"
      n_LC_0 <- length(which(land_vs_length_minus2$ck_0_length == 0, arr.ind = T))
      if (verbose) {
        message(paste0(n_LC_0, " cases in which length class number are zero and landings > 0"))
      }
      result <- land_vs_length_minus2[which(land_vs_length_minus2$ck_0_length == 0, arr.ind = T), ]
      return(result)
    } else {
      if (verbose) {
        message(paste0("No landings  data in weight > 0"))
      }
      result <- data.frame(matrix(ncol = 13, nrow = 0))
      colnames(result) <- c("id", "country", "year", "quarter", "vessel_length", "gear", "mesh_size_range", "fishery", "area", "specon", "species", "landings", "ck_0_length")
      return(result)
    }
  }

  if (type == "d") {
    if (length(which(data$discards > 0))>0) {
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
      land <- data
      land_vs_length_minus2 <- land[land$discards > 0, ]
      land_vs_length_minus2 <- as.data.frame(land_vs_length_minus2)

      var_land2 <- grep("lengthclass", names(land_vs_length_minus2), value = TRUE)
      sel_nl_2 <- c(var_land2)
      poi2 <- (land_vs_length_minus2[, which(names(land_vs_length_minus2) %in% sel_nl_2)])
      poi2[is.na(poi2)] <- 0
      poi2[poi2 == -1] <- 0
      poi2[poi2 == ""] <- 0
      poi2[poi2 == "-"] <- 0
      ck_nbl_1b <- rowSums(poi2)
      land_vs_length_minus2 <- cbind(land_vs_length_minus2[, c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)], ck_nbl_1b)
      colnames(land_vs_length_minus2)[ncol(land_vs_length_minus2)] <- "ck_0_length"
      n_LC_0 <- length(which(land_vs_length_minus2$ck_0_length == 0, arr.ind = T))
      if (verbose) {
        message(paste0(n_LC_0, " cases in which length class number are zero and discards > 0"))
      }
      result <- land_vs_length_minus2[which(land_vs_length_minus2$ck_0_length == 0, arr.ind = T), ]
      return(result)
    } else {
      if (verbose) {
        message(paste0("No discards data in weight > 0"))
      }
      result <- data.frame(matrix(ncol = 13, nrow = 0))
      colnames(result) <- c("id", "country", "year", "quarter", "vessel_length", "gear", "mesh_size_range", "fishery", "area", "specon", "species", "discards", "ck_0_length")
      return(result)
    }
  }
}
