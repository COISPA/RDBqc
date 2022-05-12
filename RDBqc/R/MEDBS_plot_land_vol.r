#' Plot of total landing by gear and fishery
#'
#' @param data data frame containing landing data
#' @param SP species reference code in the three alpha code format
#' @param MS member state code
#' @param GSA GSA code
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to visual check the time series of landing volumes by fishery of a selected species
#' @return The function returns a plot of the total landing time series by fishery and gear
#' @export MEDBS_plot_land_vol
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_plot_land_vol(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 facet_grid
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 scale_x_continuous
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 element_text
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#'
MEDBS_plot_land_vol <- function(data,SP,MS,GSA,verbose=TRUE) {

if (FALSE) {
    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "DPS"
    verbose=TRUE
    land <- Landing_tab_example
    MEDBS_plot_land_vol(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
}

    year <- gear <- fishery <- landings <- sumLand <- NULL

    colnames(data) <- tolower(colnames(data))
    # data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
    data=data[which(data$area==as.character(GSA) & data$country==MS & data$species==SP),]

    if (nrow(data)==0) {
        if (verbose){
            message(paste0("No data available for the selected species (",SP,")") )
        }
    } else {

    data$landings[data$landings==-1] <- 0

    suppressMessages(maxland <- data %>% group_by(year,gear,fishery) %>% summarize(sumLand=sum(landings)))

plot <- ggplot(maxland,aes(x=year,y=sumLand))+geom_point(col="red")+geom_line()+
    facet_grid(gear~fishery,scales = "free")+
    theme(strip.background =element_rect(fill="white"))+
    scale_x_continuous(breaks = seq(min(data$year),max(data$year),by=2))+
    theme(axis.text.x = element_text(angle=45,size=8)) +
    ggtitle(paste0(SP," ",MS," ",GSA," Total landing")) +
    xlab("") +
    ylab("Landings (t)")

print(plot)
}

}
