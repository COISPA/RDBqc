
#' Check duplicated records in GFCM Task VII.3.2 table
#'
#' @param data GFCM Task VII.3.2 table
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 10 columns generates duplicate records.
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 10 columns of the Task Task VII.3.2 table.
#' @export
#'
#' @examples check_RD_TaskVII32(task_vii32)
check_RD_TaskVII32 <- function(data, verbose = TRUE) {

  # if (FALSE) {
  #   data=read.csv("dc_dcrf_task_vii32_maturity_data.csv", sep=";",dec=".",head=T,na.strings="NA")
  #   # str(data_TaskVII32)
  #
  #   check_RD_taskVII31(data, tab="tabVII32", verbose=TRUE)
  # }

  df <- data[, which(colnames(data) %in% c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Source",
    "SurveyName",
    "Segment",
    "Species",
    "LengthUnit",
    "Length",
    "Sex",
    "Maturity"
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
