#' @description The function checks the incorrect combination of NA in table H capacity. It also show miss-specification of sub-region assigned, according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data FDI spatial_landings in table H
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a table with all the miss value and NAs in table H.
#' @export
#' @examples FDI_cross_checks_H(data=fdi_h_spatial_landings, verbose=TRUE)
#' FDI_cross_checks_H(fdi_h_spatial_landings)
#' @import tidyverse

FDI_cross_checks_H <- function(data, verbose=FALSE) {

    if (nrow(data)>0) {
    data[data=="NK"]<-"NA"
    data[is.na(data)]<-"NA"

    data<-data[,c(19,11,16)]

    data$info <- NA


    for (i in 1:nrow(data)){
        if(data$sub_region[i]=="NA" & data$c_square[i]!="NA"){
            data$info[i]<-"inconsistency"
        }else{
            if(data$sub_region[i]!="NA" & data$c_square[i]=="NA"){
                data$info[i] <-"inconsistency"
            }
            else {
                data$info[i] <-"ok"
            } }}

    suppressMessages(data_miss<-data%>%
                         filter(info=="inconsistency"))

    output=as.data.frame(data_miss)
    if (verbose){message("summary_table_of_missing_vessels")}

    } else  {
        if (verbose) {
             message(paste0("No table H data available") )
        }
        output=NULL
        }
    return(output)
}

