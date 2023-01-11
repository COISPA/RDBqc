#' Check of missing combination GSA/Fleet segment per year
#'
#' @description Function to verify the completeness of the GSA/Fleet segments in Task II.2 table, as reported in the combination_taskII2 table.
#' @param data1 GFCM Task II.2 table
#' @param data2 List of combination of the expected GSA/Fleet segments per year for Task II.2 table
#' @param MS member state code
#' @param GSA GSA code
#' @return The function returns a list of missing combinations GSA/Fleet segment per year.
#' @export
#' @author Loredana Casciaro <casciaro@@coispa.eu>
#' @author Sebastien Alfonso <salfonso@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples check_presence_taskII2(task_ii2, combination_taskII2, MS = "ITA", GSA = "18")
check_presence_taskII2 <- function(data1, data2, MS, GSA) {
  if (FALSE) {
    data1 <- task_ii2
    data2 <- combination_taskII2
  }

  # Declaration of variables and suppression of empty columns for dataframe1
  # str(data1)
  data1$Reference_Year <- as.numeric(data1$Reference_Year)
  data1$CPC <- as.character(data1$CPC)
  data1$GSA <- as.numeric(data1$GSA)
  data1$Segment <- as.character(data1$Segment)
  data1$Species <- as.character(data1$Species)
  data1$Landing <- as.numeric(data1$Landing)
  data1$Discards <- as.numeric(data1$Discards)
  data1$Catch <- as.numeric(data1$Catch)

  data1 <- data1[data1$CPC %in% MS & data1$GSA %in% GSA, ]
  yrs <- unique(data1$Reference_Year)

  # Declaration of variables and suppression of empty columns for dataframe2
  data2$GSA <- as.numeric(data2$GSA)
  data2$Fleet.segment <- as.character(data2$Fleet.segment)

  data2 <- data2[data2$CPC %in% MS & data2$GSA %in% GSA & data2$Reference.year %in% yrs, ]
  # Data visualization
  # str(data1)
  # str(data2)

  if (nrow(data2) == 0) {
    message(paste0("No reference values for the following years: ", paste(yrs, collapse = ", "), "."))
  } else {
    if (nrow(level_fac_dat2) > 0 & nrow(level_fac_dat1) > 0) {


      # creation of variable ID by concatenating GSA and Fleet.segment and year for data frame 1 and dataframe 2
      # creation of variable ID for data frame1
      data1$ID <- paste(data1$GSA, "_", data1$Segment, "_", data1$Reference_Year)
      # data1$ID=as.factor(data1$ID)

      # creation of variable ID for data frame2
      data2$ID <- paste(data2$GSA, "_", data2$Fleet.segment, "_", data2$Reference.year)
      # data2$ID=as.factor(data2$ID)

      # Creation of data frame mixing the information from the two dataframes

      level_fac_dat1 <- data.frame(x = as.character(unique(data1$ID)))
      level_fac_dat1$presence <- "presence"
      level_fac_dat2 <- data.frame(y = as.character(unique(data2$ID)))

      # merge expected codes with obesrved codes
      df_merge <- merge(level_fac_dat2, level_fac_dat1, by.x = "y", by.y = "x", all.x = TRUE)

      # prepare a data frame with missing codes
      absent <- df_merge[is.na(df_merge$presence), ]
      absent <- strsplit(absent$y, " _ ")
      absent <- as.data.frame(do.call(rbind, absent))
      colnames(absent) <- c("GSA", "fleet_segment", "year")

      return(absent)
    }
  }
}
