#' Discard_cov: function to check the coverage in Discard table
#'
#' @param Discard_tab Discard table in MED&BS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return summary table and plots
#' @export
#' @examples MEDBS_discard_coverage(Discard_tab_example,"DPS","ITA","9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
MEDBS_discard_coverage<-function(Discard_tab,SP,MS,GSA){

    if(FALSE) {
        Discard_tab=Discard_tab_example
        SP="DPS"
        MS="ITA"
        GSA=9
    }

    Discard_tab=Discard_tab[Discard_tab$species==SP & Discard_tab$country==MS & Discard_tab$area==GSA,]

    discards<- landings<-country<-area<-year<-quarter<-vessel_length <- gear<- mesh_size_range <- fishery <-NULL


    Summary_land_wt=aggregate(Discard_tab[,2:12]$discards,by=list(Discard_tab$country,
                  Discard_tab$year, Discard_tab$quarter, Discard_tab$vessel_length,
                  Discard_tab$gear, Discard_tab$mesh_size_range, Discard_tab$fishery,
                  Discard_tab$area ,Discard_tab$species ),FUN="sum")
    colnames(Summary_land_wt)=c("country", "year", "quarter", "vessel_length", "gear",
                                "mesh_size_range", "fishery",  "area","species",  "discards" )

    Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]


    Discard_tab$Discard_tab[Discard_tab$discards==-1] <- 0
    land_wt=Discard_tab %>% group_by(country,area,year,quarter,vessel_length, gear, mesh_size_range,fishery) %>% summarize(discards=sum(discards,na.rm=TRUE))

    data <- Discard_tab  %>%
        group_by(year, gear) %>%
        summarise(discards = sum(discards,na.rm=TRUE))

    gr <- data.frame("year"=seq(min(data$year),max(data$year),1),"gear"=rep(unique(data$gear),each=max(data$year)-min(data$year)+1),"disc"=0)

    data <- full_join(gr,data)

    data[is.na(data)] <- 0

    # data <-  data[data$Landing_tab>0,]


    p <- ggplot(data, aes(x=year, y=discards, fill=gear)) +
        geom_area(size=0.5, colour="black")+theme_bw()+
        ggtitle(paste0("Discards of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+
        scale_x_continuous(breaks=seq(min(data$year),max(data$year),2))
    print(p)


    return(Summary_land_wt)
}
