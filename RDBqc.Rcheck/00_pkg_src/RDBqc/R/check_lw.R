
#' Consistency of length-weight relationship and consistency with allowed ranges
#'
#' @param data table of detailed data in RCG format
#' @param species reference species for the analysis
#' @param Min min weight expected in the data
#' @param Max max weight expected in the data
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of length-weight relationship by sex and year on a given species generating a multi-frame plot. The function also returns the records in which the individual weights are greater or lower than the expected ones (\code{Min} and \code{Max} parameters).
#' @return Plot and error message
#' @export
#' @examples check_lw(data_ex,species="Mullus barbatus",Min=0,Max=1000)
#' @import ggplot2
#' @importFrom utils globalVariables
check_lw <- function(data,species,Min=0,Max=1000,verbose=TRUE){
    Length_class <- Individual_weight <-NULL

d <- data[!is.na(data$Length_class) & !is.na(data$Individual_weight) & data$Species %in% species, ]
p <- ggplot(data=d, aes(x=Length_class,y= Individual_weight)) +
    geom_point(stat="identity",colour = "orangered1", fill = "orangered1") +
    facet_grid(Year~Sex)+
    xlab("Length class")+
    ylab("Individual weight") +
    ggtitle(species)
print(p)

error_min_weight=data[!is.na(data$Individual_weight) & data$Individual_weight<Min & data$Species %in% species, ]
error_max_weight=data[!is.na(data$Individual_weight) & data$Individual_weight>Max & data$Species %in% species, ]

error <- rbind(error_min_weight,error_max_weight)

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
    return(error)
    } else {
    if (verbose){
        print("No individual weights out of the expected range",quote=F)
        return(error)
        }
    }
}
