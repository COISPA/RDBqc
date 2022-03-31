
#' Check duplicated records in GFCM Task VII.3.1 table
#'
#' @param data GFCM Task VII.3.1 table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 5 columns
#' @export
#'
#' @examples check_RD_taskVII31(task_vii31)


check_RD_taskVII31 <- function(data, verbose=TRUE){

  # if (FALSE) {
  #   data=read.csv("dc_dcrf_task_vii31_size_1st_matur.csv", sep=";",dec=".",head=T,na.strings="NA")
  #   # str(data)
  #
  #   check_RD_taskVII31(data, tab="tabVII31", verbose=TRUE)
  # }

  df <- data[ , which(colnames(data)%in% c("Reference_Year", "CPC", "GSA", "Species", "Sex" ))] # c(1:5)

  #Identify the line number of duplicate
  duplicated_line=which(duplicated(df))

if (verbose){
 if (length(duplicated_line)==0) {
       message("no duplicated lines in the data frame")
    } else {
       message(paste0("There are ",length(duplicated_line)," lines duplicated"))
    }
}

return(duplicated_line)

}
