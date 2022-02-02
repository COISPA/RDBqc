
#' Catch_cov: function to check the coverage in Catch table
#'
#' @param Catch_tab Catch table in MED&BS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return summary table and plots
#' @export
#' @examples Catch_coverage(Catch_tab_example,"DPS","ITA","9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
Catch_coverage<-function(Catch_tab,SP,MS,GSA){
    Catch_tab=Catch_tab[Catch_tab$SPECIES==SP & Catch_tab$COUNTRY==MS & Catch_tab$AREA==GSA,]

   DISCARDS<- LANDINGS<-COUNTRY<-AREA<-YEAR<-QUARTER<-VESSEL_LENGTH<- GEAR<- MESH_SIZE_RANGE<-FISHERY<-NULL


Summary_land_wt=aggregate(Catch_tab[,2:13]$LANDINGS,by=list(Catch_tab$COUNTRY, Catch_tab$YEAR, Catch_tab$QUARTER, Catch_tab$VESSEL_LENGTH, Catch_tab$GEAR, Catch_tab$MESH_SIZE_RANGE, Catch_tab$FISHERY,  Catch_tab$AREA,Catch_tab$SPECIES),FUN="sum")
colnames(Summary_land_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "LANDINGS" )

Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]

Summary_disc_wt=aggregate(Catch_tab[,2:13]$DISCARDS,by=list(Catch_tab$COUNTRY, Catch_tab$YEAR, Catch_tab$QUARTER, Catch_tab$VESSEL_LENGTH, Catch_tab$GEAR, Catch_tab$MESH_SIZE_RANGE, Catch_tab$FISHERY,  Catch_tab$AREA,Catch_tab$SPECIES),FUN="sum")
colnames(Summary_disc_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "DISCARDS" )

Summary_disc_wt= Summary_disc_wt[-which(round(Summary_disc_wt$DISCARDS,2)==-1),]

 Summary_disc_wt[1:nrow(Summary_disc_wt),1:ncol(Summary_disc_wt)]

# Plot 1
 ## LANDINGS AT AGE ####
 Catch_tab$LANDINGS[Catch_tab$LANDINGS==-1] <- 0
 catch_land_wt=Catch_tab %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(LANDINGS=sum(LANDINGS,na.rm=T))

 data <- Catch_tab  %>%
     group_by(YEAR, GEAR) %>%
     summarise(LANDINGS = sum(LANDINGS,na.rm=T))

 gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"LAND"=0)

 data <- full_join(gr,data)

 data[is.na(data)] <- 0

 ggplot(data, aes(x=YEAR, y=LANDINGS, fill=GEAR)) +
            geom_area(size=0.5, colour="black")+
            ggtitle(paste0("Landings in catch of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))

# Plot 2
 ## DISCARDS AT AGE ####
 Catch_tab$DISCARDS[Catch_tab$DISCARDS==-1] <- 0
 Catch_tab_disc_wt=Catch_tab %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(DISCARDS=sum(DISCARDS,na.rm=T))

 data <- Catch_tab  %>%
     group_by(YEAR, GEAR) %>%
     summarise(DISCARDS = sum(DISCARDS))

 gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"LAND"=0)

 data <- full_join(gr,data)

 data[is.na(data)] <- 0

            ggplot(data, aes(x=YEAR, y=DISCARDS, fill=GEAR)) + geom_area(size=0.5, colour="black")+theme_bw()+
            ggtitle(paste0("Discards in Catch_tab of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))

return(list(Summary_land_wt,Summary_disc_wt))

}
