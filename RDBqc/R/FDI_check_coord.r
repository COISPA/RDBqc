#' Compatibility of the geographical coordinates with rectangle type
#'
#' @param data data frame of one  FDI table between H (Landings by rectangle) and table I (Effort by rectangle)
#' @param MS Country code
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function checks the compatibility of the geographical coordinates (latitude and longitude) with the value provided for the rectangle type.
#' @return The input data frame is filtered and is returned retaining the only records in which at least one among latitude and longitude is not compatible with the rectangle type. Two more columns ('lat.check' and 'lon.check') are added to the data frame structure to report the results of the checks respectively for latitude and longitude.
#' @export
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_check_coord(data = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)
FDI_check_coord <- function(data, MS, verbose = FALSE) {

  # d <- read.csv("~/GitHub/RDBqc/APPOGGIO/realdata_FDI_tableI.csv", sep=";")
  # data <- d
  # MS="ITA"

  columns <- colnames(data) <- tolower(colnames(data))
  data <- data[data$country %in% MS, ]


  if (nrow(data) > 0) {

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

    data <- data[!is.na(data$rectangle_type) & !is.na(data$rectangle_lat) & !is.na(data$rectangle_lon), ]

    if (nrow(data) > 0) {
      t <- strsplit(data$rectangle_type, "*", fixed = TRUE)
      t1 <- sapply(t, "[[", 1)
      t2 <- sapply(t, "[[", 2)
      data$t1 <- NA
      data$t2 <- NA

      id05t1 <- which(t1 == "05")
      id1t1 <- which(t1 == "1")
      id5t1 <- which(t1 == "5")
      data[id05t1, "t1"] <- "0.5"
      data[id1t1, "t1"] <- "1"
      data[id5t1, "t1"] <- "5"

      id05t2 <- which(t2 == "05")
      id1t2 <- which(t2 == "1")
      id5t2 <- which(t2 == "5")
      data[id05t2, "t2"] <- "0.5"
      data[id1t2, "t2"] <- "1"
      data[id5t2, "t2"] <- "5"

      data$t1 <- as.numeric(data$t1) / 2
      data$t2 <- as.numeric(data$t2) / 2

      data$lat.dec <- NA
      data$lon.dec <- NA
      data$lat.check <- FALSE
      data$lon.check <- FALSE

      df <- data[, c("rectangle_lat", "rectangle_lon", "t1", "t2", "lat.dec", "lon.dec")]
      df$rectangle_lat <- suppressWarnings(as.numeric(df$rectangle_lat))
      df$rectangle_lon <- suppressWarnings(as.numeric(df$rectangle_lon))
      df$t1 <- suppressWarnings(as.numeric(df$t1))
      df$t2 <- suppressWarnings(as.numeric(df$t2))

      check.lat <- function(d) {
        d[5] <- abs(d[1]) - abs(as.integer(d[1]))
        if (d[5] %in% unique(c(d[3] %% 1, (d[3] * 2 + d[3]) %% 1))) {
          return(TRUE)
        } else {
          return(FALSE)
        }
      }

      check.lon <- function(d) {
        d[6] <- abs(d[2]) - abs(as.integer(d[2]))
        if (d[6] %in% unique(c(d[4] %% 1, (d[4] * 2 + d[4]) %% 1))) {
          return(TRUE)
        } else {
          return(FALSE)
        }
      }

      temp_lat <- apply(df, 1, check.lat)
      data$lat.check <- temp_lat

      temp_lon <- apply(df, 1, check.lon)
      data$lon.check <- temp_lon

      ddd <- data[!data$lat.check | !data$lon.check, ]
      ddd <- ddd[, which(colnames(ddd) %in% c(columns, "lat.check", "lon.check"))]
    } else {
      if (verbose) {
        message(paste("no data with rectangle coordinates available in the selected table"))
      }
      ddd <- NULL
    }
  } else {
    if (verbose) {
      message(paste("no", MS, "data available for the selected table"))
    }
    ddd <- NULL
  }

  return(ddd)
}
