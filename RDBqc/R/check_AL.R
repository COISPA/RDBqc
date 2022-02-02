#' Check consistency of age-length relationship
#'
#' @param data_example table of detailed data in RCG format
#' @param min_age minimum age expected
#' @param max_age maximum age expected
#' @return summary table length-age and error (if any)
#' @export
#' @examples check_AL(data_ex,min_age=0,max_age=30)
#' @import ggplot2
#' @importFrom stats aggregate
#' @importFrom utils globalVariables
check_AL<-function(data_example,min_age=0,max_age=30){
    Age<-Length_class<-Sex<-NULL
ggplot(data=data_example, aes(x=Age,y=Length_class,col=Sex)) + geom_point() + facet_grid(Year~ Sex)

# summary table of number of individuals by length class by year
data_age=data_example[!is.na(data_example$Age),]

tab_age=aggregate(data_age$Number_at_length,by=list(data_age$Year,data_age$Length_class),FUN="length")
colnames(tab_age)=c("Year","Length_class","nb_age_measurements")

# Check age consistent with allowed range

error_min_age=data_age[data_age$Age<min_age, ]
error_max_age=data_age[data_age$Age>max_age, ]

if (nrow(error_min_age)!=0 | nrow(error_max_age)!=0){
    err<-unique(c(as.character(error_min_age$Trip_code),as.character(error_max_age$Trip_code) ) )
} else {err<-0}

return(list(tab_age,err))

}
