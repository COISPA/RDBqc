#' Check duplicated records in FDI H table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records.
#' @param data FDI Task H table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 20 columns of the FDI G table.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_RD_FDI_H(fdi_h_spatial_landings)
check_RD_FDI_H <- function(data, verbose = TRUE) {

  if (FALSE){
    data <- read.table("E:\\Programmi di RACCOLTA DATI corretti al 2017\\DATACALL\\_____Tools for data-quality check__\\REV TAB FDI\\dc_fdi_h_spatial_land_da_DB.csv", sep=";", header=T)
    verbose = TRUE
    check_RD_FDI_H(data, verbose = TRUE)
  }

  ### adaptation for new FDI table structure ------
  colnames(data) <- tolower(colnames(data))
  if ("latitude" %in% colnames(data)) {
    colnames(data)[which(colnames(data)=="latitude")] <- "rectangle_lat"
  }
  if ("longitude" %in% colnames(data)) {
    colnames(data)[which(colnames(data)=="longitude")] <- "rectangle_lon"
  }
  #------------------------------------------------

  # df <- data[, c(1:21)]
  df <- data[, which(colnames(data) %in% c("country",
                                           "year",
                                           "quarter",
                                           "vessel_length",
                                           "fishing_tech",
                                           "gear_type",
                                           "target_assemblage",
                                           "mesh_size_range",
                                           "metier",
                                           "metier_7",
                                           "supra_region",
                                           "sub_region",
                                           "eez_indicator",
                                           "geo_indicator",
                                           "specon_tech",
                                           "deep",
                                           "rectangle_type",
                                           "latitude",
                                           "longitude",
                                           "c_square",
                                           "species"))]


  duplicated_line <- which(duplicated(df))
  if (verbose) {
    if (length(duplicated_line) == 0) {
      message("no duplicated lines in the data frame")
    }
    else {
      message(paste0(length(duplicated_line), " record/s duplicated"))
    }
  }
  return(duplicated_line)
}
