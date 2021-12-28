
#' Consistency of length-weight relationship and consistency with allowed ranges
#'
#' @param data_example table of detailed data in RCG format
#' @param Min min weight expected in the data
#' @param Max max weight expected in the data
#' @return Plot and error message
#' @export
#' @examples check_lw(data_ex,Min=0,Max=1000)
#' @import ggplot2
#' @importFrom utils globalVariables
check_lw <- function(data_example,Min=0,Max=1000){
    Length_class <- Individual_weight <-NULL

ggplot(data=data_example, aes(x=Length_class,y= Individual_weight)) + geom_point(stat="identity",colour = "orangered1", fill = "orangered1", binwidth = 0.5) + facet_grid(Year~Sex)


error_min_weight=data_example[data_example$Individual_weight<Min, ]
error_max_weight=data_example[data_example$Individual_weight>Max, ]



if (nrow(error_min_weight)!=0 | nrow(error_max_weight)!=0){

   err <-unique(c(as.character(error_min_weight$Trip_code)),unique(as.character(error_max_weight$Trip_code) ) )

} else {err<-0}
if (any(!is.na(err))) {return(err)} else {print("No individual weight data",quote=F)}
}
