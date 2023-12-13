#' Check empty fields in FDI I table
#'
#' @description The function checks the presence of not allowed empty data in the given table.
#' @param data FDI Task I table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_EF_FDI_I(fdi_i_spatial_effort)
check_EF_FDI_I <- function(data, verbose = TRUE)
{
  if (FALSE){
    data <- read.table("E:\\Programmi di RACCOLTA DATI corretti al 2017\\DATACALL\\_____Tools for data-quality check__\\REV TAB FDI\\dc_fdi_i_spatial_fe_da_DB.csv", sep=",", header=T)
    verbose = TRUE
    check_EF_FDI_I(data, verbose = TRUE)
  }
  colnames(data) <- tolower(colnames(data))

  # data <- data[, 1:22]
  data <- data[, which(colnames(data) %in% c("country",
                                             "year",
                                             "quarter",
                                             "vessel_length",
                                             "fishing_tech",
                                             "gear_type",
                                             "target_assemblage",
                                             "mesh_size_range",
                                             "metier",
                                             "supra_region",
                                             "sub_region",
                                             "eez_indicator",
                                             "geo_indicator",
                                             "totfishdays",
                                             "confidential"))]


  data$totfishdays <- as.character(data$totfishdays)
  data$country[data$country == ""] <- NA
  data$year[data$year == ""] <- NA
  data$quarter[data$quarter == ""] <- NA
  data$vessel_length[data$vessel_length == ""] <- NA
  data$fishing_tech[data$fishing_tech == ""] <- NA
  data$gear_type[data$gear_type == ""] <- NA
  data$target_assemblage[data$target_assemblage == ""] <- NA
  data$mesh_size_range[data$mesh_size_range == ""] <- NA
  data$metier[data$metier == ""] <- NA
  data$supra_region[data$supra_region == ""] <- NA
  data$sub_region[data$sub_region == ""] <- NA
  data$eez_indicator[data$eez_indicator == ""] <- NA
  data$geo_indicator[data$geo_indicator == ""] <- NA
  data$totfishdays[data$totfishdays == ""] <- NA
  data$confidential[data$confidential == ""] <- NA
  results <- sapply(data, function(x) sum(is.na(x)))
  NA_finder_col1 <- which(is.na(data[, 1]), arr.ind = TRUE)
  NA_finder_col2 <- which(is.na(data[, 2]), arr.ind = TRUE)
  NA_finder_col3 <- which(is.na(data[, 3]), arr.ind = TRUE)
  NA_finder_col4 <- which(is.na(data[, 4]), arr.ind = TRUE)
  NA_finder_col5 <- which(is.na(data[, 5]), arr.ind = TRUE)
  NA_finder_col6 <- which(is.na(data[, 6]), arr.ind = TRUE)
  NA_finder_col7 <- which(is.na(data[, 7]), arr.ind = TRUE)
  NA_finder_col8 <- which(is.na(data[, 8]), arr.ind = TRUE)
  NA_finder_col9 <- which(is.na(data[, 9]), arr.ind = TRUE)
  NA_finder_col10 <- which(is.na(data[, 10]), arr.ind = TRUE)
  NA_finder_col11 <- which(is.na(data[, 11]), arr.ind = TRUE)
  NA_finder_col12 <- which(is.na(data[, 12]), arr.ind = TRUE)
  NA_finder_col13 <- which(is.na(data[, 13]), arr.ind = TRUE)
  NA_finder_col14 <- which(is.na(data[, 14]), arr.ind = TRUE)
  NA_finder_col15 <- which(is.na(data[, 15]), arr.ind = TRUE)

  results2 <- list(NA_finder_col1, NA_finder_col2, NA_finder_col3,
                   NA_finder_col4, NA_finder_col5, NA_finder_col6, NA_finder_col7,
                   NA_finder_col8, NA_finder_col9, NA_finder_col10, NA_finder_col11,
                   NA_finder_col12, NA_finder_col13, NA_finder_col14, NA_finder_col15)
  names(results2) <- colnames(data)
  if (verbose) {
    if (length(NA_finder_col1) == 0) {
      message(paste("no NA in the", colnames(data)[1],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col1),
                    " NA in ", colnames(data)[1]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col2) == 0) {
      message(paste("no NA in the", colnames(data)[2],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col2),
                    " NA in ", colnames(data)[2]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col3) == 0) {
      message(paste("no NA in the", colnames(data)[3],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col3),
                    " NA in ", colnames(data)[3]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col4) == 0) {
      message(paste("no NA in the", colnames(data)[4],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col4),
                    " NA in ", colnames(data)[4]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col5) == 0) {
      message(paste("no NA in the", colnames(data)[5],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col5),
                    " NA in ", colnames(data)[5]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col6) == 0) {
      message(paste("no NA in the", colnames(data)[6],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col6),
                    " NA in ", colnames(data)[6]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col7) == 0) {
      message(paste("no NA in the", colnames(data)[7],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col7),
                    " NA in ", colnames(data)[7]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col8) == 0) {
      message(paste("no NA in the", colnames(data)[8],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col8),
                    " NA in ", colnames(data)[8]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col9) == 0) {
      message(paste("no NA in the", colnames(data)[9],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col9),
                    " NA in ", colnames(data)[9]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col10) == 0) {
      message(paste("no NA in the", colnames(data)[10],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col10),
                    " NA in ", colnames(data)[10]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col11) == 0) {
      message(paste("no NA in the", colnames(data)[11],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col11),
                    " NA in ", colnames(data)[11]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col12) == 0) {
      message(paste("no NA in the", colnames(data)[12],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col12),
                    " NA in ", colnames(data)[12]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col13) == 0) {
      message(paste("no NA in the", colnames(data)[13],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col13),
                    " NA in ", colnames(data)[13]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col14) == 0) {
      message(paste("no NA in the", colnames(data)[14],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col14),
                    " NA in ", colnames(data)[14]))
    }
  }
  if (verbose) {
    if (length(NA_finder_col15) == 0) {
      message(paste("no NA in the", colnames(data)[15],
                    "column"))
    }
    else {
      message(paste("There are ", length(NA_finder_col15),
                    " NA in ", colnames(data)[15]))
    }
  }

  output <- list(results, results2)
  return(output)
}

