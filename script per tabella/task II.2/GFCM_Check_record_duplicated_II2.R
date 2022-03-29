
#' Check duplicated records in GFCM Task II.2 table
#'
#' @param data GFCM Task II.2 table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 5 columns
#' @export 
#'
#' @examples check_RD_taskII2(task22_ex)

####
rm(list=ls(all=TRUE)) 
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_dcrf_task_ii2_catch.csv", sep=";",dec=".",head=T,na.strings="NA")

verbose=TRUE

###

check_RD_taskII2 <- function(data, verbose=TRUE){
  
  if (FALSE) {
    data=read.csv("dc_dcrf_task_ii2_catch.csv", sep=";",dec=".",head=T,na.strings="NA")
  #str(data)
    
    check_RD_taskII2(data, tab="tabII.2", verbose=TRUE)
  }
  
  df <- data[ , c(1:5)]
 
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


