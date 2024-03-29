#' Cross check between FDI tables J and G
#' @description The function checks the possible data inconsistency between the amount of vessels in table J capacity and the amount of vessels in table G.
#' @param data1 FDI capacity in table J
#' @param data2 FDI effort table G
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list with all the mismatches between number of vessels in table J and G.
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_cross_checks_JG(data1 = fdi_j_capacity, data2 = fdi_g_effort, verbose = TRUE)
#' FDI_cross_checks_JG(fdi_j_capacity, fdi_g_effort)
#' @import tidyverse

FDI_cross_checks_JG <- function(data1, data2, verbose = FALSE) {
  country <- principal_sub_region <- totves <- vessel_length <- year <- info <- NULL

  if (nrow(data1) != 0 & nrow(data2) != 0) {
    data1[1:7][data1[1:7] == "NK" | data1[1:7] == "NA" | is.na(data1[1:7])] <- NA
    data1[11][is.na(data1[11])] <- 0

    data2[1:15][data2[1:15] == "NK" | data2[1:15] == "NA" | is.na(data2[1:15])] <- NA
    data2[25][is.na(data2[25])] <- 0

    suppressMessages(data1 <- data1 %>% filter(!is.na(country) & !is.na(year)))
    suppressMessages(data2 <- data2 %>% filter(!is.na(country) & !is.na(year)))

    (data1 <- data1[, c(1, 2, 3, 7, 11)])
    (data2 <- data2[, c(1, 2, 4, 11, 25)])
    colnames(data2) <- colnames(data1)

    suppressMessages(data1 <- data1 %>%
      group_by(country, year, principal_sub_region, vessel_length) %>%
      summarize(total_vessels_tab_J = sum(as.numeric(totves), na.rm = TRUE)))

    suppressMessages(data2 <- data2 %>%
      group_by(country, year, principal_sub_region, vessel_length) %>%
      summarize(total_vessels_tab_G = sum(as.numeric(totves), na.rm = TRUE)))

    suppressMessages(data <- full_join(data1, data2))
    data$total_vessels_tab_J <- round(data$total_vessels_tab_J, digits = 0)
    data$total_vessels_tab_G <- round(data$total_vessels_tab_G, digits = 0)
    data$info <- NA

    for (i in 1:nrow(data)) {
      if (data$total_vessels_tab_J[i] == data$total_vessels_tab_G[i]) {
        data$info[i] <- "Table J and tabel G have the same amount of vessels"
      } else {
        if (data$total_vessels_tab_J[i] > data$total_vessels_tab_G[i]) {
          data$info[i] <- paste0("There are ", data$total_vessels_tab_J[i] - data$total_vessels_tab_G[i], " more vessels in table J than in table G")
        } else {
          if (data$total_vessels_tab_G[i] > data$total_vessels_tab_J[i]) {
            data$info[i] <- paste0("There are ", data$total_vessels_tab_G[i] - data$total_vessels_tab_J[i], " more vessels in table G than in table J")
          }
        }
      }
    }

    suppressMessages(data_miss <- data %>%
      filter(info != "Table J and tabel G have the same amount of vessels"))

    output <- data.frame(data_miss)
    if (verbose) {
      message("summary table of missing vessels")
    }
  } else {
    if (verbose) {
      message("No data available in at least one of the two tables provided")
    }
    output <- NULL
  }

  return(output)
}
