#' @description The function checks the incorrect combination of NA in table H capacity and in table I. It also show miss-specification of sub-region assigned, according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data1 FDI spatial_landings in table H
#' @param data2 FDI spatial_effort table I
#' @return The function returns a table with all the miss value and NAs between table H and I.
#' @export
#' @examples FDI_cross_checks_HI(data1=fdi_h_spatial_landings, data2=fdi_i_spatial_effort)
#' FDI_cross_checks_HI(fdi_h_spatial_landings, fdi_i_spatial_effort)
#' @import tidyverse

FDI_cross_checks_JG <- function(data1, data2) {

    if (nrow(data1)==0) {
        stop(paste0("No table J data available") )
    }

    if (nrow(data2)==0) {
        stop(paste0("No table G data available") )
    }

    data1[data1=="NK"]<-"NA"
    data1[is.na(data1)]<-"NA"
    data2[data2=="NK"]<-"NA"
    data2[is.na(data2)] <- "NA"

    (data1<-data1[,c(1,11,15)])
    colnames(data1)[2]<-"sub_rgn_tab_h"
    colnames(data1)[3]<-"rctngl_tab_h"
    (data2<-data2[,c(1,11,14)])
    colnames(data2)[2]<-"sub_rgn_tab_g"
    colnames(data2)[3]<-"rctngl_tab_g"

    (data<-merge(data1,data2, by="cscode"))
    data$info <- NA


    for (i in 1:nrow(data)){
        if(data$sub_rgn_tab_h[i]!=data$sub_rgn_tab_g[i]){
            data$info[i]<-"inconsistency"
        }else{
            if(data$rctngl_tab_h[i]!=data$rctngl_tab_g[i]){
                data$info[i] <-"inconsistency"
            }
            else {
                data$info[i] <-"ok"
            } }}

    suppressMessages(data_miss<-data%>%
                         filter(info=="inconsistency"))

    output=as.data.frame(data_miss)
    names(output)<-"summary_table_of_missing_vessels"
    return(output)
}


