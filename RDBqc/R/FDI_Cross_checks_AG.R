#' Cross check between FDI tables A and G
#'
#' @description The function checks the possible data inconsistency between landings and effort.
#' @param data1 FDI table A catch
#' @param data2 FDI table G effort
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a table where all the miss matches between landings and effort are shown.
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_cross_checks_AG(data1 = fdi_a_catch, data2 = fdi_g_effort)
#' FDI_cross_checks_AG(fdi_a_catch, fdi_g_effort)
#' @import tidyverse


FDI_cross_checks_AG <- function(data1, data2, verbose = FALSE) {
  country <- fishing_tech <- gear_type <- mesh_size_range <- metier <- quarter <- sub_region <- target_assemblage <- totfishdays <- totseadays <- totwghtlandg <- vessel_length <- year <- NULL

  if (nrow(data1) != 0 & nrow(data2) != 0) {
    data1[1:19][data1[1:19] == "NK" | data1[1:19] == "NA" | is.na(data1[1:19])] <- NA
    data1[20:22][is.na(data1[20:22])] <- 0

    data2[1:15][data2[1:15] == "NK" | data2[1:15] == "NA" | is.na(data2[1:15])] <- NA
    data2[16, 19][is.na(data2[16, 19])] <- 0

    suppressMessages(data1 <- data1 %>% filter(!is.na(country) & !is.na(year)))
    suppressMessages(data2 <- data2 %>% filter(!is.na(country) & !is.na(year)))

    suppressMessages(data1 <- data1 %>%
      group_by(country, year, quarter, vessel_length, fishing_tech, gear_type, target_assemblage, mesh_size_range, metier, sub_region) %>%
      summarize(totwghtlandg = sum(as.numeric(totwghtlandg), na.rm = TRUE)))

    suppressMessages(data2 <- data2 %>%
      group_by(country, year, quarter, vessel_length, fishing_tech, gear_type, target_assemblage, mesh_size_range, metier, sub_region) %>%
      summarize(totfishdays = sum(as.numeric(totfishdays), na.rm = TRUE), totseadays = sum(as.numeric(totseadays), na.rm = TRUE)))

    suppressMessages(data <- full_join(data1, data2))
    data <- as.data.frame(data)
    data$Data <- NA
    summary(data)

    # check <- function(data){
    #     data[data[11]>0 & data[12]>0 & data[13]>0, 14] <- "no mismatch"
    #     data[data[11]==0 & data[12]>0 & data[13]>0, 14] <- "no landings, only effort in fishing days and sea days available"
    #     data[data[11]==0 & data[12]==0 & data[13]>0, 14] <- "no landings, only effort in sea days available"
    #     data[data[11]==0 & data[12]>0 & data[13]==0, 14] <- "no landings, only effort in fishing days available"
    #     data[data[11]==0 & data[12]==0 & data[13]==0, 14]  "landings and effort data not available"
    #     return (data)
    # }

    i <- 33
    for (i in 1:nrow(data)) {
      if (data$totwghtlandg[i] > 0 & data$totfishdays[i] > 0 & data$totseadays[i] > 0) {
        data$Data[i] <- "no mismatch"
      }
      if (data$totwghtlandg[i] > 0 & data$totfishdays[i] == 0 & data$totseadays[i] == 0) {
        data$Data[i] <- "only landings available"
      }
      if (data$totwghtlandg[i] > 0 & data$totfishdays[i] == 0 & data$totseadays[i] > 0) {
        data$Data[i] <- "landings and sea days available"
      }
      if (data$totwghtlandg[i] > 0 & data$totfishdays[i] > 0 & data$totseadays[i] == 0) {
        data$Data[i] <- "landings and fishing days available"
      }
      if (data$totwghtlandg[i] == 0 & data$totfishdays[i] > 0 & data$totseadays[i] > 0) {
        data$Data[i] <- "no landings, only effort in fishing days and sea days available"
      }
      if (data$totwghtlandg[i] == 0 & data$totfishdays[i] == 0 & data$totseadays[i] > 0) {
        data$Data[i] <- "no landings, only effort in sea days available"
      }
      if (data$totwghtlandg[i] == 0 & data$totfishdays[i] > 0 & data$totseadays[i] == 0) {
        data$Data[i] <- "no landings, only effort in fishing days available"
      }
      if (data$totwghtlandg[i] == 0 & data$totfishdays[i] == 0 & data$totseadays[i] == 0) {
        data$Data[i] <- "landings and effort data not available"
      }
    }

    data <- data[data$Data != "no mismatch", ]

    output <- as.data.frame(data)
    if (verbose) {
      message("summary_table")
    }
  } else {
    if (verbose) {
      message(paste("Missing data in at least one of the two tables provided"))
    }
    output <- NULL
  }
  return(output)
}
