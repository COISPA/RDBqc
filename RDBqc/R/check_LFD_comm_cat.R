
#' Check consistency of LFD by year and commercial category
#'
#' @param data RCG CS table
#' @param species reference species for the analysis
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of LFDs (length frequency distributions) by year and commercial size cetegory on a given species generating a multi-frame plot. The function also returns a data frame with the length range by year and commercial size category.
#' @return plot and a summary table with ranges by year and commercial category
#' @export
#' @examples check_LFD_comm_cat(data_ex, species="Mullus barbatus")
#' @import ggplot2
#' @importFrom utils globalVariables
check_LFD_comm_cat <- function(data,species,verbose=TRUE){
    if(FALSE){
        data <- data_ex
        data[1,"Length_class" ] <- NA

        check_LFD_comm_cat(data, species="Mullus barbatus")
    }

    Length_class <- Number_at_length <-NULL

    if (! species %in% unique(data$Species) & verbose==TRUE) {
        message(paste0("The selected species (",species,") is not included in the data"))
    } else {
        data <- data[data$Species %in% species, ]
        length_na <- data[is.na(data$Length_class),]
        number_na <- data[is.na(data$Number_at_length),]
        data <- data[!is.na(data$Length_class)& !is.na(data$Number_at_length),]

        p <- suppressWarnings(ggplot(data=data, aes(x=Length_class,y= Number_at_length)) +
            geom_histogram(stat="identity",colour = "tan2", fill = "tan2") +
            facet_grid(Year~ Commercial_size_category) +
            ggtitle(species)) +
            xlab("Length Class") +
            ylab("Number at length")
        print(p)

        pivot_min=aggregate(data$Length_class,by=list(data$Year,data$Commercial_size_category),FUN="min")
        colnames(pivot_min)=c("Year","Commercial_size_category","Min")
        pivot_max=aggregate(data$Length_class,by=list(data$Year,data$Commercial_size_category),FUN="max")
        colnames(pivot_max)=c("Year","Commercial_size_category","Max")
        pivot=merge(pivot_min,pivot_max, by=c("Year","Commercial_size_category"))
    }
    if (verbose){
        if (nrow(length_na)>0) {
            message("Na included in 'Length_class' were eliminated from the analysis")
        }
        if (nrow(number_na)>0) {
            message("Na included in 'Number_at_length' were eliminated from the analysis")
        }

        return(pivot)
    } else {
        return(pivot)
    }

    }
