#' Check number of vessels in FDI table J and G
#'
#' @param dataJ data frame of FDA table J catch.
#' @param dataG data frame of FDA table G catch.
#' @param MS country code
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function cross-checks the number of vessels in table J in comparison with the number reported in table G.
#' @return The function returns a list of data frames. The first element reports the number of vessel in table J in comparison with table G and the relative difference percentage, while the second one reports the vessels not present in table G.
#' @export
#' @author Vasiliki Sgardeli <vsgard@@hcmr.gr>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_vessel_numbers(dataJ = fdi_j_capacity, dataG = fdi_g_effort, MS = "PSP", verbose = TRUE)
FDI_vessel_numbers <- function(dataJ, dataG, MS, verbose = TRUE) {
  country <- NULL
  error_check <- NA
  data1 <- dataJ
  data2 <- dataG
  colnames(data1) <- tolower(colnames(data1))
  colnames(data2) <- tolower(colnames(data2))

  # check if MS is existing
  mslist1 <- unique(data1$country)
  mslist2 <- unique(data2$country)
  if (MS %in% mslist1 & MS %in% mslist2) {
    if (verbose) {
      print(paste("Comparing number of vessels in tables J and G for", MS, sep = " "))
    }


    # subset for MS
    data1 <- subset(data1, country == MS)
    data2 <- subset(data2, country == MS)
    data1$id <- seq(1, nrow(data1), 1)
    data2$id <- seq(1, nrow(data2), 1)

    yrs1 <- unique(data1$year)
    yrs2 <- unique(data2$year)

    # check there are years reported
    if (is.null(yrs1)) {
      stop("No YEARS existing in table J")
    }
    if (is.null(yrs2)) {
      stop("No YEARS existing in table G")
    }

    # check for NAs in years reported
    yrs1 <- data1$year
    yrs2 <- data2$year

    na1 <- which(is.na(yrs1))
    na2 <- which(is.na(yrs2))


    if (verbose) {
      if (length(na1) != 0) {
        message(paste("Found NAs in Years in", length(na1), "rows, in table J"))
      }
      if (length(na2) != 0) {
        message(paste("Found NAs in Years in", length(na2), "rows, in table G"))
      }
    }

    if (class(data1$totves) == "character" & "NK" %in% data1$totves) {
      data1[data1$totves == "NK", "totves"] <- NA
      data1$totves <- as.numeric(data1$totves)
    }

    if (class(data2$totves) == "character" & "NK" %in% data2$totves) {
      data2[data2$totves == "NK", "totves"] <- NA
      data2$totves <- as.numeric(data2$totves)
    }

    # Vessel numbers in tables J and G (comparison), by fish_tech, gsa and year. For table G estimate max of quarters
    cov1 <- aggregate(list(vesselsJ = data1$totves), by = list(year = data1$year, gsa = data1$principal_sub_region, fish_tech = data1$fishing_tech), FUN = sum, na.rm = T)
    cov2 <- aggregate(list(vesselsG = data2$totves), by = list(year = data2$year, gsa = data2$sub_region, quarter = data2$quarter, fish_tech = data2$fishing_tech), FUN = sum, na.rm = T)
    cov2a <- aggregate(list(vesselsG = cov2$vesselsG), by = list(year = cov2$year, gsa = cov2$gsa, fish_tech = cov2$fish_tech), FUN = max, na.rm = T)

    # merge tables by common columns
    cov <- merge(cov1, cov2a, all.x = T, all.Y = T)
    cov$diff <- label_percent(1, accuracy = 0.01)(((cov$vesselsJ - cov$vesselsG) / cov$vesselsJ) * 100)

    # find nas in table G and report
    ind <- which(is.na(cov$vesselsG) & cov$vesselsJ != 0 & !is.na(cov$vesselsJ))


    if (length(ind) != 0) {
      print(paste("Found", length(ind), "cases where no. vessels > 0 in table J but not existing in table G"), sep = " ")
      cov3 <- cov[ind, ]
    } else {
      cov3 <- NULL
    }
  } else if (!(MS %in% mslist1) | !(MS %in% mslist2)) {
    if (verbose) {
      message("MS not existing in at leas one of the provided tables")
    }
    cov <- NULL
    cov3 <- NULL
  }

  return(list(comparison_table_J_G = cov, vessels_not_present_in_table_G = cov3))
}
