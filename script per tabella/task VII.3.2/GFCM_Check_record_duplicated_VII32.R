
#' Check duplicated records in GFCM Task VII.3.2 table
#'
#' @param data GFCM Task VII.3.2 table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 10 columns
#' @export 
#'
#' @examples check_RD_taskVII32(task732_ex) 


####
rm(list=ls(all=TRUE)) 
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_dcrf_task_vii32_maturity_data.csv", sep=";",dec=".",head=T,na.strings="NA")

verbose=TRUE

###

check_RD_taskVII32 <- function(data, verbose=TRUE){
  
  if (FALSE) {
    data=read.csv("dc_dcrf_task_vii32_maturity_data.csv", sep=";",dec=".",head=T,na.strings="NA")
    # str(data_TaskVII32)
    
    check_RD_taskVII31(data, tab="tabVII32", verbose=TRUE)
  }
  
  df <- data[ , c(1:11)]
 
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
