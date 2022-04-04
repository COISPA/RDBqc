#' Check consistency sex and maturity stage
#'
#' @param data table of detailed data in RCG format
#' @param species reference species for the analysis
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to perform a visual check of the maturity stage composition by length class, sex and year.
#' @return The function the returns the plot of the maturity stages by length class
#' @export
#' @examples check_mat(data_ex,species="Mullus barbatus")
#' @import ggplot2


check_mat<-function(data,species,verbose=TRUE){

    if (FALSE) {
        data = data_ex
    }

    Length_class <- Number_at_length <-Maturity_Stage<-Sex<-NULL

    data <- data[data$Species %in% species, ]

    if ( any(is.na(data$Length_class))) {
        if (verbose){
            message(paste0("NA values in the 'Length_class' field will be removed from the analysis"))
        }
        data <- data[!is.na(data$Length_class), ]
    }
    if ( any(is.na(data$Maturity_Stage))) {
        if (verbose){
            message(paste0("NA values in the 'Maturity_Stage' field will be removed from the analysis"))
        }

        data <- data[!is.na(data$Maturity_Stage), ]
    }

    if (nrow(data)== 0) {
        if (verbose){
            message(paste0("No data for the selected species (",species,")"))
        }

    } else if (nrow(data)>0){

        p1 <- ggplot(data=data, aes(x=Length_class,y=Maturity_Stage ,col=Sex)) +
            geom_point(stat="identity", fill = "darkorchid4") +
            facet_grid(Year~ Sex) +
            xlab("Length Class") +
            ylab("Maturity Stage") +
            ggtitle(species)
        print(p1)

}
}
