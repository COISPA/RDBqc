
#
#' summarizing the number of trips/hauls monitored by year by port, metier, sampling method;
#'
#' @param data RCG CS table
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @return Number of trips by area, year, port, metier and sampling method
#' @export
#' @examples RCG_summarize_trips(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
#' @import dplyr
#' @importFrom utils globalVariables

RCG_summarize_trips<- function(data,MS,GSA,SP,verbose=TRUE){

    if (FALSE) {
        data <- data_ex
        MS <- "ITA"
        GSA <- "GSA99"
        SP <- "Mullus barbatus"
    }

    Year<-Area<-Harbour<-Fishing_activity_category_European_lvl_6<-Sampling.method<-Trip_code<-trips<-NULL

    data <- data[data$Flag_country == MS & data$Area == GSA & data$Species == SP, ]
 if (nrow(data)==0) {
     if (verbose){
         message(paste0("No data available for the selected species (",SP,")") )
     }
 } else {

suppressMessages(    trips <- data %>% group_by(Year,Area,Harbour,Fishing_activity_category_European_lvl_6,Sampling.method,Trip_code) %>% summarize(Nb_trips=n()))
   trips <- trips  %>%   summarize(Nb_trips =n( ))

    return(as.data.frame(trips))
}
}

