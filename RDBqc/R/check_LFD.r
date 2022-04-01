#' check LFD
#'
#' @param data RCG CS table
#' @param species reference species for the analysis
#' @param min_len minimum length
#' @param max_len maximum length
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of LFDs (length frequency distributions) by year on a given species generating a multi-frame plot. The function also returns the records in which the length classes are greater or lower than the expected ones (\code{min_len} and \code{max_len} parameters).
#' @return comparison plot of LFDs among the  years and check of length range of the data using allowed range
#' @export
#' @examples check_LFD(data_ex,species="Mullus barbatus",min_len=1,max_len=35)
#' @importFrom ggplot2 ggplot
#' @importFrom utils globalVariables
check_LFD <- function(data,species,min_len=1,max_len=1000,verbose=TRUE){

    data <- data[data$Species==species, ]
    Length_class <- Number_at_length <-NULL
    p <- ggplot(data=data, aes(x=Length_class,y= Number_at_length)) +
              geom_histogram(stat="identity",colour = "blue", fill = "blue") +
              facet_grid(Year~ .)
    print(p)


error_min_length=data[data$Length_class<min_len, ]
error_max_length=data[data$Length_class>max_len, ]
error <- rbind(error_min_length,error_min_length)



if (nrow(error)){
    return(error)
} else {
    if (verbose){
        print("No individual length classes out of the expected range",quote=F)
        return(error)
    }
    }


}
