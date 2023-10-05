#' Quality checks on CL RCG table
#'
#' @param data Landing table in RCG CL format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks CL tables for temporal, spatial, species and metier coverage
#' @return The output is a list of 6 data frames:
#' 1) Sum of Landings by year, quarter and month;
#' 2) Sum of Landing value by year, quarter and month;
#' 3) Sum of landings by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;
#' 4) Sum of landing value by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;
#' 5) Sum of landings by Year, Species, fishing_activity_category_national, fishing_activity_category_eu_l6;
#' 6) Sum of landing value by Year, Species, fishing_activity_category_national, fishing_activity_category_eu_l6.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples RCG_check_CL(data_exampleCL, MS = "COUNTRY1", GSA = "GSA99", SP = "Parapenaeus longirostris")
#' @importFrom utils globalVariables
#' @importFrom ggplot2 aes ggplot geom_line geom_point facet_grid
#' @importFrom stats aggregate

RCG_check_CL <- function(data, MS, GSA, SP, verbose = TRUE) {
  area <- harbour <- flag_country <- official_landings_value <- official_landings_weight <- month <- quarter <- year <- Year <- fishing_activity_category_national <- fishing_activity_category_eu_l6 <- Sum_Landings <- species <- NULL
  data <- data[as.character(data$species) %in% SP & data$flag_country %in% MS & data$area %in% GSA, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(data) > 0) {
    if (any(is.na(data$official_landings_weight))) {
      if (verbose) {
        message("Na values included in the 'official_landings_weight' were removed")
      }
      data <- data[!is.na(data$official_landings_weight), ]
    }

    suppressMessages(temp_covL <- data.frame(data %>% group_by(year, quarter, month) %>% summarise(Sum_Landings = sum(as.numeric(official_landings_weight), na.rm = TRUE))))
    colnames(temp_covL) <- c("Year", "Quarter", "Month", "Sum_Landings")

    suppressMessages(temp_covLV <- data.frame(data %>% group_by(year, quarter, month) %>% summarise(Sum_LandingsValue = sum(as.numeric(official_landings_value), na.rm = TRUE))))
    colnames(temp_covLV) <- c("Year", "Quarter", "Month", "Sum_LandingsValue")

    if (length(which(is.na(data$flag_country))) > 0) data[which(is.na(data$flag_country)), ]$flag_country <- NA

    spat_covLV <- suppressMessages(data.frame(data %>% group_by(flag_country, area, harbour) %>% summarise(Sum_LandingsValue = sum(as.numeric(official_landings_value), na.rm = TRUE))))
    colnames(spat_covLV) <- c("Country", "Area", "Harbour", "Sum_LandingsValue")

    spat_covL <- suppressMessages(spat_covL <- data.frame(data %>% group_by(flag_country, area, harbour) %>% summarise(Sum_Landings = sum(as.numeric(official_landings_weight), na.rm = TRUE))))
    colnames(spat_covL) <- c("Country", "Area", "Harbour", "Sum_Landings")

    if (length(which(is.na(data$fishing_activity_category_national))) > 0) data[which(is.na(data$fishing_activity_category_national)), ]$fishing_activity_category_national <- NA
    if (length(which(is.na(data$fishing_activity_category_eu_l6))) > 0) data[which(is.na(data$fishing_activity_category_eu_l6)), ]$fishing_activity_category_eu_l6 <- NA

    suppressMessages(spe_cov_L <- data.frame(data %>% group_by(year, species, fishing_activity_category_national, fishing_activity_category_eu_l6) %>% summarise(Sum_Landings = sum(as.numeric(official_landings_weight), na.rm = TRUE))))
    colnames(spe_cov_L) <- c("Year", "Species", "fishing_activity_category_national", "fishing_activity_category_eu_l6", "Sum_Landings")

    spe_cov_LV <- aggregate(as.numeric(data$official_landings_value), by = list(data$year, data$species, data$fishing_activity_category_national, data$fishing_activity_category_eu_l6), FUN = "sum")
    colnames(spe_cov_LV) <- c("Year", "Species", "fishing_activity_category_national", "fishing_activity_category_eu_l6", "Sum_LandingsValue")

    suppressMessages(spe_cov_LV <- data.frame(data %>% group_by(year, species, fishing_activity_category_national, fishing_activity_category_eu_l6) %>% summarise(Sum_LandingsValue = sum(as.numeric(official_landings_value), na.rm = TRUE))))
    colnames(spe_cov_LV) <- c("Year", "Species", "fishing_activity_category_national", "fishing_activity_category_eu_l6", "Sum_LandingsValue")

    p <- ggplot(data = spe_cov_L, aes(x = Year, y = Sum_Landings, color = fishing_activity_category_eu_l6)) +
      geom_line(stat = "identity") +
      geom_point(stat = "identity") +
      facet_grid(scales = "free_y") +
      ggtitle(SP) +
      ylab("Sum Landings")

    return(list(
      temp_covL,
      temp_covLV,
      spat_covL,
      spat_covLV,
      spe_cov_L,
      spe_cov_LV,
      p
    ))
  }
}
