#' Consistency check of LFDs
#'
#' @param data RCG CS table
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param min_len minimum length
#' @param max_len maximum length
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the consistency of LFDs (length frequency distributions) by year on a given species generating a multi-frame plot. The function also returns the records in which the length classes are greater or lower than the expected ones (\code{min_len} and \code{max_len} parameters).
#' @return The function returns a comparison plot of LFDs among the years and a table reporting the length classes out of the expected range, according to the reference length provided.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples RCG_check_LFD(
#'   data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
#'   min_len = 30, max_len = 300
#' )
#' RCG_check_LFD(
#'   data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
#'   min_len = NA, max_len = NA
#' )
#' @importFrom ggplot2 ggplot
#' @importFrom utils globalVariables
#' @importFrom outliers grubbs.test
RCG_check_LFD <- function(data, SP, MS, GSA, min_len = NA, max_len = NA, verbose = TRUE) {
  data <- check_cs_header(data)
  Age <- Area <- Commercial_size_category <- Date <- Flag_country <-
    Number_at_length <- Sex <- Trip_code <- Year <- fish_ID <- Length_class <- Number_at_length <- NULL
  data <- data[data$Species == SP & data$Area %in% GSA & data$Flag_country %in% MS, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No landing data available for the selected species (", SP, ")"))
    }
    output <- NULL
  } else {
    data <- data[!is.na(data$Length_class) & !is.na(data$Number_at_length), ]
    p <- suppressWarnings(
      ggplot(data = data, aes(x = Length_class, y = Number_at_length)) +
        geom_histogram(stat = "identity", colour = "blue", fill = "blue") +
        facet_grid(Year ~ .)
    )

    if (is.na(min_len) | is.na(max_len)) {
      test_max <- grubbs.test(data$Length_class)$p.value
      test_min <- grubbs.test(data$Length_class, opposite = TRUE)$p.value
      if (test_max < 0.05) {
        id_max <- which(data$Length_class == max(data$Length_class))
        if (verbose) {
          message(paste("The Grubbs' test identifies the maximum value of Length class distribution (", round(max(data$Length_class), 1), ") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers", sep = ""))
        }
      } else {
        id_max <- 0
      }

      if (test_min < 0.05) {
        id_min <- which(data$Length_class == min(data$Length_class))
        if (verbose) {
          message(paste("The Grubbs' test identifies the minimum value of Length class distribution (", round(min(data$Length_class), 1), ") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers", sep = ""))
        }
      } else {
        id_min <- 0
      }
      error_min_length <- data[id_min, ]
      error_max_length <- data[id_max, ]
    } else {
      error_min_length <- data[data$Length_class < min_len, ]
      error_max_length <- data[data$Length_class > max_len, ]
    }
    error <- rbind(error_min_length, error_max_length)
    error <- error %>% select(Flag_country, Year, Trip_code, Date, Area, Commercial_size_category, Age, Sex, Length_class, fish_ID)

    output <- list()
    l <- length(output) + 1
    output[[l]] <- error
    names(output)[[l]] <- "Out_of_the_range"

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("LFD", SP, MS, GSA, sep = " _ ")

    if (nrow(error) > 0) {
      return(output)
    } else {
      if (verbose) {
        print("No individual length classes out of the expected range", quote = F)
      }
      return(output)
    }
  }
}
