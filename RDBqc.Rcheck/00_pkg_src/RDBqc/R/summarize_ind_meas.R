#' Number of individual by trip for which biological data have been collected (length, sex, maturity, weight and age)
#' @param data detailed data in RCG CS format
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose boolean value to obtain further explanation messages from the function
#' @return a list containing a summary of measurements by trip for each biological variable
#' @export
#' @examples summarize_ind_meas(data=data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
#' @import dplyr
#' @importFrom utils globalVariables
summarize_ind_meas <- function(data,MS,GSA,SP,verbose=TRUE) {

    if (FALSE) {
        data <- data_ex
        MS <- "ITA"
        GSA <- "GSA99"
        SP <- "Mullus barbatus"
    }
Number_at_length <- Maturity_Stage <- Sex <- Age <- Individual_weight <- Species <- Year <- Area <- Harbour <- Fishing_activity_category_European_lvl_6 <- Sampling.method <- Trip_code <- trips <- NULL

data <- data[data$Flag_country == MS & data$Area == GSA & data$Species == SP, ]

if (nrow(data)==0){
    if (verbose){
        message(paste0("No data available for the selected species (",SP,")") )
      }
    } else {
  lengths <- data %>%
    group_by(Year, Area, Species, Trip_code) %>%
    summarize(length_measurements = sum(Number_at_length))
  lengths <- as.data.frame(lengths)

  mat <- data %>%
    filter(!is.na(Maturity_Stage)) %>%
    group_by(Year, Area, Species, Trip_code) %>%
    summarize(maturity_data = sum(Number_at_length))
  mat <- as.data.frame(mat)

  sex <- data %>%
    filter(!is.na(Sex) & Sex != "U" & Sex != "C") %>%
    group_by(Year, Area, Species, Trip_code) %>%
    summarize(sex_data = sum(Number_at_length))
  sex <- as.data.frame(sex)

  age <- data %>%
    filter(!is.na(Age)) %>%
    group_by(Year, Area, Species, Trip_code) %>%
    summarize(age_data = sum(Number_at_length))
  age <- as.data.frame(age)

  weight <- data %>%
    filter(!is.na(Individual_weight)) %>%
    group_by(Year, Area, Species, Trip_code) %>%
    summarize(weight_data = sum(Number_at_length))
  weight <- as.data.frame(weight)
####################
  if (nrow(sex) == 0) {
      if(verbose){
          print("No sex data", quote = F)
      }
  } else {
        sex$variable <- colnames(sex)[ncol(sex)]
        colnames(sex)[ncol(sex)-1] <- "number_of_data"
  }

 #########

  if (nrow(mat) == 0) {
      if(verbose){
          print("No maturity data", quote = F)
      }
  } else {
      mat$variable <- colnames(mat)[ncol(mat)]
      colnames(mat)[ncol(mat)-1] <- "number_of_data"
  }

  #########

  if (nrow(age) == 0) {
      if(verbose){
          print("No age data", quote = F)
      }
  } else {
      age$variable <- colnames(age)[ncol(age)]
      colnames(age)[ncol(age)-1] <- "number_of_data"
  }

  #########

  if (nrow(weight) == 0) {
      if(verbose){
          print("No weight data", quote = F)
      }
  } else {
      weight$variable <- colnames(weight)[ncol(weight)]
      colnames(weight)[ncol(weight)-1] <- "number_of_data"
  }

  #########

  if (nrow(lengths) == 0) {
      if(verbose){
          print("No weight data", quote = F)
      }
  } else {
      lengths$variable <- colnames(lengths)[ncol(lengths)]
      colnames(lengths)[ncol(lengths)-1] <- "number_of_data"
  }

  result_table <- do.call(rbind,list(lengths, mat, sex, age, weight))

  return(result_table)
    }
}

