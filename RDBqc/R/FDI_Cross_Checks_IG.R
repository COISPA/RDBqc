#' Cross check between FDI tables I and G
#'
#' @description The function checks the possible data inconsistency between spatial effort in table I and effort in table G.
#' @param data1 FDI spatial effort in table I
#' @param data2 FDI effort table G
#' @param verbose boolean. If TRUE a message is printed.
#' @return The function returns a list with two tables. In the first table all the mismatches between spatial effort in table I and effort in table G are shown, in the second table the comparison between total spatial effort of table I and total effort in table G is shown.
#' @export
#' @author Andrea Pierucci <pierucci@@coispa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples FDI_cross_checks_IG(data1 = fdi_i_spatial_effort, data2 = fdi_g_effort)
#' @import tidyverse

FDI_cross_checks_IG <- function(data1, data2, verbose = FALSE) {
  Data <- country <- fishing_tech <- gear_type <- sub_region <- totfishdays <- totfishdays_data1 <- totfishdays_data2 <- vessel_length <- year <- NULL

  if (nrow(data1) != 0 & nrow(data2) != 0) {

    ### adaptation for new FDI table structure ------
    colnames(data1) <- tolower(colnames(data1))
    if ("latitude" %in% colnames(data1)) {
      colnames(data1)[which(colnames(data1)=="latitude")] <- "rectangle_lat"
    }
    if ("longitude" %in% colnames(data)) {
      colnames(data1)[which(colnames(data1)=="longitude")] <- "rectangle_lon"
    }
    if ("metier_7" %in% colnames(data1)) {
      data1 <- data1[ , -(which(colnames(data1)%in% "metier_7"))]
    }
    #--------------------
    colnames(data2) <- tolower(colnames(data2))
    if ("latitude" %in% colnames(data2)) {
      colnames(data2)[which(colnames(data2)=="latitude")] <- "rectangle_lat"
    }
    if ("longitude" %in% colnames(data2)) {
      colnames(data)[which(colnames(data)=="longitude")] <- "rectangle_lon"
    }
    if ("metier_7" %in% colnames(data2)) {
      data2 <- data2[ , -(which(colnames(data2)%in% "metier_7"))]
    }
    #-----------------------------------------------

    data1[1:19][data1[1:19] == "NK" | data1[1:19] == "NA" | is.na(data1[1:19])] <- NA
    data1[20][is.na(data1[20])] <- 0

    data2[1:15][data2[1:15] == "NK" | data2[1:15] == "NA" | is.na(data2[1:15])] <- NA
    data2[19][is.na(data2[19])] <- 0

    suppressMessages(data1 <- data1 %>% filter(!is.na(country) & !is.na(year)))
    suppressMessages(data2 <- data2 %>% filter(!is.na(country) & !is.na(year)))

    (data1 <- data1[, c(2, 3:11, 14, 15, 20)])
    (data2 <- data2[, c(2:11, 14, 15, 19)])
    colnames(data1) <- colnames(data2)

    suppressMessages(data1 <- data1 %>%
      group_by(year, vessel_length, fishing_tech, gear_type, sub_region) %>%
      summarize(totfishdays_data1 = sum(as.numeric(totfishdays))))

    suppressMessages(data2 <- data2 %>%
      group_by(year, vessel_length, fishing_tech, gear_type, sub_region) %>%
      summarize(totfishdays_data2 = sum(as.numeric(totfishdays))))

    suppressMessages(data <- full_join(data1, data2))
    data$Data <- NA

    for (i in 1:nrow(data)) {
      if ((data$totfishdays_data1[i] > 0 & !is.na(data$totfishdays_data1[i])) & (data$totfishdays_data2[i] > 0 & !is.na(data$totfishdays_data2[i]))) {
        data$Data[i] <- "spatial effort in table I and in table G are both available"
      } else {
        if ((data$totfishdays_data1[i] == 0 | is.na(data$totfishdays_data1[i])) & (data$totfishdays_data2[i] > 0 & !is.na(data$totfishdays_data2[i]))) {
          data$Data[i] <- "spatial effort in table I is not avalilable and effort in table G is available"
        } else {
          if ((data$totfishdays_data1[i] > 0 & !is.na(data$totfishdays_data1[i])) & (data$totfishdays_data2[i] == 0 | is.na(data$totfishdays_data2[i]))) {
            data$Data[i] <- "spatial effort in table I are available and effort in table G are not available"
          }
        }
      }
    }

    data_miss <- data %>%
      filter(Data %in% c("spatial effort in table I is not avalilable and effort in table G is available", "spatial effort in table I are available and effort in table G are not available"))
    suppressMessages(tot_land_data1 <- data1 %>%
      group_by(year, sub_region) %>%
      summarize(totfishdays_data1 = sum(as.numeric(totfishdays_data1))))

    suppressMessages(tot_land_data2 <- data2 %>%
      group_by(year, sub_region) %>%
      summarize(totfishdays_data2 = sum(as.numeric(totfishdays_data2))))

    suppressMessages(TOT <- full_join(tot_land_data1, tot_land_data2))
    colnames(TOT)[c(3, 4)] <- c("spatial_effort_table_I", "effort_table_G")

    output <- list(as.data.frame(data_miss), as.data.frame(TOT))
    names(output) <- c("summary_table_missing_values", "total_effort_table_I_VS_table_G")
  } else {
    if (verbose) {
      message("No data available in at least one of the two table selected")
    }
    output <- NULL
  }
  return(output)
}
