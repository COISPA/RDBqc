
#' Check consistency of LFD by year and commercial category
#'
#' @param data_example
#'
#' @return plot and a summary table with ranges by year and commercial category
#' @export
#'
#' @examples check_LFD_comm_cat(data_example)
#'
check_LFD_comm_cat <- function(data_example){
    ggplot(data=data_example, aes(x=Length.class,y= Number.at.length)) + geom_histogram(stat="identity",colour = "tan2", fill = "tan2", binwidth = 0.5) + facet_grid(Year~ Commercial.size.category)

    pivot_min=aggregate(data_example$Length.class,by=list(data_example$Year,data_example$Commercial.size.category),FUN="min")
    colnames(pivot_min)=c("Year","Commercial_size_category","Min")
    pivot_max=aggregate(data_example$Length.class,by=list(data_example$Year,data_example$Commercial.size.category),FUN="max")
    colnames(pivot_max)=c("Year","Commercial_size_category","Max")
    merge(pivot_min,pivot_max, by=c("Year","Commercial_size_category"))
return(pivot_min)
    }
