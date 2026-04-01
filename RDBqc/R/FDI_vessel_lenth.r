#' Check of vessel lenght in FDI table J
#'
#' @param data data frame of table J
#' @param MS country code
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function checks the average length vessels with the vessel length category (table J)
#' @return The function returns a list of two data frames. The first reports the records with NAs in either vessel length or vessel category or both, while the second table reports the cases in which vessel length does not match vessel length category.
#' @export
#' @author Vasiliki Sgardeli <vsgard@@hcmr.gr>
#' @author Walter Zupa <zupa@@coispa.it>
#' @importFrom utils globalVariables
#' @examples FDI_vessel_lenth(data = fdi_j_capacity, MS = "PSP", verbose = TRUE)
FDI_vessel_lenth <- function(data, MS, verbose = TRUE) {
  country <- NULL

  ### adaptation for new FDI table structure ------
  colnames(data) <- tolower(colnames(data))
  if ("latitude" %in% colnames(data)) {
    colnames(data)[which(colnames(data)=="latitude")] <- "rectangle_lat"
  }
  if ("longitude" %in% colnames(data)) {
    colnames(data)[which(colnames(data)=="longitude")] <- "rectangle_lon"
  }
  if ("metier_7" %in% colnames(data)) {
    data <- data[ , -(which(colnames(data)%in% "metier_7"))]
  }
  #-----------------------------------------------

  # check if MS is existing
  mslist <- unique(data$country)

  if (MS %in% mslist) {
    if (verbose) {
      print(paste("Check consistency of vessel length with vessel category in table J for", MS, "data", sep = " "))
    }

    # subset for MS
    data <- subset(data, country == MS)
    data <- subset(data, vessel_length != "NK")
    data <- data[!is.na(data$vessel_length), ]
    # Make a data frame with vessel category length (min, max) and vessel lengths
    VC <- data$vessel_length
    VL <- as.numeric(data$avgloa)
    mVL <- max(VL,na.rm=TRUE)
    vc_min <- as.numeric(substr(VC, 3, 4))
    VCm <- substr(VC, 5, 6)
    VCm[VCm=="XX"] <- mVL
    vc_max <- as.numeric(VCm)

    data$consistent <- rep(TRUE, length(VC)) # flag to record whether length cat. is consistent with actual repoted length

    # do the check, compare vessel length with category
    x1 <- VL - vc_min
    x2 <- VL - vc_max
    ind <- which(!(x1 >= 0 & x2 <= 0)) # check for lengths outside length category
    ind1 <- which(is.na(x1) | is.na(x2)) # check for NAs in either vessel length or category (or both)

    if (length(ind1) != 0) {
      message(paste("found", length(ind1), "cases with NAs in either vessel length or vessel category or both. Check output table", sep = " "))
      data$consistent[ind1] <- NA
      data_NAs <- as.data.frame(data[ind1, -c(4, 5, 6, 8, 14)])
    } else {
      data_NAs <- NULL
    }
    if (length(ind) != 0) {
      data$consistent[ind] <- FALSE
      message(paste("found", length(ind), "cases where vessel length does not match vessel length category", sep = " "))
      data_FALSE <- as.data.frame(data[ind, -c(4, 5, 6, 8, 14)])
    } else {
      print("Vessel length within vessel length category for all records")
      data_FALSE <- NULL
    }
  } else if (!(MS %in% mslist)) {
    message(paste("MS ", MS, " not existing in table J"))
    data_NAs <- NULL
    data_FALSE <- NULL
  }
  return(list(Table_of_NAs = data_NAs, Table_of_mismatches = data_FALSE))
}


utils::globalVariables(c(
  "vessel_length"
))
