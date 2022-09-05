
#' Check empty fields in FDI I and G table
#'
#' @description The function checks the possible data inconsistency between spatial effort in table I and effort in table G.
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data1 FDI spatial effort in table I
#' @param data2 FDI effort table G
#' @return The function returns a list with two tables. In the first table all the miss matches between stpatial effort in table I and effort in table G are shown, in the second table the comparison between total spatial effort of table I and total effort in table G is shown.
#' @export
#' @examples FDI_cross_checks_IG(data1=fdi_i_spatial_effort, data2=fdi_g_effort)
#' FDI_cross_checks_IG(fdi_i_spatial_effort, fdi_g_effort)
#' @import tidyverse

FDI_cross_checks_IG <- function(data1, data2) {

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
    suppressMessages(data1<-data1%>%filter(cscode!=0 & year!=0))
    suppressMessages(data2<-data2%>%filter(country_code!=0 & year!=0))
    
    (data1[,c(2,3,16)]<-as.data.frame(lapply(data1[,c(2,3,16)], as.numeric)))
    (data1<-data1[,c(2,3:13,16)])
    (data2[,c(2,14,16,17,18)]<-as.data.frame(lapply(data2[,c(2,14,16,17,18)], as.numeric)))
    (data2<-data2[,c(2,3,4,5,6,8,7,9,10,11,14,15,17)])
    colnames(data1)<-colnames(data2)

    suppressMessages(data1 <- data1 %>%
            group_by(year, vessel_length, fishing_tech, gear_type, sub_region) %>%
            summarize(totfishdays_data1=sum(as.numeric(totfishdays))))

    suppressMessages(data2 <- data2 %>%
            group_by(year, vessel_length, fishing_tech, gear_type, sub_region) %>%
            summarize(totfishdays_data2=sum(as.numeric(totfishdays))))

    suppressMessages(data <- full_join(data1,data2))
    data$Data <- NA
head(data)
    
    for (i in 1:nrow(data)){
        if(data$totfishdays_data1[i]>0 & data$totfishdays_data2[i]>0){
            data$Data[i] <- "spatial_effort_in_table_I_and_in_table_G_are_both_available"
        }else{
            if(data$totfishdays_data1[i]==0 & data$totfishdays_data2[i]>0){
                data$Data[i] <-"spatial_effort_in_table_I_is_not_avalilable_and_effort_in_table_G_is_available"

            }else{
                if(data$totfishdays_data1[i]>0 & data$totfishdays_data2[i]==0){
                    data$Data[i] <- "spatial_effort_in_table_I_are_available_and_effort_in_table_G_are_not_available"
                }}}}

    data_miss<-data%>%
        filter(Data%in%c("spatial_effort_in_table_I_is_not_avalilable_and_effort_in_table_G_is_available","spatial_effort_in_table_I_are_available_and_effort_in_table_G_are_not_available"))
    suppressMessages(tot_land_data1 <- data1 %>%
            group_by( year, sub_region)%>%
            summarize(totfishdays_data1=sum(as.numeric(totfishdays_data1))))

    suppressMessages(tot_land_data2 <- data2 %>%
            group_by( year, sub_region)%>%
            summarize(totfishdays_data2=sum(as.numeric(totfishdays_data2))))

    suppressMessages(TOT <- full_join(tot_land_data1,tot_land_data2))
    colnames(TOT)[c(3,4)]<-c("spatial_effort_table_I","effort_table_G" )

    output=list(as.data.frame(data_miss),as.data.frame(TOT))
    names(output)<-c("summary_table_missing_values","total_effort_table_I_VS_table_G")
    return(output)
}




