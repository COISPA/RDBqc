#'  Comparison between min/max observed for each species with theoretical values
#'
#' @description Function to verify the consistency of the lengths reported in the TaskVII.2 table with the theoretical values reported in the minmaxLtaskVII2 table. The function allows to identify the records in which the observed lengths are greater or lower than the expected ones.
#' @param data GFCM Task II.2 table
#' @param tab_length Theoretical values of min/max length for each species
#' @param MS member state code
#' @param GSA GSA code
#' @return The function returns a table with the comparison between min/max lengths observed for each species with theoretical values.
#' @export
#'
#' @examples check_minmaxl_TaskVII.2(task_vii2, minmaxLtaskVII2, MS = "ITA", GSA = "18")
check_minmaxl_TaskVII.2 <- function(data, tab_length, MS, GSA) {
  data <- data[data$CPC %in% MS & data$GSA %in% GSA, ]

  if (nrow(data) == 0) {
    message("No data for the selected Country and GSA combination. ")
  } else {

    # Creation of Pivot for calculation of min/max depending of species
    pivot_min <- with(data, tapply(Length, Species, min))
    # pivot_min #pivot min
    pivot_max <- with(data, tapply(Length, Species, max))
    # pivot_max #pivot max

    # Creation of the final data frame for observed values
    Check_species_min <- as.data.frame(pivot_min)
    Check_species_max <- as.data.frame(pivot_max)
    Check_species_final <- Check_species_min
    Check_species_final$pivot_max <- Check_species_max$pivot_max
    names(Check_species_final) <- c("min", "max")
    Check_species_final$Species <- as.character(names(pivot_min))
    # str(Check_species_final)
    ##
    # Creation of colum for merging and merging with fixed values
    data_merge <- merge(Check_species_final, tab_length, by = "Species", all.x = TRUE)
    # str(data_merge)

    if (nrow(data_merge[is.na(data_merge$min.y), ]) > 0 | nrow(data_merge[is.na(data_merge$max.y), ]) > 0) {
      sp <- as.character(unique(c(data_merge[is.na(data_merge$min.y), "Species"], data_merge[is.na(data_merge$max.y), "Species"])))
      message(paste0("No reference range values for the following species: ", paste(sp, collapse = ", "), ". NA values will be removed from the analysis"))
      data_merge <- data_merge[!is.na(data_merge$min.y) & !is.na(data_merge$max.y), ]
    }

    if (nrow(data_merge) > 0) {

      # Creation of final dataframe
      dataframe_check <- data.frame(
        data_merge$Species,
        data_merge$min.x, data_merge$max.x, data_merge$min.y, data_merge$max.y
      )
      names(dataframe_check) <- c("Species", "min_observed", "max_observed", "min_theoretical", "max_theoretical")
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

      # Final data frame created
      # dataframe_check

      # Extraction of data in excell file
      # write.table(dataframe_check, file="C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA\\checkminmax.csv", quote=TRUE,
      #             dec=".", row.names=FALSE, col.names=TRUE, sep =";")
      return(dataframe_check)
    }
  }
}
