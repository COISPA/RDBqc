
#' Consistency of length-weight relationship and consistency with allowed ranges
#'
#' @param data_example table of detailed data in RCG format
#' @param Min min weight expected in the data
#' @param Max max weight expected in the data
#'
#' @return Plot and error message
#' @export
#'
#' @examples
#' check_lw(data_example,Min=0,Max=1000)
check_lw <- function(data_example,Min=0,Max=1000){

ggplot(data=data_example, aes(x=Length.class,y= Individual.weight)) + geom_point(stat="identity",colour = "orangered1", fill = "orangered1", binwidth = 0.5) + facet_grid(Year~Sex)

print(paste("The maximum individual weight in the data is: ",max(data_example$Individual.weight)," g",sep=""),quote=F)

print(paste("The minimum individual weight in the data is: ",min(data_example$Individual.weight)," g",sep=""),quote=F)

#allowed_ranges=read.table("Check_allowed_ranges.csv",sep=";",header=T)

error_min_weight=data[data$Individual.weight<Min, ]
error_max_weight=data[data$Individual.weight>Max, ]

if (nrow(error_min_weight)!=0 | nrow(error_max_weight)!=0){

    print(paste("Records with weight outside the allowed range:"), quote=F)
    if(nrow(error_min_weight)!=0){
        print(unique(as.character(error_min_weight$Trip.code))  )
    }
    if(nrow(error_max_weight)!=0){
        print(unique(as.character(error_max_weight$Trip.code) ) )
    }
} else {
    print("No error occurred", quote=F)

}
}
