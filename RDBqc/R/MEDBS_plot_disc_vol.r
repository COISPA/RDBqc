#' Plot of total discards by gear and fishery
#'
#' @param data data frame containing discard data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @description The function allows to visual check the time series of discard volumes by fishery of a selected species
#' @return The function returns a plot of the total discards time series by fishery and gear
#' @export MEDBS_plot_disc_vol
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_plot_disc_vol(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
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


MEDBS_plot_disc_vol <- function(data, SP, MS, GSA) {

  year <- gear <- fishery <- discards <- sumLand <- NULL

  colnames(data) <- tolower(colnames(data))

  # data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
  data <- data[which(data$area == as.character(GSA) & data$country == MS & data$species == SP), ]


  if (nrow(data) > 0) {
    data$discards[data$discards == -1] <- 0
    suppressMessages(maxland <- data %>% group_by(year, gear, fishery) %>% summarize(sumLand = sum(discards)))
    plot <- ggplot(maxland, aes(x = year, y = sumLand)) +
      geom_point(col = "red") +
      geom_line() +
      facet_grid(gear ~ fishery, scales = "free") +
      theme(strip.background = element_rect(fill = "white")) +
      scale_x_continuous(breaks = seq(min(data$year), max(data$year), by = 2)) +
      theme(axis.text.x = element_text(angle = 45, size = 8)) +
      ggtitle(paste0(SP, " ", MS, " ", GSA, " - Total discards")) +
      xlab("") +
      ylab("Discards (t)")

    print(plot)
  } else {
    message("No discard data in the subset.\n")
  }
}
