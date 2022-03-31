
#' Check duplicated records in GFCM Task VII.2 table
#'
#' @param data GFCM Task VII.2 table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 8 columns
#' @export
#'
#' @examples check_RD_taskVII2(task_vii2)


check_RD_taskVII2 <- function(data, verbose=TRUE){

  if (FALSE) {
    data=read.csv("dc_dcrf_task_vii2_length_data.csv", sep=";",dec=".",head=T,na.strings="NA")
    # str(data_TaskVII2)

    check_RD_taskVII2(data, tab="tabVII2", verbose=TRUE)
  }

  df <- data[ , c(1:9)]

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
