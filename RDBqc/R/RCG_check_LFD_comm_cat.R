#' Check consistency of LFD by year and commercial category
#'
#' @param data RCG CS table
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the consistency of LFDs (length frequency distributions) by year and commercial size category on a given species.
#' @return The function returns a multi-frame plot of LFDs (length frequency distributions) by year and commercial size category for the selected species. The function also returns a data frame with the length range by year and commercial size category.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples RCG_check_LFD_comm_cat(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
#' @import ggplot2
#' @importFrom utils globalVariables
RCG_check_LFD_comm_cat <- function(data, SP, MS, GSA, verbose = TRUE) {
  if (FALSE) {
    data <- CS
    SP = "Merluccius merluccius"
    GSA <- "GSA17"
    RCG_check_LFD_comm_cat(CS, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
  }

  Length_class <- Number_at_length <- NULL

  data <- data[data$Species %in% SP & data$Area %in% GSA & data$Flag_country %in% MS, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("The selected species (", SP, ") is not included in the data"))
    }
    output <- NULL
  } else {
    length_na <- data[is.na(data$Length_class), ]
    number_na <- data[is.na(data$Number_at_length), ]
    data <- data[!is.na(data$Length_class) & !is.na(data$Number_at_length), ]

    p <- suppressWarnings(ggplot(data = data, aes(x = Length_class, y = Number_at_length)) +
      geom_histogram(stat = "identity", colour = "tan2", fill = "tan2") +
      facet_grid(Year ~ Commercial_size_category) +
      ggtitle(SP)) +
      xlab("Length Class") +
      ylab("Number at length")

    pivot_min <- aggregate(data$Length_class, by = list(data$Year, data$Commercial_size_category), FUN = "min")
    colnames(pivot_min) <- c("Year", "Commercial_size_category", "Min")
    pivot_max <- aggregate(data$Length_class, by = list(data$Year, data$Commercial_size_category), FUN = "max")
    colnames(pivot_max) <- c("Year", "Commercial_size_category", "Max")
    pivot <- merge(pivot_min, pivot_max, by = c("Year", "Commercial_size_category"))

    output <- list()
    l <- length(output) + 1
    output[[l]] <- pivot
    names(output)[[l]] <- "summary table"


    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("LFD", SP, MS, GSA, sep = " _ ")
  }
  if (verbose) {
    if (nrow(length_na) > 0) {
      message("Na included in 'Length_class' were eliminated from the analysis")
    }
    if (nrow(number_na) > 0) {
      message("Na included in 'Number_at_length' were eliminated from the analysis")
    }

    return(output)
  } else {
    return(output)
  }
}
