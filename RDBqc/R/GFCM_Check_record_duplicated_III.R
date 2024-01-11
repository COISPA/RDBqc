
#' Check duplicated records in GFCM Task III table
#'
#' @param data GFCM Task III table
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 10 columns generates duplicate records.
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 10 columns of the Task Task III table.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_RD_taskIII(task_iii)
check_RD_taskIII <- function(data, verbose = TRUE) {

  # check format of headers
  data <- GFCM_check_headers(data, "task3")

  df <- data[, which(colnames(data) %in% c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Segment",
    "Group",
    "Family",
    "Species",
    "Date",
    "Gear",
    "Source"
  ))]

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
