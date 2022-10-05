#' Check duplicated records in FDI A table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 19 columns generates duplicate records.
#' @param data GFCM Task A table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 19 columns of the FDI A table.
#' @export
#'
#' @examples check_RD_FDI_A(fdi_a_catch)
check_RD_FDI_A <- function(data, verbose = TRUE) {
  if (FALSE) {
    # data=read.csv("dc_fdi_g_effort.csv", sep=";",dec=".",head=T,na.strings="NA")
    # #str(data)
    # check_RD_FDI_G(data, tab="tabFDI_G", verbose=TRUE)
  }

  df <- data[, c(1:19)]

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
