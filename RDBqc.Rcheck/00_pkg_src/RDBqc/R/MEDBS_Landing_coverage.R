#' Landing_cov: function to check the coverage in Landing table
#'
#' @param Landing_tab Landing table in MED&BS format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description the function allows to check the coverage in landing table providing a summary table and a plot of landing
#' @return a list containing a summary table and coverage plot is provided
#' @export

#' @examples MEDBS_Landing_coverage(Landing_tab_example,"DPS","ITA","9")
#' @import ggplot2 dplyr
#' @importFrom utils globalVariables
MEDBS_Landing_coverage<-function(Landing_tab,SP,MS,GSA,verbose=TRUE){

    if(FALSE) {
        Landing_tab <- Landing_tab_example
        SP = "DPS"
        MS = "ITA"
        GSA =  "9"
    }

    discards<- landings<-country<-area<-year<-quarter<-vessel_length<- gear<- mesh_size_range<-fishery<-NULL

    Landing_tab=Landing_tab[Landing_tab$species==SP & Landing_tab$country==MS & Landing_tab$area==GSA,]

    if (nrow(Landing_tab)==0){
        if (verbose){
            message(paste0("No data available for the selected species (",SP,")") )
        }
    } else {

Summary_land_wt=aggregate(Landing_tab[,2:12]$landings,by=list(Landing_tab$country, Landing_tab$year, Landing_tab$quarter, Landing_tab$vessel_length, Landing_tab$gear, Landing_tab$mesh_size_range, Landing_tab$fishery,  Landing_tab$area,Landing_tab$species),FUN="sum")
colnames(Summary_land_wt)=c("country", "year", "quarter", "vessel_length", "gear", "mesh_size_range", "fishery",  "area","species",  "landings" )

    # Summary_land_wt[1:nrow(Summary_land_wt),1:ncol(Summary_land_wt)]

    output <- list()
    l <- length(output)+1
    output[[l]] <- Summary_land_wt
    names(output)[[l]] <- "summary table"

    Landing_tab$Landing_tab[Landing_tab$landings==-1] <- 0
    land_wt=Landing_tab %>% group_by(country,area,year,quarter,vessel_length, gear, mesh_size_range,fishery) %>% summarize(landings=sum(landings,na.rm=TRUE))

    data <- Landing_tab  %>%
        group_by(year, gear) %>%
        summarise(landings = sum(landings,na.rm=TRUE))

    gr <- data.frame("year"=seq(min(data$year),max(data$year),1),"gear"=rep(unique(data$gear),each=max(data$year)-min(data$year)+1),"land"=0)

    data <- full_join(gr,data)

    data[is.na(data)] <- 0

    # data <-  data[data$Landing_tab>0,]


        p <- ggplot(data, aes(x=year, y=landings, fill=gear)) +
               geom_area(size=0.5, colour="black")+theme_bw()+
               ggtitle(paste0("Landings of ",SP, " in ", MS,"_GSA",GSA))+xlab("")+ylab("tonnes")+theme(legend.position = "bottom")+
               scale_x_continuous(breaks=seq(min(data$year),max(data$year),2))

        l <- length(output)+1
        output[[l]] <- p
        names(output)[[l]] <- paste("Landing",SP,MS,GSA,sep=" _ ")

return(output)  # Summary_land_wt
}
}
