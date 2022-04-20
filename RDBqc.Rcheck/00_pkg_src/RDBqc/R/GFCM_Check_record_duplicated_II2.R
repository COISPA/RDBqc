
#' Check duplicated records in GFCM Task II.2 table
#'
#' @param data GFCM Task II.2 table
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function check the presence of duplicated records. In particular, it checks whether the combination of the first 5 columns generates duplicate records.
#' @return The function returns the indices of the duplicated rows, checking the unique combinations of the first 5 columns of the Task II.2 table.
#' @export
#' @examples check_RD_taskII2(task_ii2)



check_RD_taskII2 <- function(data, verbose=TRUE){

  if (FALSE) {
    data=read.csv("dc_dcrf_task_ii2_catch.csv", sep=";",dec=".",head=T,na.strings="NA")
  #str(data)

    check_RD_taskII2(data, tab="tabII.2", verbose=TRUE)
  }

  df <- data[ , which(colnames(data)%in% c("Reference_Year",
                                           "CPC",
                                           "GSA",
                                           "Segment",
                                           "Species"))] # c(1:5)


  #Identify the line number of duplicate
  duplicated_line=which(duplicated(df))

if (verbose){
 if (length(duplicated_line)==0) {
       message("no duplicated lines in the data frame")
    } else {
        message(paste0(length(duplicated_line)," record/s duplicated"))
    }
}

return(duplicated_line)

}


