#' Catch_cov: function to check the coverage in Catch table
#'
#' @param Landing_tab Landing table in MED&BS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return summary table and plots
#' @export

#' @examples Landing_coverage(Landing_tab_example,"DPS","ITA","9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
Landing_coverage<-function(Landing_tab,SP,MS,GSA){
    Landing_tab=Landing_tab[Landing_tab$SPECIES==SP & Landing_tab$COUNTRY==MS & Landing_tab$AREA==GSA,]
    DISCARDS<- LANDINGS<-SP<-MS<-GSA<-COUNTRY<-AREA<-YEAR<-QUARTER<-VESSEL_LENGTH<- GEAR<- MESH_SIZE_RANGE<-FISHERY<-NULL


Summary_land_wt=aggregate(Landing_tab[,2:12]$LANDINGS,by=list(Landing_tab$COUNTRY, Landing_tab$YEAR, Landing_tab$QUARTER, Landing_tab$VESSEL_LENGTH, Landing_tab$GEAR, Landing_tab$MESH_SIZE_RANGE, Landing_tab$FISHERY,  Landing_tab$AREA,Landing_tab$SPECIES),FUN="sum")
colnames(Summary_land_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "LANDINGS" )

    Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]


    Landing_tab$Landing_tab[Landing_tab$Landing_tab==-1] <- 0
    land_wt=Landing_tab %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(Landing_tab=sum(Landing_tab,na.rm=T))

    data <- Landing_tab  %>%
        group_by(YEAR, GEAR) %>%
        summarise(Landing_tab = sum(Landing_tab,na.rm=T))

    gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"LAND"=0)

    data <- full_join(gr,data)

    data[is.na(data)] <- 0

    # data <-  data[data$Landing_tab>0,]


               ggplot(data, aes(x=YEAR, y=Landing_tab, fill=GEAR)) +
               geom_area(size=0.5, colour="black")+theme_bw()+
               ggtitle(paste0("Landing_tab of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+
               scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))



return(Summary_land_wt)
}
