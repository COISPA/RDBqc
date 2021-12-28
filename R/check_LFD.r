#' check LFD
#'
#' @param data_example RCG CS table
#' @param min_len minimum length
#' @param max_len maximum length
#' @return comparison plot of LFDs among the  years and check of length range of the data using allowed range
#' @export
#' @examples check_LFD(data_ex,min_len=1,max_len=35)
#' @import ggplot2
#' @importFrom utils globalVariables
check_LFD <- function(data_example,min_len=1,max_len=1000) {

    Length_class <- Number_at_length <-NULL
    print(ggplot(data=data_example, aes(x=Length_class,y= Number_at_length)) + geom_histogram(stat="identity",colour = "blue", fill = "blue") + facet_grid(Year~ .))


error_min_length=data_example[data_example$Length_class<min_len, ]
error_max_length=data_example[data_example$Length_class>max_len, ]




if (nrow(error_min_length)!=0 | nrow(error_max_length)!=0){

    err<-as.character(c(unique(error_min_length$Trip_code), unique(error_max_length$Trip_code) ))
} else {err<-0}

return(err)
}
