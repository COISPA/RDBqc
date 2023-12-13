#' Check duplicated records in FDI A table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 19 columns generates duplicate records.
#' @param data FDI Task A table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 19 columns of the FDI A table.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_RD_FDI_A(fdi_a_catch)
check_RD_FDI_A <- function(data, verbose = TRUE) {

  if (FALSE){
    data <- read.table("E:\\Programmi di RACCOLTA DATI corretti al 2017\\DATACALL\\_____Tools for data-quality check__\\REV TAB FDI\\FDI Catches by country2022.csv", sep=";", header=T)
    verbose = TRUE
    check_RD_FDI_A(data, verbose = TRUE)
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
                                           "domain_discards",
                                           "domain_landings",
                                           "supra_region",
                                           "sub_region",
                                           "eez_indicator",
                                           "geo_indicator",
                                           "nep_sub_region",
                                           "specon_tech",
                                           "deep",
                                           "species"))]

  # Identify the line number of duplicate
  duplicated_line <- which(duplicated(df))

  if (verbose) {
    if (length(duplicated_line) == 0) {
      message("no duplicated lines in the data frame")
    } else {
      message(paste0(length(duplicated_line), " record/s duplicated"))
    }
  }

  return(duplicated_line)
}

