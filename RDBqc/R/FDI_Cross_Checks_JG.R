#' Cross check between FDI tables J and G
#' @description The function checks the possible data inconsistency between the amount of vessels in table J capacity and the amount of vessels in table G.
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data1 FDI capacity in table J
#' @param data2 FDI effort table G
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list with all the miss matches between number of vessels in table J and G are shown.
#' @export
#' @examples FDI_cross_checks_JG(data1=fdi_j_capacity, data2=fdi_g_effort,verbose=TRUE)
#' FDI_cross_checks_JG(fdi_j_capacity, fdi_g_effort)
#' @import tidyverse

FDI_cross_checks_JG <- function(data1, data2,verbose=FALSE) {

    country <- principal_sub_region <- totves <- vessel_length <- year <- info <- NULL

    if (nrow(data1)==0) {
        stop(paste0("No catch data available") )
    }

    if (nrow(data2)==0) {
        stop(paste0("No effort data available") )
    }

    data1[data1=="NK"]<-0
    data1[data1=="NA"]<-0
    data1[is.na(data1)] <- 0
    data2[data2=="NK"]<-0
    data2[data2=="NA"]<-0
    data2[data2=="DEEP"]<-0
    data2[is.na(data2)] <- 0
    suppressMessages(data1<-data1 %>% filter(country!=0 & year!=0))
    suppressMessages(data2<-data2 %>% filter(country!=0 & year!=0))

    (data1<-data1[,c(1,2,3,7,11)])
    (data1[,c(2,5)]<-as.data.frame(lapply(data1[,c(2,5)], as.numeric)))
    (data2<-data2[,c(1,2,4,11,25)])
    (data2[,c(2,5)]<-as.data.frame(lapply(data2[,c(2,5)], as.numeric)))
    colnames(data2)<-colnames(data1)

    suppressMessages(data1 <- data1 %>%
                         group_by(country, year, principal_sub_region,vessel_length ) %>%
                        summarize(total_vessels_tab_J=sum(as.numeric(totves))))

    suppressMessages(data2 <- data2 %>%
                        group_by(country, year, principal_sub_region,vessel_length ) %>%
                        summarize(total_vessels_tab_G=sum(as.numeric(totves))))

    suppressMessages(data <- full_join(data1,data2))
    data$total_vessels_tab_J<-round(data$total_vessels_tab_J, digits = 0)
    data$total_vessels_tab_G<-round(data$total_vessels_tab_G, digits = 0)
    data$info <- NA


    for (i in 1:nrow(data)){
        if(data$total_vessels_tab_J[i]==data$total_vessels_tab_G[i]){
            data$info[i] <- "Table_J_and_tabel_G_have_the_same_amount_of_vessels"
        }else{
            if(data$total_vessels_tab_J[i]>data$total_vessels_tab_G[i]){
                data$info[i] <-paste0("There_are_",data$total_vessels_tab_J[i]-data$total_vessels_tab_G[i],"_more_vessels_in_table_J_than_in_table_G")
            }else{
                if(data$total_vessels_tab_G[i]>data$total_vessels_tab_J[i]){
                    data$info[i] <-paste0("There_are_",data$total_vessels_tab_G[i]-data$total_vessels_tab_J[i],"_more_vessels_in_table_G_than_in_table_J")
               }}}}

    suppressMessages(data_miss<-data%>%
        filter(info!="Table_J_and_tabel_G_have_the_same_amount_of_vessels"))


    output=data.frame(data_miss)
    if (verbose){
      message("summary table of missing vessels")
    }
    return(output)
}




