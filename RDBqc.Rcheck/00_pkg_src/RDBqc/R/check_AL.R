#' Check consistency of age-length relationship
#'
#' @param data table of detailed data in RCG format
#' @param species reference species for the analysis
#' @param min_age minimum age expected
#' @param max_age maximum age expected
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @return summary table length-age and error (if any)
#' @export
#' @examples check_AL(data_ex,species="Mullus barbatus",min_age=0,max_age=30)
#' @import ggplot2
#' @importFrom stats aggregate
#' @importFrom utils globalVariables
check_AL<-function(data,species,min_age=0,max_age=30, verbose=TRUE){
    Age<-Length_class<-Sex<-NULL

    if (FALSE) {
        data <- data_ex
        species <- "Mullus barbatus"
        min_age=0
        max_age=30
        verbose=TRUE
        # data$Age <- NA
    }

AGE_na <- data[is.na(data$Age) & data$Species %in% species,]
if (verbose){
    message("NA included in the 'Age' field have been removed from the analysis.")
}
length_na <- data[is.na(data$Length_class) & data$Species %in% species,]
if (verbose){
    message("NA included in the 'Length_class' field have been removed from the analysis.")
}

data <- data[!is.na(data$Age) & !is.na(data$Length_class) & data$Species %in% species,]

if (nrow(data)==0) {
    message("No useful data for the analysis")
} else if (nrow(data)>0){

p <- ggplot(data=data, aes(x=Age,y=Length_class,col=Sex)) +
    geom_point() +
    facet_grid(Year~ Sex) +
    ggtitle(species) +
    xlab("Age") +
    ylab("Length class (mm)")
print(p)
# summary table of number of individuals by length class by year
data_age=data[!is.na(data$Age),]

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
}
