#' Catch_cov: function to check the coverage in Catch table
#'
#' @param catch Catch table in MEDBS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return summary table and plots
#' @export
#' @examples MEDBS_Catch_coverage(Catch_tab_example,"DPS","ITA","9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables

MEDBS_Catch_coverage<-function(catch,SP,MS,GSA){
    catch=catch[catch$SPECIES==SP & catch$COUNTRY==MS & catch$AREA==GSA,]

   DISCARDS<- LANDINGS<-COUNTRY<-AREA<-YEAR<-QUARTER<-VESSEL_LENGTH<- GEAR<- MESH_SIZE_RANGE<-FISHERY<-NULL


Summary_land_wt=aggregate(catch[,2:13]$LANDINGS,by=list(catch$COUNTRY, catch$YEAR, catch$QUARTER, catch$VESSEL_LENGTH, catch$GEAR, catch$MESH_SIZE_RANGE, catch$FISHERY,  catch$AREA,catch$SPECIES),FUN="sum")
colnames(Summary_land_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "LANDINGS" )

Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]

Summary_disc_wt=aggregate(catch[,2:13]$DISCARDS,by=list(catch$COUNTRY, catch$YEAR, catch$QUARTER, catch$VESSEL_LENGTH, catch$GEAR, catch$MESH_SIZE_RANGE, catch$FISHERY,  catch$AREA,catch$SPECIES),FUN="sum")
colnames(Summary_disc_wt)=c("COUNTRY", "YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY",  "AREA","SPECIES",  "DISCARDS" )

Summary_disc_wt= Summary_disc_wt[-which(round(Summary_disc_wt$DISCARDS,2)==-1),]

 Summary_disc_wt[1:nrow(Summary_disc_wt),1:ncol(Summary_disc_wt)]

# Plot 1
 ## LANDINGS AT AGE ####
 catch$LANDINGS[catch$LANDINGS==-1] <- 0
 catch_land_wt=catch %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(LANDINGS=sum(LANDINGS,na.rm=TRUE))

 data <- catch  %>%
     group_by(YEAR, GEAR) %>%
     summarise(LANDINGS = sum(LANDINGS,na.rm=TRUE))

 gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"LAND"=0)

 data <- full_join(gr,data)

 data[is.na(data)] <- 0

 p <- ggplot(data, aes(x=YEAR, y=LANDINGS, fill=GEAR)) +
            geom_area(size=0.5, colour="black")+
            ggtitle(paste0("Landings in catch of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))
print(p)
# Plot 2
 ## DISCARDS AT AGE ####
 catch$DISCARDS[catch$DISCARDS==-1] <- 0
 catch_disc_wt=catch %>% group_by(COUNTRY,AREA,YEAR,QUARTER,VESSEL_LENGTH, GEAR, MESH_SIZE_RANGE,FISHERY) %>% summarize(DISCARDS=sum(DISCARDS,na.rm=TRUE))

 data <- catch  %>%
     group_by(YEAR, GEAR) %>%
     summarise(DISCARDS = sum(DISCARDS))

 gr <- data.frame("YEAR"=seq(min(data$YEAR),max(data$YEAR),1),"GEAR"=rep(unique(data$GEAR),each=max(data$YEAR)-min(data$YEAR)+1),"LAND"=0)

 data <- full_join(gr,data)

 data[is.na(data)] <- 0

            ggplot(data, aes(x=YEAR, y=DISCARDS, fill=GEAR)) + geom_area(size=0.5, colour="black")+theme_bw()+
            ggtitle(paste0("Discards in catch of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+scale_x_continuous(breaks=seq(min(data$YEAR),max(data$YEAR),2))

return(list(Summary_land_wt,Summary_disc_wt))

}