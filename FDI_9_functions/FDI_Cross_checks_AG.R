
#' Check empty fields in FDI A and G table
#'
#' @description The function checks the possible data inconsistency between landings and effort. The two table shall have the same size.
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data1 FDI table A catch
#' @param data2 FDI table G effort
#' @return The function returns a list where all the miss matches between landings and effort are shown.
#' @export
#' @examples FDI_cross_checks_AG(data1=fdi_a_catch, data2=fdi_g_effort)
#' FDI_cross_checks_AG(fdi_a_catch, fdi_g_effort)
#' @import tidyverse


FDI_cross_checks_AG <- function(data1, data2) {

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
    data2[is.na(data2)] <- 0
    suppressMessages(data1<-data1%>%filter(country_code!=0 & year!=0))
    suppressMessages(data2<-data2%>%filter(country_code!=0 & year!=0))

    suppressMessages(data1 <- data1 %>%
        group_by(country_code, year, quarter, vessel_length, fishing_tech, gear_type, target_assemblage, mesh_size_range, metier, sub_region)%>%
        summarize(totwghtlandg=sum(as.numeric(totwghtlandg))))

    suppressMessages(data2 <- data2 %>%
        group_by(country_code, year, quarter, vessel_length, fishing_tech, gear_type, target_assemblage, mesh_size_range, metier, sub_region) %>%
        summarize(totfishdays =sum(as.numeric(totfishdays)), totseadays=sum(as.numeric(totseadays))))

    suppressMessages(data <- full_join(data1,data2))

    data$Data <- NA

    for (i in 1:nrow(data)){
        if(data$totwghtlandg[i]>0 & data$totfishdays[i]>0 & data$totseadays[i]>0){
            data$Data[i] <- "landings and effort in fishing days and sea days available"
        }else{
            if(data$totwghtlandg[i]==0 & data$totfishdays[i]>0 & data$totseadays[i]>0){
                data$Data[i] <- "no landings, only effort in fishing days and sea days available"

            }else{
                if(data$totwghtlandg[i]==0 & data$totfishdays[i]==0 & data$totseadays[i]>0){
                    data$Data[i] <- "no landings, only effort in sea days available"

                }else{
                    if(data$totwghtlandg[i]==0 & data$totfishdays[i]>0 & data$totseadays[i]==0){
                        data$Data[i] <- "no landings, only effort in fishing days available"

                        }else
                        {data$Data[i] <- "landings and effort data no available"}
        }}}}

            output=list(as.data.frame(data))
            names(output)<-"summary_table"
            return(output)
}

