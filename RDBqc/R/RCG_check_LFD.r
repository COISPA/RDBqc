#' RCG_check LFD
#'
#' @param data RCG CS table
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP reference species for the analysis
#' @param min_len minimum length
#' @param max_len maximum length
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of LFDs (length frequency distributions) by year on a given species generating a multi-frame plot. The function also returns the records in which the length classes are greater or lower than the expected ones (\code{min_len} and \code{max_len} parameters).
#' @return comparison plot of LFDs among the  years and check of length range of the data using allowed range
#' @export
#' @examples RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=1,max_len=35)
#' @importFrom ggplot2 ggplot
#' @importFrom utils globalVariables
RCG_check_LFD <- function(data,MS,GSA,SP,min_len=1,max_len=1000,verbose=TRUE){

    data <- data[data$Species==SP & data$Area %in% GSA & data$Flag_country %in% MS, ]

    if (nrow(data)==0) {
        if (verbose){
            message(paste0("No landing data available for the selected species (",SP,")") )
        }
    } else {

    Length_class <- Number_at_length <-NULL
    p <- suppressWarnings(
        ggplot(data=data, aes(x=Length_class,y= Number_at_length)) +
              geom_histogram(stat="identity",colour = "blue", fill = "blue") +
              facet_grid(Year~ .)
         )

error_min_length=data[data$Length_class<min_len, ]
error_max_length=data[data$Length_class>max_len, ]
error <- rbind(error_min_length,error_min_length)

output <- list()
l <- length(output)+1
output[[l]] <- error
names(output)[[l]] <- "Out_of_the_range"

l <- length(output)+1
output[[l]] <- p
names(output)[[l]] <- paste("LFD",SP,MS,GSA,sep=" _ ")


if (nrow(error)>0){
    return(output)
} else {
    if (verbose){
        print("No individual length classes out of the expected range",quote=F)
        return(output)
    }
    }

}
}
