#' Check duplicated records in FDI G table
#'
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records.
#' @param data GFCM Task G table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 15 columns of the FDI G table.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_RD_FDI_G(fdi_g_effort)
check_RD_FDI_G <- function(data, verbose = TRUE) {
  df <- data[, c(1:15)]

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
