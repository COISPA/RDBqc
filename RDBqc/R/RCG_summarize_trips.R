#' summarizing the number of trips/hauls monitored by year by port, metier, sampling method;
#' @param data RCG CS table
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to summarise monitored by year by port, metier, sampling method
#' @return Number of trips by area, year, port, metier and sampling method
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples RCG_summarize_trips(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
#' @import dplyr
#' @importFrom utils globalVariables

RCG_summarize_trips <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- CS
    MS <- "ITA"
    GSA <- "GSA17"
    SP <- "Merluccius merluccius"
  }

  Year <- Area <- Harbour <- Fishing_activity_category_European_lvl_6 <- Sampling_method <- Trip_code <- trips <- Flag_country <- Species <- NULL

  data <- data[data$Flag_country %in% MS & data$Area %in% GSA & data$Species %in% SP, ]
  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    suppressMessages(trips <- data %>% group_by(Year, Flag_country, Area, Harbour, Species, Fishing_activity_category_European_lvl_6, Sampling_method, Trip_code) %>% summarize(Nb_trips = n()))
    suppressMessages(trips <- trips %>% summarize(Nb_trips = n()))

    return(as.data.frame(trips))
  }
}
