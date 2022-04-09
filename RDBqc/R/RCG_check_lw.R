
#' Consistency of length-weight relationship and consistency with allowed ranges
#'
#' @param data table of detailed data in RCG format
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP reference species for the analysis
#' @param Min min weight expected in the data
#' @param Max max weight expected in the data
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of length-weight relationship by sex and year on a given species generating a multi-frame plot. The function also returns the records in which the individual weights are greater or lower than the expected ones (\code{Min} and \code{Max} parameters).
#' @return Plot and error message
#' @export
#' @examples RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=1000)
#' @import ggplot2
#' @importFrom utils globalVariables
RCG_check_lw <- function(data,MS,GSA,SP,Min=0,Max=1000,verbose=TRUE){
    Length_class <- Individual_weight <-NULL

d <- data[!is.na(data$Length_class) & !is.na(data$Individual_weight) & data$Species %in% SP & data$Area %in% GSA & data$Flag_country %in% MS, ]
if (nrow(d)==0){
    if (verbose){
        message(paste0("No landing data available for the selected species (",SP,")") )
    }
} else {
p <- ggplot(data=d, aes(x=Length_class,y= Individual_weight)) +
    geom_point(stat="identity",colour = "orangered1", fill = "orangered1") +
    facet_grid(Year~Sex)+
    xlab("Length class")+
    ylab("Individual weight") +
    ggtitle(SP)

error_min_weight=data[!is.na(data$Individual_weight) & data$Individual_weight<Min & data$Species %in% SP, ]
error_max_weight=data[!is.na(data$Individual_weight) & data$Individual_weight>Max & data$Species %in% SP, ]

error <- rbind(error_min_weight,error_max_weight)

output <- list()
l <- length(output)+1
output[[l]] <- error
names(output)[[l]] <- "Out_of_the_range"

l <- length(output)+1
output[[l]] <- p
names(output)[[l]] <- paste("LW",SP,MS,GSA,sep=" _ ")

# if (nrow(error_min_weight)!=0){
#     err.min <-unique(as.character(error_min_weight$Trip_code))
# } else {
#     err.min <- NULL
# }
# if (nrow(error_max_weight)!=0){
#    err.max <-unique(as.character(error_max_weight$Trip_code))
# } else {
#    err.max <- NULL
# }
# err <- sort(unique(c(err.min,err.max)))
# err<-0


if (nrow(error)>0) {
    return(output)
    } else {
    if (verbose){
        print("No individual weights out of the expected range",quote=F)
        return(output)
        }
    }
}
}
