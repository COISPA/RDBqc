#' Check empty fields in FDI J table
#'
#' @description The function checks and count the numbers of records data in the given table grouped by year, GSA, MS, vessels length, and fishing techniques for the following 4 variables: total trips; total kW; total GT; total vessels;
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data FDI table J capacity
#' @param GSA GSA code
#' @param MS member state code
#' @param vessel_len vessels length code ("COMBINED" values perform the analysis for all vessels length present in data)
#' @param fishtech selected fishing techniques ("COMBINED" values perform the analysis for all fishing techniques present in data)
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list. The first element gives the summary table of records number. From the second to the fifth element gives 4 plots for each variables among:
#' * total trips;
#' * total kW;
#' * total GT;
#' * total vessels;
#' @export
#' @examples FDI_ts_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99")
#' FDI_ts_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", fishtech = c("DTS","PGP"))
#' @import tidyverse

FDI_ts_tableJ <- function(data, MS, GSA,  vessel_len="COMBINED", fishtech="COMBINED", verbose=TRUE) {

    country <- principal_sub_region <- totgt <- totkw <- tottrips <- totves <- NULL
    fishing_tech <- total_GT <- total_total_kW <- total_trips <- total_vessels <- vessel_length <- year <- NULL

    if (nrow(data)==0) {
            stop(paste0("No data available") )
        }


    # check of the vessel length, all vs specific vessel length defined by the user
    if (length(vessel_len)==1 & vessel_len[1]=="COMBINED"){
        data$vessel_length<-"COMBINED"
    }  else{
        data<-data[data$vessel_length%in%vessel_len,]
        }

    # check of the fishtech, all vs specific fishtech defined by the user

    if (length(fishtech)==1 & fishtech[1]=="COMBINED"){
        data$fishing_tech<-"COMBINED"

    }  else{
        data<-data[data$fishing_tech %in% fishtech,]
    }

    if (nrow(data)==0) {
        if (verbose){
            message(paste0("No data available for selected vessels length and fishing techniques") )
        }
    } else {

        data[data=="NK"]<-NA
        data[data=="NA"]<-NA
        suppressMessages(data<-data%>%filter(country!=0 & year!=0))

        # Summary Table of records number
        suppressMessages(data1<-data%>%
                             drop_na(year, principal_sub_region, country, vessel_length, fishing_tech)%>%
                             select(year, principal_sub_region, country, vessel_length, fishing_tech,
                                    tottrips,
                                    totkw,
                                    totgt,
                                    totves
                                     )%>%
                             filter(principal_sub_region==GSA & country==MS )%>%
                             group_by(year, principal_sub_region, country, vessel_length, fishing_tech)%>%
                             summarise( total_trips=sum(!is.na(tottrips)) ,
                                        total_total_kW=sum(!is.na(totkw)) ,
                                        total_GT=sum(!is.na(totgt)),
                                        total_vessels=sum(!is.na(totves))
                                        ))

        if (nrow(data1)==0) {
            if (verbose){
                message(paste0("No data available for the selected (",MS,") and or (",GSA,") ") )
            }
        } else {

            data2<-data
            data2[is.na(data2)] <- 0
            suppressMessages(data3<-data2%>%
                                 drop_na(year, principal_sub_region, country, vessel_length, fishing_tech)%>%
                                 select(year, principal_sub_region, country, vessel_length, fishing_tech,
                                        tottrips,
                                        totkw,
                                        totgt,
                                        totves)%>%
                                 filter(principal_sub_region==GSA & country==MS )%>%
                                 group_by(year, principal_sub_region, country, vessel_length, fishing_tech)%>%
                                 summarise(total_trips=sum(as.numeric(tottrips)),
                                           total_total_kW=sum(as.numeric(totkw)),
                                           total_GT=sum(as.numeric(totgt)),
                                           total_vessels=sum(as.numeric(totves))
                                           ))

            # Plot of 1 total_trips,

            suppressMessages(plot1<-data3%>%ggplot( aes(x=year, y=total_trips,  linetype =fishing_tech  )) +
                                 geom_point()+
                                 geom_line()+
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS, "total trips in" , GSA))+
                                 ylab("Total trips")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 2 total_total_kW,

            suppressMessages(plot2<-data3%>%ggplot( aes(x=year, y=total_total_kW,  linetype =fishing_tech  )) +
                                 geom_point()+
                                 geom_line()+
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS, "total kW in" , GSA))+
                                 ylab("Total kW")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 3 total_GT,

            suppressMessages(plot3<-data3%>%ggplot( aes(x=year, y=total_GT,  linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total GT in" , GSA))+
                                 ylab("Total GT")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 4 total_vessels,

            suppressMessages(plot4<-data3%>%ggplot( aes(x=year, y=total_vessels , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total vessels in" , GSA))+
                                 ylab("Total vessels")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            output=list(as.data.frame(data1),as.data.frame(data3),plot1,plot2,plot3,plot4)
            names(output)<-c(
                             "number_of_records",
                             "summary_table",
                             "total_trips",
                             "total_total_kW",
                             "total_GT",
                             "total_vessels"
                             )
            return(output)

        }}
}

