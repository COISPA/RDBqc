#' Cross check between FDI tables A and H
#'
#' @description The function checks the possible data inconsistency between landings in table A and spatial landings in table H.
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data1 FDI catch table A
#' @param data2 FDI spatial landings table H
#' @return The function returns a list with two tables. In the first table all the miss matches between landings in table A and spatial landings in table H are shown, in the second table the comparison between total landings of table A and total spatial landings in table H is shown.
#' @export
#' @examples FDI_cross_checks_AH(data1=fdi_a_catch, data2=fdi_h_spatial_landings)
#' @import tidyverse


FDI_cross_checks_AH <- function(data1, data2) {

    Data <- country <- cscode <- fishing_tech <- gear_type <- sub_region <- totwghtlandg <- ttwghtl <- vessel_length <- year <- NULL

    if (nrow(data1)==0) {
        stop(paste0("No data in table A available") )
    }

    if (nrow(data2)==0) {
        stop(paste0("No data in table H available") )
    }

data1[data1=="NK"]<-0
data1[data1=="NA"]<-0
data1[is.na(data1)] <- 0
data2[data2=="NK"]<-0
data2[data2=="NA"]<-0
data2[data2=="DEEP"]<-0
data2[is.na(data2)] <- 0
suppressMessages(data1<-data1%>%filter(country !=0 & year!=0))
suppressMessages(data2<-data2%>%filter(cscode !=0 & year!=0))


data1[,c(2,3,11,16:18,20:22)]<-as.data.frame(lapply(data1[,c(2,3,11,16:18,20:22)], as.numeric))
data2[,c(2,14,16,17,18)]<-as.data.frame(lapply(data2[,c(2,14,16,17,18)], as.numeric))
colnames(data2)[c(4,5,6,7,8,11)]<-colnames(data1)[c(4,5,6,8,7,13)]

suppressMessages(data1 <- data1 %>%
        group_by(country, year, vessel_length, fishing_tech, gear_type, sub_region)%>%
        summarize(totwghtlandg=sum(as.numeric(totwghtlandg))))

suppressMessages(data2 <- data2 %>%
        group_by(year, vessel_length, fishing_tech, gear_type, sub_region) %>%
        summarize(ttwghtl  =sum(as.numeric(ttwghtl ))))

suppressMessages(data <- full_join(data1,data2))
data$Data <- NA

    for (i in 1:nrow(data)){
        if(data$totwghtlandg[i]>0 & data$ttwghtl[i]>0){
            data$Data[i] <- "landings_in_table_A_and_in_table_H_are_available"
        }else{
            if(data$totwghtlandg[i]==0 & data$ttwghtl[i]>0){
                data$Data[i] <- "landings_in_tabel_A_not_avalilable_and_landings_in_table_H_available"

            }else{
                if(data$totwghtlandg[i]>0 & data$totfishdays[i]==0){
                    data$Data[i] <- "landings_in_table_A_are_available_and_landings_in_table_H_are_not_available"
}}}}

data_miss<-data%>%
    filter(Data%in%c("landings_in_tabel_A_not_avalilable_and_landings_in_table_H_available","landings_in_table_A_are_available_and_landings_in_table_H_are_not_available"))

suppressMessages(tot_land_data1 <- data1 %>%
                      group_by( year, sub_region)%>%
                      summarize(totwghtlandg=sum(as.numeric(totwghtlandg))))

suppressMessages(tot_land_data2 <- data2 %>%
        group_by( year, sub_region)%>%
        summarize(ttwghtl=sum(as.numeric(ttwghtl))))

suppressMessages(TOT <- full_join(tot_land_data1,tot_land_data2))
colnames(TOT)[c(3,4)]<-c("land_table_A","land_table_H" )

    output=list(as.data.frame(data_miss),as.data.frame(TOT))
    names(output)<-c("summary_table_missing_values","total_land_Table_A_vs_Table_H")
    return(output)
}

