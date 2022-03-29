#' Check duplicated records in FDI G table
#'
#' @param data GFCM Task G table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 15 columns
#' @export 
#'
#' @examples check_RD_FDI_G(FDI_G_ex)

####
rm(list=ls(all=TRUE)) 
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_fdi_g_effort.csv", sep=";",dec=".",head=T,na.strings="NA")

verbose=TRUE

###str(data)

check_RD_FDI_G <- function(data, verbose=TRUE){
  
  if (FALSE) {
    data=read.csv("dc_fdi_g_effort.csv", sep=";",dec=".",head=T,na.strings="NA")
    #str(data)
    
    check_RD_FDI_G(data, tab="tabFDI_G", verbose=TRUE)
  }
  
  df <- data[ , c(1:15)]
 
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


