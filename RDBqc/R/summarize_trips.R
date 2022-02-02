
#
#' summarizing the number of trips/hauls monitored by year by port, metier, sampling method;
#'
#' @param data_example RCG CS table
#'
#' @return Number of trips by area, year, port, metier and sampling method
#' @export
#'
#' @examples summarize_trips(data_ex)
#' @import dplyr
#' @importFrom utils globalVariables

summarize_trips<- function(data_example){

    Year<-Area<-Harbour<-Fishing_activity_category_European_lvl_6<-Sampling.method<-Trip_code<-trips<-NULL

    trips <- data_example %>% group_by(Year,Area,Harbour,Fishing_activity_category_European_lvl_6,Sampling.method,Trip_code) %>% summarize(Nb_trips=n())
   trips <- trips  %>%   summarize(Nb_trips =n( ))

    return(trips)

}

