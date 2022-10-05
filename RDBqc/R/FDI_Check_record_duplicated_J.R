
#' Check duplicated records in FDI J table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records.
#' @param data GFCM Task J table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 7 columns of the FDI G table.
#' @export
#'
#' @examples check_RD_FDI_J(fdi_j_capacity)
check_RD_FDI_J <- function(data, verbose = TRUE) {
  if (FALSE) {
    # data=read.csv("dc_fdi_j_capacity.csv", sep=";",dec=".",head=T,na.strings="NA")
    # #str(data)
    #
    # check_RD_FDI_J(data, tab="tabFDI_J", verbose=TRUE)
  }

  df <- data[, c(1:7)]

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
