
#' Check consistency of LFD by year and commercial category
#'
#' @param data_example RCG CS table
#' @return plot and a summary table with ranges by year and commercial category
#' @export
#' @examples check_LFD_comm_cat(data_ex)
#' @import ggplot2
#' @importFrom utils globalVariables
check_LFD_comm_cat <- function(data_example){
    Length_class <- Number_at_length <-NULL
    ggplot(data=data_example, aes(x=Length_class,y= Number_at_length)) + geom_histogram(stat="identity",colour = "tan2", fill = "tan2") + facet_grid(Year~ Commercial.size.category)

    pivot_min=aggregate(data_example$Length_class,by=list(data_example$Year,data_example$Commercial_size_category),FUN="min")
    colnames(pivot_min)=c("Year","Commercial_size_category","Min")
    pivot_max=aggregate(data_example$Length_class,by=list(data_example$Year,data_example$Commercial_size_category),FUN="max")
    colnames(pivot_max)=c("Year","Commercial_size_category","Max")
    pivot=merge(pivot_min,pivot_max, by=c("Year","Commercial_size_category"))
return(pivot)
    }
