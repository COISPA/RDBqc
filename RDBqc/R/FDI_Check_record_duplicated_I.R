#' Check duplicated records in FDI I table
#'
#' @param data GFCM Task I table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 15 columns
#' @export
#'
#' @examples check_RD_FDI_I(fdi_i_spatial_fe)


check_RD_FDI_I <- function(data, verbose=TRUE){

  if (FALSE) {
    # data=read.csv("dc_fdi_i_spatial_fe.csv", sep=";",dec=".",head=T,na.strings="NA")
    # #str(data)
    #
    # check_RD_FDI_I(data, tab="tabFDI_I", verbose=TRUE)
  }

  df <- data[ , c(1:19)]

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


