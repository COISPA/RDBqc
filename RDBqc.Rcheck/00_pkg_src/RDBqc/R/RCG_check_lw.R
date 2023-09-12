#' Consistency check of length-weight relationship
#'
#' @param data table of detailed data in RCG format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param Min min weight expected in the data
#' @param Max max weight expected in the data
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The function allows to check the consistency of length-weight relationship by sex and year on a given species generating a multi-frame plot. The function also returns the records in which the individual weights are greater or lower than the expected ones (\code{Min} and \code{Max} parameters). In case the \code{Min} and \code{Max} parameters are not provided, the function tests the lowest and the higher values of individual weights as outliers by mean of the Grubbs' test (from package \code{outliers})
#' @return Plot and error message
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @references Grubbs, F.E. (1950). Sample Criteria for testing outlying observations. Ann. Math. Stat. 21, 1, 27-58
#' @export
#' @examples RCG_check_lw(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus", Min = 0, Max = 1000)
#' RCG_check_lw(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
#' @import ggplot2
#' @importFrom utils globalVariables
#' @importFrom outliers grubbs.test
RCG_check_lw <- function(data, SP, MS, GSA, Min = NA, Max = NA, verbose = TRUE) {
  data <- check_cs_header(data)
  Age <- Area <- Commercial_size_category <- Date <- Flag_country <-
    Number_at_length <- Sex <- Trip_code <- Year <- fish_ID <- Length_class <- Individual_weight <- NULL

  d <- data[!is.na(data$Length_class) & !is.na(data$Individual_weight) & data$Species %in% SP & data$Area %in% GSA & data$Flag_country %in% MS, ]
  if (nrow(d) == 0) {
    if (verbose) {
      message(paste0("No landing data available for the selected species (", SP, ")"))
    }
  } else {
    if (is.na(Min) | is.na(Max)) {
      d$outliers <- "Individual weight"
      d_test <- data[!is.na(data$Individual_weight) & data$Species %in% SP, ]
      test_max <- grubbs.test(d_test$Individual_weight)$p.value
      test_min <- grubbs.test(d_test$Individual_weight, opposite = TRUE)$p.value
      if (test_max < 0.05) {
        d$outliers[which(d$Individual_weight == max(d$Individual_weight))] <- "outlier"
        id_max <- which(d$Individual_weight == max(d$Individual_weight))
        if (verbose) {
          message(paste("The Grubbs' test identifies the maximum value of individual weights distribution (", round(max(d$Individual_weight), 3), ") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers", sep = ""))
        }
      } else {
        id_max <- 0
      }

      if (test_min < 0.05) {
        d$outliers[which(d$Individual_weight == min(d$Individual_weight))] <- "outlier"
        id_min <- which(d$Individual_weight == min(d$Individual_weight))
        if (verbose) {
          message(paste("The Grubbs' test identifies the minimum value of individual weights distribution (", round(min(d$Individual_weight), 3), ") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers", sep = ""))
        }
      } else {
        id_min <- 0
      }
      error_min_weight <- data[id_max, ]
      error_max_weight <- data[id_min, ]
    } else {
      error_min_weight <- data[!is.na(data$Individual_weight) & data$Individual_weight < Min & data$Species %in% SP, ]
      error_max_weight <- data[!is.na(data$Individual_weight) & data$Individual_weight > Max & data$Species %in% SP, ]
    }

    p <- ggplot(data = d, aes(x = Length_class, y = Individual_weight)) +
      geom_point(stat = "identity", colour = "orangered1", fill = "orangered1") +
      facet_grid(Year ~ Sex) +
      xlab("Length class") +
      ylab("Individual weight") +
      ggtitle(SP)

    error <- rbind(error_min_weight, error_max_weight)
    error <- error %>% select(Flag_country, Year, Trip_code, Date, Area, Commercial_size_category, Age, Sex, Length_class, fish_ID)

    output <- list()
    l <- length(output) + 1
    output[[l]] <- error
    names(output)[[l]] <- "Out_of_the_range"

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("LW", SP, MS, GSA, sep = " _ ")

    if (nrow(error) > 0) {
      return(output)
    } else {
      if (verbose) {
        print("No individual weights out of the expected range", quote = F)
      }
      return(output)
    }
  }
}
