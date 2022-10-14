#' Check consistency of age-length relationship
#'
#' @param data table of detailed data in RCG format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param min_age minimum age expected
#' @param max_age maximum age expected
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the consistency of the age-length data included in the table of RCG detailed data. Furthermore, the function identifies the age data outside a reference range of values provided by the user for the species. In case the \code{min_age} and \code{max_age} parameters are not provided, the function tests the lowest and the higher values of Age as outliers by mean of the Grubbs' test (from package \code{outliers})
#' @return The function returns a list of object containing a summary table, an age-length plot and a table of the outlayers, if any.
#' @references Grubbs, F.E. (1950). Sample Criteria for testing outlying observations. Ann. Math. Stat. 21, 1, 27-58
#' @export
#' @examples RCG_check_AL(data=data_ex, MS = "ITA", GSA = "GSA99",
#' SP = "Mullus barbatus", min_age = 0, max_age = 9)
#' RCG_check_AL(data=data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
#' @import ggplot2
#' @importFrom stats aggregate
#' @importFrom utils globalVariables
#' @importFrom outliers grubbs.test
RCG_check_AL <- function(data, MS, GSA, SP, min_age = NA, max_age = NA, verbose = TRUE) {

  Age <- Length_class <- Sex <- NULL

  AGE_na <- data[is.na(data$Age) & data$Species %in% SP & data$Flag_country %in% MS & data$Area %in% GSA, ]
  if (nrow(AGE_na)>0){
  if (verbose) {
    message("NA included in the 'Age' field have been removed from the analysis.")
  }
  }

  length_na <- data[is.na(data$Length_class) & data$Species %in% SP, ]
  if (nrow(length_na)>0) {
  if (verbose) {
    message("NA included in the 'Length_class' field have been removed from the analysis.")
  }
  }

  data <- data[!is.na(data$Age) & !is.na(data$Length_class) & data$Species %in% SP & data$Flag_country %in% MS & data$Area %in% GSA, ]

  if (nrow(data) == 0) {
    message("No data availble for the analysis")
  } else if (nrow(data) > 0) {
    p <- ggplot(data = data, aes(x = Age, y = Length_class, col = Sex)) +
      geom_point() +
      facet_grid(Year ~ Sex) +
      ggtitle(SP) +
      xlab("Age") +
      ylab("Length class (mm)")

    # summary table of number of individuals by length class by year
    data_age <- data[!is.na(data$Age), ]

    tab_age <- data.frame(data_age %>% group_by(Year,Length_class) %>% summarize(nb_age_measurements=sum(Number_at_length,na.rm=TRUE)))


    #   aggregate(data_age$Number_at_length, by = list(data_age$Year, data_age$Length_class), FUN = "length")
    # colnames(tab_age) <- c("Year", "Length_class", "nb_age_measurements")

    output <- list()
    l <- length(output) + 1
    output[[l]] <- tab_age
    names(output)[[l]] <- "Age-Length summary table"


    # Check age consistent with allowed range

    if (is.na(min_age) | is.na(max_age)) {
      test_max <- grubbs.test(data$Age)$p.value
      # test_min <- grubbs.test(data$Age, opposite = TRUE)$p.value

      if (test_max < 0.05) {
        id_max <- which(data$Age == max(data$Age))
        if (verbose) {
          message(paste("The Grubbs' test identifies the maximum value of Age distribution (",round(max(data$Age),1),") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers",sep=""))
        }
      } else {
        id_max <- 0
      }

      # if (test_min < 0.05) {
      #   id_min <- which(data$Age == min(data$Age))
      #   if (verbose) {
      #     message(paste("The Grubbs' test identifies the minimum value of Age distribution (",round(min(data$Age),1),") as an outlier. Please, carefully check the plots to identify the presence of other possible outliers",sep=""))
      #   }
      # } else {
      #   id_min=0
      # }

      # error_min_age <- data[id_min, ]
      error_max_age <- data[id_max, ]

    } else{
    # error_min_age <- data_age[data_age$Age < min_age, ]
    error_max_age <- data_age[data_age$Age > max_age, ]
    }


    if ( nrow(error_max_age) != 0) {   # nrow(error_min_age) != 0 |
      err <-  error_max_age # rbind(error_min_age, error_max_age)
      err <- err %>% select(Flag_country,Year,Trip_code, Date, Area, Commercial_size_category_scale, Age,Sex,Length_class,fish_ID	)

    } else {
      err <- data[0,]
      err <- err %>% select(Flag_country,Year,Trip_code, Date, Area, Commercial_size_category_scale, Age,Sex,Length_class,fish_ID	)

    }

    l <- length(output) + 1
    output[[l]] <- err
    names(output)[[l]] <- "Outlayers"

    l <- length(output) + 1
    output[[l]] <- p
    names(output)[[l]] <- paste("AL", SP, MS, GSA, sep = " _ ")
    return(output) # list(tab_age,err,p)
  }
}
