#' Number of individual by trip for which biological data have been collected (length, sex, maturity, weight and age)
#' @param data detailed data in RCG CS format
#' @param MS member state code
#' @param GSA GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @return The function returns a table containing a summary of measurements by trip for each biological variable
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples RCG_summarize_ind_meas(data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")
#' @import dplyr
#' @importFrom utils globalVariables
RCG_summarize_ind_meas <- function(data, MS, GSA, SP, verbose = TRUE) {
  data <- check_cs_header(data)
  presence <- Number_at_length <- Maturity_Stage <- Sex <- Age <- Individual_weight <- Species <- Year <- Area <- Harbour <- fishing_activity_category_national <- Fishing_activity_category_European_lvl_6 <- Sampling.method <- Trip_code <- trips <- NULL

  data <- data[data$Flag_country == MS & data$Area == GSA & data$Species == SP, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else {
    data$presence <- 1
    data[is.na(data$Length_class), "presence"] <- 0
    data$presence <- data$presence * data$Number_at_length
    lengths <- data %>%
      group_by(Year, Area, Species, Trip_code) %>%
      summarize(length_measurements = sum(presence, na.rm = TRUE))
    lengths <- as.data.frame(lengths)
    data$presence <- 1
    data[is.na(data$Maturity_Stage), "presence"] <- 0
    data$presence <- data$presence * data$Number_at_length
    mat <- data %>%
      group_by(Year, Area, Species, Trip_code) %>%
      summarize(maturity_data = sum(presence, na.rm = TRUE))
    mat <- as.data.frame(mat)

    data$presence <- 1
    data[is.na(data$Sex), "presence"] <- 0
    data$presence <- data$presence * data$Number_at_length
    sex <- data %>%
      filter(Sex != "U" & Sex != "C") %>%
      group_by(Year, Area, Species, Trip_code) %>%
      summarize(sex_data = sum(presence, na.rm = TRUE))
    sex <- as.data.frame(sex)

    data$presence <- 1
    data[is.na(data$Age), "presence"] <- 0
    data$presence <- data$presence * data$Number_at_length
    age <- data %>%
      group_by(Year, Area, Species, Trip_code) %>%
      summarize(age_data = sum(presence, na.rm = TRUE))
    age <- as.data.frame(age)

    data$presence <- 1
    data[is.na(data$Individual_weight), "presence"] <- 0
    data$presence <- data$presence * data$Number_at_length
    weight <- data %>%
      group_by(Year, Area, Species, Trip_code) %>%
      summarize(weight_data = sum(presence, na.rm = TRUE))
    weight <- as.data.frame(weight)

    if (nrow(sex) == 0) {
      if (verbose) {
        print("No sex data", quote = F)
      }
      sex <- data.frame(matrix(ncol=6, nrow=0))
      colnames(sex) <- c("Year","Area","Species","Trip_code","number_of_data","variable")
    } else {
      sex$variable <- colnames(sex)[ncol(sex)]
      colnames(sex)[ncol(sex) - 1] <- "number_of_data"
    }

    if (nrow(mat) == 0) {
      if (verbose) {
        print("No maturity data", quote = F)
      }
      mat <- data.frame(matrix(ncol=6, nrow=0))
      colnames(mat) <- c("Year","Area","Species","Trip_code","number_of_data","variable")
    } else {
      mat$variable <- colnames(mat)[ncol(mat)]
      colnames(mat)[ncol(mat) - 1] <- "number_of_data"
    }

    if (nrow(age) == 0) {
      if (verbose) {
        print("No age data", quote = F)
      }
      age <- data.frame(matrix(ncol=6, nrow=0))
      colnames(age) <- c("Year","Area","Species","Trip_code","number_of_data","variable")
    } else {
      age$variable <- colnames(age)[ncol(age)]
      colnames(age)[ncol(age) - 1] <- "number_of_data"
    }

    if (nrow(weight) == 0) {
      if (verbose) {
        print("No weight data", quote = F)
      }
      weight <- data.frame(matrix(ncol=6, nrow=0))
      colnames(weight) <- c("Year","Area","Species","Trip_code","number_of_data","variable")
    } else {
      weight$variable <- colnames(weight)[ncol(weight)]
      colnames(weight)[ncol(weight) - 1] <- "number_of_data"
    }

    if (nrow(lengths) == 0) {
      if (verbose) {
        print("No length data", quote = F)
      }
      lengths <- data.frame(matrix(ncol=6, nrow=0))
      colnames(lengths) <- c("Year","Area","Species","Trip_code","number_of_data","variable")
    } else {
      lengths$variable <- colnames(lengths)[ncol(lengths)]
      colnames(lengths)[ncol(lengths) - 1] <- "number_of_data"
    }

    result_table <- do.call(rbind, list(lengths, mat, sex, age, weight))
    if (nrow(result_table)>0){
    result_table[is.na(result_table$number_of_data), "number_of_data"] <- 0
    result_table <- as.data.table(result_table)
    result_table <- data.table::dcast(result_table, Year + Area + Species + Trip_code ~ variable, value.var = "number_of_data")
    result_table <- data.frame(result_table)
    } else {
      result_table <- data.frame(matrix(ncol=8,nrow=0))
      colnames(result_table) <- c("Year","Area","Species","Trip_code","age_data","length_measurements","maturity_data","weight_data" )
    }
    return(result_table)
  }
}
