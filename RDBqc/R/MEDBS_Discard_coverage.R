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

    Discard_tab=Discard_tab[Discard_tab$SPECIES==SP & Discard_tab$COUNTRY==MS & Discard_tab$AREA==GSA,]

    DISCARDS<- LANDINGS<-COUNTRY<-AREA<-YEAR<-QUARTER<-VESSEL_LENGTH<- GEAR<- MESH_SIZE_RANGE<-FISHERY<-NULL


    Summary_land_wt=aggregate(Discard_tab[,2:12]$DISCARDS,by=list(Discard_tab$COUNTRY, Discard_tab$YEAR, Discard_tab$QUARTER, Discard_tab$VESSEL_LENGTH, Discard_tab$GEAR, Discard_tab$MESH_SIZE_RANGE, Discard_tab$FISHERY,  Discard_tab$AREA,Discard_tab$SPECIES),FUN="sum")
    colnames(Summary_land_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "DISCARDS" )

    Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]


    Discard_tab$Discard_tab[Discard_tab$DISCARDS==-1] <- 0
    land_wt=Discard_tab %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(DISCARDS=sum(DISCARDS,na.rm=TRUE))

    data <- Discard_tab  %>%
        group_by(YEAR, GEAR) %>%
        summarise(DISCARDS = sum(DISCARDS,na.rm=TRUE))

    gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"DISC"=0)

    data <- full_join(gr,data)

    data[is.na(data)] <- 0

    # data <-  data[data$Landing_tab>0,]


    p <- ggplot(data, aes(x=YEAR, y=DISCARDS, fill=GEAR)) +
        geom_area(size=0.5, colour="black")+theme_bw()+
        ggtitle(paste0("Discards of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+
        scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))
    print(p)


    return(Summary_land_wt)
}
