#' Check of species value
#'
#' @param data data frame of FDA table A catch.
#' @param MS country code
#' @param GSA GSA code
#' @param SP vector of the species code for which the check should be performed
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function estimates from the FDI table A an average price per species and year and compares it with average price calculated per country (by species). Furthermore, the function performs comparisons between total weight landings and total value landings. In particular it identifies the cases with total landings > 0 but landings value = 0. In case SP parameter is not specified, the analysis is conducted over all the species in the provided data frame.
#' @return the function returns a list of two data frames. The first one reports the prices comparison by species, while the second one reports the cases in which total landings > 0 but landings value = 0.
#' @export
#' @author Vasiliki Sgardeli <vsgard@@hcmr.gr>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_prices_not_null(
#'   data = fdi_a_catch, MS = "PSP", GSA = "GSA99",
#'   SP = c("ARA", "BOG", "HKE"), verbose = TRUE
#' )
FDI_prices_not_null <- function(data, MS, GSA, SP = NA, verbose = FALSE) {
  sub_region <- country <- price <- year <- NULL

  colnames(data) <- tolower(colnames(data))

  # check if MS is existing
  mslist <- unique(data$country)
  if (MS %in% mslist) {
    if (verbose) {
      print(paste("Average price per species in", MS, sep = " "))
    }

    # subset for MS
    data1 <- subset(data, country == MS)
    data1 <- subset(data1, sub_region %in% GSA)

    if (length(SP) == 1) {
      if (is.na(SP)) {
        SP <- unique(data1$species)
      }
    }

    if (any(SP %in% unique(data1$species))) {
      data1 <- subset(data1, species %in% SP)
      data1$id <- seq(1, nrow(data1), 1)

      species <- unique(data1$species)
      yrs <- unique(data1$year)
      nsp <- length(species)

      # check there are years reported
      if (is.null(yrs)) {
        stop("No YEARS existing")
      }

      # check for NAs in years reported
      yrs <- data1$year
      na2 <- which(is.na(yrs))

      if (verbose) {
        if (length(na2) != 0) {
          message(paste("Found NAs in Years in", length(na2), "rows"))
        }
      }

      # converting totvallandg in numeric field
      data1[data1$totvallandg == "NK" & !is.na(data1$totvallandg), "totvallandg"] <- NA
      data1$totvallandg <- as.numeric(data1$totvallandg)


      # compute average price per species and year
      WT <- aggregate(list(wt = data1$totwghtlandg), by = list(year = data1$year, species = data1$species), FUN = sum, na.rm = T)
      LV <- aggregate(list(lv = data1$totvallandg), by = list(year = data1$year, species = data1$species), FUN = sum, na.rm = T)

      l <- merge(WT, LV, all.x = T, all.Y = T)
      l$price <- l$lv / (l$wt * 1000)

      l[is.infinite(l$price), "price"] <- NA

      # cases for which totalweightlandings >0 while landingsvalue=0
      ind <- which(l$wt > 0 & l$lv == 0)
      if (length(ind) > 0) {
        l1 <- l[ind, ]
        l1$price <- NA
        sp1 <- unique(l1$species)
        l[ind, ]$price <- NA # set NA to prices in this cases (otherwise price is estimated to zero)
        l1[is.na(l1$price), "price"] <- NA
        colnames(l1) <- c("year", "species", "land weight", "land value", "price")
      } else {
        l1 <- l[ind, ]
        colnames(l1) <- c("year", "species", "land weight", "land value", "price")
      }

      # compute average price per species across all years to append to tables l and l1
      av_price <- aggregate(list(av_price = l$price), by = list(species = l$species), FUN = mean, na.rm = T)
      l2 <- merge(l, av_price, all.x = T, all.Y = T)
      l2$av_price[which(is.nan(l2$av_price))] <- NA # change NaN to NA
      colnames(l2) <- c("species", "year", "land weight", "land value", "price", "av_price")

      if (length(ind) != 0) {
        if (verbose) {
          message(paste("Found", length(ind),
            "cases with total landings > 0 but landings value = 0, for", length(sp1), "species, see output tables",
            sep = " "
          ))
        }
      } else {
        if (verbose) {
          message("No cases with total landings > 0 but landings value = 0")
        }
      }
    } else {
      if (verbose) {
        message(paste("Species ", paste(SP, collapse = ", "), " not existing in provided data"))
      }
      l1 <- NULL
      l2 <- NULL
    }
  } else {
    if (verbose) {
      message(paste("MS ", MS, "not existing in provided data"))
    }
    l1 <- NULL
    l2 <- NULL
  }
  return(list(price_per_species = l2, cases_with_zero_land_value = l1))
}
