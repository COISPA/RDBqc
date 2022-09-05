
#' Check empty fields in FDI G table
#'
#' @description The function checks and count the numbers of records data in the given table grouped by year, GSA, MS, vessels length, fishing techniques, and metier for the following 8 variables: Total days at sea; Total Fishing Days; Total kW days at Sea; total GT days at sea; Total kW fishing days; totgtfishdays; Hours at Sea; kW hours at sea;
#' according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1} If Vessel length, fishing technique, and metier are not specified by the user the function combines those by default.
#' @param data FDI table G effort
#' @param verbose boolean. If TRUE a message is printed.
#' @param MS member state code
#' @param GSA GSA code
#' @param vessel_len vessels length code ("COMBINED" values perform the analysis for all vessels length present in data)
#' @param fishtech selected fishing techniques ("COMBINED" values perform the analysis for all fishing techniques present in data)
#' @param met selected metiers ("COMBINED" values perform the analysis for all metiers present in data)
#' @return The function returns a list. The first element gives the summary table of records number. From the second to the nineth element gives 8 plots for each variables among:
#' * totseadays,
#' * totfishdays,
#' * totkwdaysatsea,
#' * totgtdaysatsea,
#' * totkwfishdays,
#' * totgtfishdays,
#' * hrsea,
#' * kwhrsea
#' @export
#' @examples FDI_ts_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")
#' FDI_ts_tableG(fdi_g_effort, MS="PSP", GSA="GSA99", metier="OTB_MDD_>=40_0_0", fishtech="DTS")
#' @import tidyverse

