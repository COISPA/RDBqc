#' Check consistency of age-length relationship
#'
#' @param data_example table of detailed data in RCG format
#' @param min_age minimum age expected
#' @param max_age maximum age expected
#' @return
#' @export
#'
#' @examples check_AL(data_example,min_age=0,max_age=30)
check_AL<-function(data_example,min_age=0,max_age=30){
ggplot(data=data_example, aes(x=Age,y= Length.class,col=Sex)) + geom_point(stat="identity", binwidth = 0.5) + facet_grid(Year~ Sex)

# summary table of number of individuals by length class by year
data_age=data_example[!is.na(data_example$Age),]

tab_age=aggregate(data_age$Number.at.length,by=list(data_age$Year,data_age$Length.class),FUN="length")
colnames(tab_age)=c("Year","Length_class","nb_age_measurements")
tab_age

# Check age consistent with allowed range


error_min_age=data_age[data_age$Age<min_age, ]
error_max_age=data_age[data_age$Age>max_age, ]

if (nrow(error_min_age)!=0 | nrow(error_max_age)!=0){

    print(paste("Records with age outside the allowed range:"), quote=F)
    if(nrow(error_min_age)!=0){
        print(unique(as.character(error_min_age$Trip.code)))
    }
    if(nrow(error_max_age)!=0){
        print(unique(as.character(error_max_age$Trip.code) ) )
    }
} else {
    print("No error occurred", quote=F)

}

}
