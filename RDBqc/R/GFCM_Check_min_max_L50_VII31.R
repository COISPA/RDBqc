#'  Comparison between min/max L50 observed for each species and sex with theoretical values
#'
#' @description Function to verify the consistency of L50 reported in the TaskVII.3.1 table with the theoretical values reported in the minmaxLtaskVII31 table. The function allows to identify the records in which the observed L50 are greater or lower than the expected ones.
#' @param data GFCM Task VII.3.1 table
#' @param tab_L50 Theoretical values of min/max L50 for each species and sex
#' @param MS member state code
#' @param GSA GSA code
#' @return The function returns a table with the comparison between min/max L50 observed for each species and sex with theoretical values.
#' @export
#'
#' @examples check_minmaxl50_TaskVII.3.1(task_vii31, minmaxLtaskVII31, MS = "ITA", GSA = "19")
check_minmaxl50_TaskVII.3.1 <- function(data, tab_L50, MS, GSA) {
  if (FALSE) {
    data <- vii31
    tab_L50 <- minmaxLtaskVII31
  }
  # Creation of Pivot for calculation of min/max depending of species

  data <- data[data$CPC %in% MS & data$GSA %in% GSA, ]

  if (nrow(data) > 0) {
    data$SpeciesXSex <- paste(data$Species, data$Sex)
    pivot_min <- with(data, tapply(L50, SpeciesXSex, min))
    # pivot_min #pivot min
    pivot_max <- with(data, tapply(L50, SpeciesXSex, max))
    # pivot_max #pivot max

    # Creation of the final data frame
    Check_species_min <- as.data.frame(pivot_min)
    Check_species_max <- as.data.frame(pivot_max)
    Check_species_final <- Check_species_min
    Check_species_final$pivot_max <- Check_species_max$pivot_max
    names(Check_species_final) <- c("min", "max")
    Check_species_final$SpeciesXSex <- as.factor(names(pivot_min))
    # str(Check_species_final)
    # Creation of colum for merging and merging
    tab_L50$SpeciesXSex <- paste(tab_L50$Species, tab_L50$Sex)
    data_merge <- merge(Check_species_final, tab_L50, by = "SpeciesXSex", all.x = TRUE)

    if (nrow(data_merge[is.na(data_merge$Species), ]) > 0) {
      sp <- as.character(unique(data_merge[is.na(data_merge$Species), "SpeciesXSex"]))
      message(paste0("No reference range values for the following species-sex combinations: ", paste(sp, collapse = ", "), ". NA values will be removed from the analysis"))
      data_merge <- data_merge[!is.na(data_merge$Species), ]
    }

    if (nrow(data_merge) > 0) {

      # str(data_merge)

      # Creation of dataframe
      dataframe_check <- data.frame(
        data_merge$Species, data_merge$Sex,
        data_merge$min, data_merge$max, data_merge$minL50, data_merge$maxL50
      )
      names(dataframe_check) <- c("Species", "Sex", "min_observed", "max_observed", "min_theoretical", "max_theoretical")
      # str(dataframe_check)

      # Creation of warning for min
      for (i in 1:length(dataframe_check$min_observed)) {
        if (dataframe_check$min_theoretical[i] >= dataframe_check$min_observed[i]) {
          dataframe_check$check_min[i] <- "Warning"
        } else {
          dataframe_check$check_min[i] <- ""
        }
      }

      # Creation of warning for max
      for (i in 1:length(dataframe_check$max_observed)) {
        if (dataframe_check$max_theoretical[i] <= dataframe_check$max_observed[i]) {
          dataframe_check$check_max[i] <- "Warning"
        } else {
          dataframe_check$check_max[i] <- ""
        }
      }

      # Extraction of data in excell file
      # write.table(dataframe_check, file="C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA\\checkminmaxL50.csv", quote=TRUE,
      #             dec=".", row.names=FALSE, col.names=TRUE, sep =";")

      return(dataframe_check)
    }
  }
}
