#' Number of individual by trip for which biological data have been collected (length, sex, maturity, weight and age)
#' @param data_example detailed data in RCG CS format
#' @return a list containing a summary of measurements by trip foreach biological variable
#' @export
#' @examples summarize_ind_meas(data_ex)
#' @import dplyr
#' @importFrom utils globalVariables
summarize_ind_meas<- function(data_example){
    Number_at_length<-Maturity_Stage<- Sex<-Age<-Individual_weight<-Species<-Year<-Area<-Harbour<-Fishing_activity_category_European_lvl_6<-Sampling.method<-Trip_code<-trips<-NULL

lengths <- data_example %>% group_by(Year,Area,Species,Trip_code) %>% summarize(length_measurements=sum(Number_at_length))
mat <- data_example %>% filter (!is.na(Maturity_Stage)) %>% group_by(Year,Area,Species,Trip_code) %>% summarize(maturity_data=sum(Number_at_length))
sex <- data_example %>% filter (!is.na(Sex) & Sex!="U" & Sex!="C") %>% group_by(Year,Area,Species,Trip_code) %>% summarize(sex_data=sum(Number_at_length))
age <- data_example %>% filter (!is.na(Age) ) %>% group_by(Year,Area,Species,Trip_code) %>% summarize(age_data=sum(Number_at_length))
weight <- data_example %>% filter (!is.na(Individual_weight) ) %>% group_by(Year,Area,Species,Trip_code) %>% summarize(weight_data=sum(Number_at_length))

return(list(lengths, mat, sex, age, weight))

}
