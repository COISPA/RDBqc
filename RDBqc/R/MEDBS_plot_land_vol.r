#' Plot of total landing by gear and fishery
#'
#' @param data data frame containing landing data
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @return The function returns a plot of the total landing time series by fishery and gear
#' @export MEDBS_plot_land_vol
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_plot_land_vol(data=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
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
MEDBS_plot_land_vol <- function(data,MS,GSA,SP) {

if (FALSE) {
    MS <- "ITA"
    GSA <- 9
    SP <- "DPS"
    verbose=TRUE
    land <- Landing_tab_example
    MEDBS_plot_land_vol(data=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
}

    year <- gear <- fishery <- landings <- sumLand <- NULL

    data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
    data=data[which(data$area==as.numeric(GSA) & data$country==MS & data$species==SP),]
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
