#' Check duplicated records in FDI J table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records.
#' @param data FDI Task J table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 7 columns of the FDI G table.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_RD_FDI_J(fdi_j_capacity)
check_RD_FDI_J <- function(data, verbose = TRUE) {
  if (FALSE){
    data <- read.table("E:\\Programmi di RACCOLTA DATI corretti al 2017\\DATACALL\\_____Tools for data-quality check__\\REV TAB FDI\\FDI Capacity by country.csv", sep=",", header=T)
    verbose = TRUE
    check_RD_FDI_J(data, verbose = TRUE)
  }
  colnames(data) <- tolower(colnames(data))
  # df <- data[, c(1:7)]
  df <- data[, which(colnames(data) %in% c("country",
                                           "year",
                                           "vessel_length",
                                           "fishing_tech",
                                           "supra_region",
                                           "geo_indicator",
                                           "principal_sub_region"))]

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
