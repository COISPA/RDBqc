#' Coverage of FDI discard data
#'
#' @param data data frame of the FDI table A
#' @param MS Country
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format.
#' @param verbose boolean. If TRUE a message is printed.
#' @description The functions checks the discard coverage in table A for the selected MS by GSAs.
#' @return The function returns a list of data frames by GSA reporting the landing volumes (with discard >0, =0 and =NK and total landing) by year
#' @export
#' @author Vasiliki Sgardeli <vsgard@@hcmr.gr>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_disc_coverage(fdi_a_catch, MS = "PSP", GSA = "GSA99", SP = "HKE", verbose = TRUE)
#' @importFrom scales label_percent

FDI_disc_coverage <- function(data, MS, GSA, SP, verbose = TRUE) {
  country <- NULL

  colnames(data) <- tolower(colnames(data))
  # check if MS is existing
  mslist <- unique(data$country)
  if (MS %in% mslist) {
    data1 <- data[which(data$sub_region %in% as.character(GSA) & data$country == MS & data$species %in% SP), ]

    if (nrow(data1) > 0) {

      ### adaptation for new FDI table structure ------
      colnames(data1) <- tolower(colnames(data1))
      if ("latitude" %in% colnames(data1)) {
        colnames(data1)[which(colnames(data1)=="latitude")] <- "rectangle_lat"
      }
      if ("longitude" %in% colnames(data1)) {
        colnames(data1)[which(colnames(data1)=="longitude")] <- "rectangle_lon"
      }
      if ("metier_7" %in% colnames(data1)) {
        data1 <- data1[ , -(which(colnames(data1)%in% "metier_7"))]
      }
      #-----------------------------------------------

      ngsas <- unique(data1$sub_region)
      nyrs <- unique(data1$year)

      # check there are gsas and years reported
      if (is.null(ngsas)) {
        stop("No SUB_REGIONS existing")
      }
      if (is.null(nyrs)) {
        stop("No YEARS existing")
      }

      # check for NAs in gsas or years reported

      gsas <- data1$sub_region
      yrs <- data1$year

      na1 <- which(is.na(gsas))
      na2 <- which(is.na(yrs))

      if (verbose) {
        if (length(na1) != 0) {
          message(paste("Found NAs in SUB_REGIONS in", length(na1), "rows"))
        }
        if (length(na2) != 0) {
          message(paste("Found NAs in Years in", length(na2), "rows"))
        }
      }

      d3 <- which(data1$discards == "NK")

      if(any(is.na(data1$discards ))){
        if (verbose){
          print("Column DISCARDS cannot contain NA values. Substitute NAs with NK and run again the script",quote=F)
        }
      }
      suppressWarnings(d1 <- which(as.numeric(data1$discards) > 0))
      suppressWarnings(d2 <- which(as.numeric(data1$discards) == 0))

      data1$DISCcat <- rep(NA, nrow(data1))
      data1$DISCcat[d1] <- "1"
      data1$DISCcat[d2] <- "0"
      data1$DISCcat[d3] <- "NK"

      data1$totwghtlandg <- as.numeric(data1$totwghtlandg)
      data1$totvallandg <- as.numeric(data1$totvallandg)
      data1$discards <- as.numeric(data1$discards)

      if (class(data1$totwghtlandg) != "numeric") {
        message("Unexpected class values in 'totwghtlandg' field in table A catch. COnverted to numeric")
          data1$totwghtlandg <- as.numeric(data1$totwghtlandg)
      }

      discov <- aggregate(list(landings = data1$totwghtlandg), by = list(year = data1$year, gsa = data1$sub_region, disccat = data1$DISCcat), FUN = sum, na.rm = T)
      TL <- aggregate(list(landings = data1$totwghtlandg), by = list(year = data1$year, gsa = data1$sub_region), FUN = sum, na.rm = T)

      colnames(TL)[which(colnames(TL) == "landings")] <- "Total_lands"
      dd1 <- suppressMessages(full_join(TL, discov[discov$disccat == 1, ]))
      dd1 <- dd1[, -(which(colnames(dd1) == "disccat"))]
      dd1$disc1per <- scales::label_percent(1, accuracy = 0.01)((dd1$landings / dd1$Total_lands) * 100)

      colnames(discov)[which(colnames(discov) == "landings")] <- "disc0"
      dd2 <- suppressMessages(full_join(dd1, discov[discov$disccat == 0, -3]))
      dd2$disc0per <- scales::label_percent(1, accuracy = 0.01)((dd2$disc0 / dd2$Total_lands) * 100)

      colnames(discov)[which(colnames(discov) == "disc0")] <- "discNK"
      dd3 <- suppressMessages(full_join(dd2, discov[discov$disccat == "NK", -3]))
      dd3$discNKper <- scales::label_percent(1, accuracy = 0.01)((dd3$discNK / dd3$Total_lands) * 100)

      colnames(dd3) <- c(
        "year", "gsa", "Total_lands", "Lands_(disc > 0)",
        "% Lands_(disc >0)", "Lands_(disc = 0)",
        "% Lands_(disc = 0)", "Lands_(disc = NK)",
        "% Lands_(disc = NK)"
      )
      gsals <- dd3
      gsals[is.na(gsals)] <- 0
    } else {
      if (verbose) {
        message(paste("No data availble"))
      }
      gsals <- NULL
    }
  } else {
    message(paste("MS ", MS, " not existing in provided data"))
    gsals <- NULL
  }
  return(gsals)
}