FDI_ts_tableG <- function(data, MS, GSA, vessel_len="COMBINED", fishtech="COMBINED", met="COMBINED", verbose=TRUE) {

    if (nrow(data)==0) {
            stop(paste0("No data available") )
        }

    # check of the vessel_length, all vs specific vessel length defined by the user
    if (length(vessel_len )==1 & vessel_len [1]=="COMBINED" ){
        data$vessel_length<-"COMBINED"
    }  else{
        data<-data[data$vessel_length%in%vessel_len,]
    }

    # check of the metier, all vs specific metier defined by the user
    if (length(met)==1 & met[1]=="COMBINED" ){
        data$metier<-"COMBINED"
    }  else{
        data<-data[data$metier%in%met,]
        }

    # check of the fishtech, all vs specific fishtech defined by the user

    if (length(fishtech)==1 & fishtech[1]=="COMBINED" ){
        data$fishing_tech<-"COMBINED"
    }  else{
        data<-data[data$fishing_tech%in%fishtech,]
    }


    if (nrow(data)==0) {
        if (verbose){
            message(paste0("No data available for selected vessel length, metiers, and fishing techniques") )
        }
    } else {

        data[data=="NK"]<-NA
        data[data=="NA"]<-NA
        suppressMessages(data<-data%>%filter(country_code !=0 & year!=0))

        # Summary Table of records number
        suppressMessages(data1<-data%>%
                             drop_na(year, sub_region, country_code, vessel_length, fishing_tech, metier)%>%
                             select(year, sub_region, country_code, vessel_length, fishing_tech, metier,
                                    totseadays,
                                    totfishdays,
                                    totkwdaysatsea,
                                    totgtdaysatsea,
                                    totkwfishdays,
                                    totgtfishdays,
                                    hrsea,
                                    kwhrsea )%>%
                             filter(sub_region==GSA & country_code==MS )%>%
                             group_by(year, sub_region, country_code, vessel_length, fishing_tech, metier)%>%
                             summarise( totseadays=sum(!is.na(totseadays)) ,
                                        totfishdays=sum(!is.na(totfishdays)) ,
                                        totkwdaysatsea=sum(!is.na(totkwdaysatsea)),
                                        totgtdaysatsea=sum(!is.na(totgtdaysatsea)),
                                        totkwfishdays=sum(!is.na(totkwfishdays)),
                                        totgtfishdays=sum(!is.na(totgtfishdays)),
                                        hrsea=sum(!is.na(hrsea)),
                                        kwhrsea=sum(!is.na(kwhrsea))
                                        ))

        if (nrow(data1)==0) {
            if (verbose){
                message(paste0("No data available for the selected (",MS,") and or (",GSA,") ") )
            }
        } else {

            data2<-data
            data2[is.na(data2)] <- 0
            suppressMessages(data3<-data2%>%
                                 drop_na(year, sub_region, country_code, vessel_length, fishing_tech, metier)%>%
                                 select(year, sub_region, country_code, vessel_length, fishing_tech, metier,
                                        totseadays,
                                        totfishdays,
                                        totkwdaysatsea,
                                        totgtdaysatsea,
                                        totkwfishdays,
                                        totgtfishdays,
                                        hrsea,
                                        kwhrsea)%>%
                                 filter(sub_region==GSA & country_code==MS )%>%
                                 group_by(year, sub_region, country_code, vessel_length, fishing_tech, metier)%>%
                                 summarise(totseadays=sum(as.numeric(totseadays)),
                                           totfishdays=sum(as.numeric(totfishdays)),
                                           totkwdaysatsea=sum(as.numeric(totkwdaysatsea)),
                                           totgtdaysatsea=sum(as.numeric(totgtdaysatsea)),
                                           totkwfishdays=sum(as.numeric(totkwfishdays)),
                                           totgtfishdays=sum(as.numeric(totgtfishdays)),
                                           hrsea=sum(as.numeric(hrsea)),
                                           kwhrsea=sum(as.numeric(kwhrsea))
                                           ))

            # Plot of 1 totseadays,

            suppressMessages(plot1<-data3%>%ggplot( aes(x=year, y=totseadays, col=metier , linetype =fishing_tech  )) +
                                 geom_point()+
                                 geom_line()+
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS, "total sea days in" , GSA))+
                                 ylab("Total sea days")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 2 totfishdays,

            suppressMessages(plot2<-data3%>%ggplot( aes(x=year, y=totfishdays, col=metier , linetype =fishing_tech  )) +
                                 geom_point()+
                                 geom_line()+
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS, "total fishing days in" , GSA))+
                                 ylab("Total fishing days")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 3 totkwdaysatsea,

            suppressMessages(plot3<-data3%>%ggplot( aes(x=year, y=totkwdaysatsea, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total KW days at sea in" , GSA))+
                                 ylab("Total KW days at sea")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 4 totgtdaysatsea,

            suppressMessages(plot4<-data3%>%ggplot( aes(x=year, y=totgtdaysatsea, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total GT days at sea in" , GSA))+
                                 ylab("Total GT days at sea")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))


            # Plot of 5 totkwfishdays,

            suppressMessages(plot5<-data3%>%ggplot( aes(x=year, y=totkwfishdays, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total KW fishing days in", GSA))+
                                 ylab("Total KW fishing days")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))

            # Plot of 6 totgtfishdays,
            suppressMessages(plot6<-data3%>%ggplot( aes(x=year, y=totgtfishdays, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "total GT fishing days in" , GSA))+
                                 ylab("Total GT fishing days")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))
            # Plot of 7 hrsea,
            suppressMessages(plot7<-data3%>%ggplot( aes(x=year, y=hrsea, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "hr at sea in" , GSA))+
                                 ylab("Total hr at sea")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))


            # Plot of 8 kwhrsea
            suppressMessages(plot8<-data3%>%ggplot( aes(x=year, y=kwhrsea, col=metier , linetype =fishing_tech  )) +
                                 scale_x_continuous(breaks=seq(min(data3$year),max(data3$year),4)) +
                                 geom_point()+
                                 geom_line()+
                                 theme(axis.text.x = element_text(size  = 15,angle = 0,colour="black"),
                                       axis.text.y = element_text(size  = 15,colour="black"),
                                       axis.title=element_text(size=15),
                                       plot.title = element_text(hjust = 0.5, size = 15))+
                                 ggtitle(paste(MS,  "KW hr at sea in" , GSA))+
                                 ylab("Total KW hr at sea")+
                                 xlab("year")+
                                 facet_wrap(~ vessel_length ))


            output=list(as.data.frame(data3),plot1,plot2,plot3,plot4,plot5,plot6,plot7,plot8)
            names(output)<-c("summary_table",
                             "tot_sea_days",
                             "tot_fishing_days",
                             "tot_KW_days_at_sea",
                             "tot_GT_days_at_sea",
                             "tot_KW_fishing_days",
                             "tot_GT_fishing_days",
                             "hr_at_sea",
                             "KW_hr_at_sea")
            return(output)

        }}
}

