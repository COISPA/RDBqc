#' Coverage comparison of totfishdays between FDI tables G and I
#'
#' @param dataG data frame of FDA table G
#' @param dataI data frame of FDA table I
#' @param MS country code
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function checks the comparison of totfishdays in FDI tables G and I
#' @return The function returns a data frame of the comparison of totfishdays between FDI tables G and I
#' @export
#' @author Vasiliki Sgardeli <vsgard@@hcmr.gr>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_fishdays_cov(dataG = fdi_g_effort, dataI = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)
FDI_fishdays_cov <- function(dataG, dataI, MS, verbose = TRUE) {
  colnames(dataG) <- tolower(colnames(dataG))
  colnames(dataI) <- tolower(colnames(dataI))

  ### adaptation for new FDI table structure ------
  colnames(dataG) <- tolower(colnames(dataG))
  if ("latitude" %in% colnames(dataG)) {
    colnames(dataG)[which(colnames(dataG)=="latitude")] <- "rectangle_lat"
  }
  if ("longitude" %in% colnames(dataG)) {
    colnames(dataG)[which(colnames(dataG)=="longitude")] <- "rectangle_lon"
  }
  if ("metier_7" %in% colnames(dataG)) {
    dataG <- dataG[ , -(which(colnames(dataG)%in% "metier_7"))]
  }
  #-----------------------------------------------

  ### adaptation for new FDI table structure ------
  colnames(dataI) <- tolower(colnames(dataI))
  if ("latitude" %in% colnames(dataI)) {
    colnames(dataI)[which(colnames(dataI)=="latitude")] <- "rectangle_lat"
  }
  if ("longitude" %in% colnames(dataI)) {
    colnames(dataI)[which(colnames(dataI)=="longitude")] <- "rectangle_lon"
  }
  if ("metier_7" %in% colnames(dataI)) {
    dataI <- dataI[ , -(which(colnames(dataI)%in% "metier_7"))]
  }
  #-----------------------------------------------

  country <- NULL

  # check if MS is existing
  mslistG <- unique(dataG$country)
  mslistI <- unique(dataI$country)

  if (MS %in% mslistG & MS %in% mslistI) {
    if (verbose) {
      print(paste("Coverage of total fish days for", MS, "data in tables G and I", sep = " "))
    }

    # subset for MS
    dataG <- subset(dataG, country == MS)
    dataI <- subset(dataI, country == MS)
    dataG$id <- seq(1, nrow(dataG), 1)
    dataI$id <- seq(1, nrow(dataI), 1)

    gsasG <- unique(dataG$sub_region)
    gsasI <- unique(dataI$sub_region)
    yrsG <- unique(dataG$year)
    yrsI <- unique(dataI$year)

    # check there are gsas and years reported
    if (is.null(gsasG)) {
      stop("No SUB_REGIONS existing in table G")
    }
    if (is.null(yrsG)) {
      stop("No YEARS existing in table G")
    }
    if (is.null(gsasI)) {
      stop("No SUB_REGIONS existing in table I")
    }
    if (is.null(yrsI)) {
      stop("No YEARS existing in table I")
    }

    # check for NAs in gsas or years reported
    gsasG <- dataG$sub_region
    gsasI <- dataI$sub_region
    yrsG <- dataG$year
    yrsI <- dataI$year

    naG1 <- which(is.na(gsasG))
    naG2 <- which(is.na(yrsG))
    naI1 <- which(is.na(gsasI))
    naI2 <- which(is.na(yrsI))

    if (verbose) {
      if (length(naG1) != 0) {
        message(paste("Found NAs in SUB_REGIONS in", length(naG1), "rows in table G"))
      }
      if (length(naG2) != 0) {
        message(paste("Found NAs in Years in", length(naG2), "rows, in table G"))
      }
      if (length(naI1) != 0) {
        message(paste("Found NAs in SUB_REGIONS in", length(naI1), "rows in table I"))
      }
      if (length(naI2) != 0) {
        message(paste("Found NAs in Years in", length(naI2), "rows, in table I"))
      }
    }

    # Landings weight coverage in tables A and H by gsa (comparison)
    covG <- aggregate(list(fishdaysG = dataG$totfishdays), by = list(year = dataG$year, country = dataG$country, gsa = dataG$sub_region), FUN = sum, na.rm = T)
    covI <- aggregate(list(fishdaysI = dataI$totfishdays), by = list(year = dataI$year, country = dataI$country, gsa = dataI$sub_region), FUN = sum, na.rm = T)

    # merge tables by year and gsa
    cov <- merge(covG, covI, all.x = T, all.Y = T)
    cov$diff1 <- label_percent(1, accuracy = 0.01)(((cov$fishdaysI - cov$fishdaysG) / cov$fishdaysG) * 100)

    colnames(cov) <- c(
      "year", "country", "gsa", "Total fish days table G", "Total fish days table I",
      "% diff"
    )

    # report results by year and gsa
    gsa <- unique(cov$gsa)
    ngsa <- length(gsa)
  } else if (!(MS %in% mslistG) | !(MS %in% mslistI)) {
    if (verbose) {
      message(paste("MS", MS, "not existing in table G or in table I"))
    }
    cov <- NULL
  }
  return(cov)
}
