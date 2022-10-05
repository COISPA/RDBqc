#' check NA values in spatial columns of both table H and I
#'
#' @description The function checks the incorrect combination of NA in the spatial columns in both table H (Landings by rectangle) and table I (Effort by rectangle). The following check are included:
#' \enumerate{
#' \item{presence of NA values in 'c_square' field when 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are all NA;}
#' \item{the presence any data in 'rectangle_type', 'rectangle_lat', 'rectangle_lon' when 'c_square' is reported;}
#' \item{the presence of any data in 'c-squares' when 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are filled in.}
#' }
#' Furthermore the function identifies the records without any sub-region assignment.
#' @param data data frame of one between FDI table H (Landings by rectangle) and table I (Effort by rectangle)
#' @param MS Country code
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list of 2 tables. The first (NA_inconsistencies) reports the records with the inconsistencies detected in spatial of the selected table, while the second one reports the record without any sub_region assignment.
#' @export
#' @examples FDI_checks_spatial_HI(data = fdi_h_spatial_landings, MS = "PSP", verbose = TRUE)
#' FDI_checks_spatial_HI(data = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)
#' @import tidyverse

FDI_checks_spatial_HI <- function(data, MS, verbose = FALSE) {
  colnames(data) <- tolower(colnames(data))
  data <- data[data$country %in% MS, ]

  if (nrow(data) > 0) {

    ####################
    # check NA in 'c_square' when 'rectangle_type', 'rectangle_lat' and 'rectangle_lon' are all NA
    d1_ids <- which(is.na(data$rectangle_type) & is.na(data$rectangle_lat) & is.na(data$rectangle_lon) & is.na(data$c_square))

    if (length(d1_ids) == 0) {
      if (verbose) {
        message(paste("no NAs in 'c_square' field when 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are all NA"))
      }
    } else {
      l_na_d1 <- length(d1_ids)
      if (verbose) {
        message(paste(l_na_d1, "NAs in 'c_square' field when 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are all NA"))
      }
    }

    #####################
    # check not NA values in 'rectangle_type', 'rectangle_lat' and 'rectangle_lon' when 'c_square' is reported
    d2_ids <- which((!is.na(data$rectangle_type) | !is.na(data$rectangle_lat) | !is.na(data$rectangle_lon)) & !is.na(data$c_square))

    if (length(d2_ids) == 0) {
      if (verbose) {
        message(paste("no data reported in 'rectangle_type', 'rectangle_lat', 'rectangle_lon' when 'c_square' is reported"))
      }
    } else {
      l_na_d2 <- length(d2_ids)
      if (verbose) {
        message(paste(l_na_d2, " record with at least one data among 'rectangle_type', 'rectangle_lat', 'rectangle_lon' when 'c_square' is reported"))
      }
    }


    #####################
    # check not NA values in 'c_square' when all 'rectangle_type', 'rectangle_lat' and 'rectangle_lon' are filled in
    d3_ids <- which((!is.na(data$rectangle_type) & !is.na(data$rectangle_lat) & !is.na(data$rectangle_lon)) & !is.na(data$c_square))

    if (length(d3_ids) == 0) {
      if (verbose) {
        message(paste("no data reported in 'c-squares' when 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are filled in"))
      }
    } else {
      l_na_d3 <- length(d3_ids)
      if (verbose) {
        message(paste(l_na_d3, " record with not NA values in 'c_square' when all 'rectangle_type', 'rectangle_lat', 'rectangle_lon' are filled in"))
      }
    }

    #################

    ids <- unique(c(d1_ids, d2_ids, d3_ids))

    d <- data[ids, c(1:11, 16:19)]

    #######################################

    id_nk <- which(data$sub_region == "NK")

    if (verbose) {
      message(paste(length(id_nk), "record/s with 'NK' values in 'sub_region' field"))
    }

    id_na <- which(is.na(data$sub_region) | data$sub_region == "NA")

    if (verbose) {
      message(paste(length(id_na), "record/s with 'NA' values in 'sub_region' field"))
    }

    ids2 <- unique(c(id_nk, id_na))
    d2 <- data[ids2, c(1:11)]
  } else {
    if (verbose) {
      message(paste0("Nodata available in selected table for the selected MS"))
    }
    d <- NULL
    d2 <- NULL
  }
  return(list(NA_inconsistencies = d, missing_sub_region = d2))
}
