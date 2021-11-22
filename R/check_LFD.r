#' check LFD
#'
#' @param data
#'
#' @return comparison plot of LFDs among the  years and length range of the data
#' @export
#'
#' @examples check_LFD(dps9)
#'
check_LFD <- function(data,min_len=1,max_len=1000) {print(ggplot(data=data, aes(x=Length.class,y= Number.at.length)) + geom_histogram(stat="identity",colour = "blue", fill = "blue", binwidth = 0.5) + facet_grid(Year~ .))

paste("The maximum length class in the data is: ",max(data$Length.class)," mm",sep="")
paste("The minimum length class in the data is: ",min(data$Length.class)," mm",sep="")

error_min_length=data[data$Length.class<min_len, ]
error_max_length=data[data$Length.class>max_len, ]

if (nrow(error_min_length)!=0 | nrow(error_max_length)!=0){

    print(paste("Records with length outside the allowed range:"), quote=F)
    if(nrow(error_min_length)!=0){
        print(unique(as.character(error_min_length$Trip.code))  )
    }
    if(nrow(error_max_length)!=0){
        print(unique(as.character(error_max_length$Trip.code) ))
    }
} else {
    print("No error occurred", quote=F)

}
}

