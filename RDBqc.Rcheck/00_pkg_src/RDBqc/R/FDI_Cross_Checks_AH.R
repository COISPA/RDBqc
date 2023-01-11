#' Cross check between FDI tables A and H
#'
#' @description The function checks the possible data inconsistency between landings in table A and spatial landings in table H.
#' @param data1 FDI catch table A
#' @param data2 FDI spatial landings table H
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list with two tables. In the first table all the mismatches between landings in table A and spatial landings in table H are shown, in the second table the comparison between total landings of table A and total spatial landings in table H is shown.
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_cross_checks_AH(data1 = fdi_a_catch, data2 = fdi_h_spatial_landings)
#' @import tidyverse

FDI_cross_checks_AH <- function(data1, data2, verbose = FALSE) {
  Data <- country <- cscode <- fishing_tech <- gear_type <- sub_region <- totwghtlandg <- ttwghtl <- vessel_length <- year <- NULL

  if (nrow(data1) != 0 & nrow(data2) != 0) {
    data1[1:19][data1[1:19] == "NK" | data1[1:19] == "NA" | is.na(data1[1:19])] <- NA
    data1[20:22][is.na(data1[20:22])] <- 0

    data2[1:20][data2[1:20] == "NK" | data2[1:20] == "NA" | is.na(data2[1:20])] <- NA
    data2[21, 22][is.na(data2[21, 22])] <- 0

    suppressMessages(data1 <- data1 %>% filter(!is.na(country) & !is.na(year)))
    suppressMessages(data2 <- data2 %>% filter(!is.na(country) & !is.na(year)))



    # data1[, c(2, 3, 11, 16:18, 20:22)] <- as.data.frame(lapply(data1[, c(2, 3, 11, 16:18, 20:22)], as.numeric))
    # data2[, c(2, 3, 21, 22)] <- as.data.frame(lapply(data2[, c(2, 3, 21, 22)], as.numeric))


    suppressMessages(data1 <- data1 %>%
      group_by(country, year, vessel_length, fishing_tech, gear_type, sub_region) %>%
      summarize(totwghtlandg = sum(as.numeric(totwghtlandg), na.rm = TRUE)))

    suppressMessages(data2 <- data2 %>%
      group_by(country, year, vessel_length, fishing_tech, gear_type, sub_region) %>%
      summarize(ttwghtl = sum(as.numeric(totwghtlandg), na.rm = TRUE)))

    suppressMessages(data <- full_join(data1, data2))
    data$Data <- NA
    data[is.na(data$totwghtlandg), "totwghtlandg"] <- 0
    data[is.na(data$ttwghtl), "ttwghtl"] <- 0

    for (i in 1:nrow(data)) {
      if (data$totwghtlandg[i] > 0 & data$ttwghtl[i] > 0) {
        data$Data[i] <- "landings in table A and in table H are available"
      } else {
        if (data$totwghtlandg[i] == 0 & data$ttwghtl[i] > 0) {
          data$Data[i] <- "landings in tabel A not avalilable and landings in table H available"
        } else {
          if (data$totwghtlandg[i] > 0 & data$ttwghtl[i] == 0) {
            data$Data[i] <- "landings in table A are available and landings in table H are not available"
          }
        }
      }
    }

    data_miss <- data %>%
      filter(Data %in% c("landings in tabel A not avalilable and landings in table H available", "landings in table A are available and landings in table H are not available"))

    suppressMessages(tot_land_data1 <- data1 %>%
      group_by(year, country, sub_region) %>%
      summarize(totwghtlandg = sum(as.numeric(totwghtlandg), na.rm = TRUE)))

    suppressMessages(tot_land_data2 <- data2 %>%
      group_by(year, country, sub_region) %>%
      summarize(ttwghtl = sum(as.numeric(ttwghtl), na.rm = TRUE)))

    suppressMessages(TOT <- full_join(tot_land_data1, tot_land_data2))
    colnames(TOT)[c(4, 5)] <- c("land_table_A", "land_table_H")

    output <- list(as.data.frame(data_miss), as.data.frame(TOT))
    names(output) <- c("summary_table_missing_values", "total_land_Table_A_vs_Table_H")
  } else {
    if (verbose) {
      message("No data available in at least one of the two tables provided")
    }
    output <- NULL
  }
  return(output)
}
