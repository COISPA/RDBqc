#' check LFD
#'
#' @param data
#'
#' @return comparison plot of LFDs among the  years and length range of the data
#' @export
#'
#' @examples check_LFD(dps9)
#'
check_LFD <- function(data) {print(ggplot(data=data, aes(x=Length.class,y= Number.at.length)) + geom_histogram(stat="identity",colour = "blue", fill = "blue", binwidth = 0.5) + facet_grid(Year~ .))

paste("The maximum length class in the data is: ",max(data$Length.class)," mm",sep="")
paste("The minimum length class in the data is: ",min(data$Length.class)," mm",sep="")
}

