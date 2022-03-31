
#' Check duplicated records in FDI J table
#'
#' @param data GFCM Task J table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return indices of the duplicated rows in the first 7 columns
#' @export
#'
#' @examples check_RD_FDI_J(fdi_j_capacity)

check_RD_FDI_J <- function(data, verbose=TRUE){

  if (FALSE) {
    # data=read.csv("dc_fdi_j_capacity.csv", sep=";",dec=".",head=T,na.strings="NA")
    # #str(data)
    #
    # check_RD_FDI_J(data, tab="tabFDI_J", verbose=TRUE)
  }

  df <- data[ , c(1:7)]

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


