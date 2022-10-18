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
#' 5) Sum of landings by Year, Species, foCatEu5, foCatEu6;
#' 6) Sum of landing value by Year, Species, foCatEu5, foCatEu6.
#' @export
#' @examples RCG_check_CL(data_exampleCL, MS = "COUNTRY1", GSA = "GSA99", SP = "Parapenaeus longirostris")
#' @importFrom utils globalVariables
#' @importFrom ggplot2 aes ggplot geom_line geom_point facet_grid
#' @importFrom stats aggregate

RCG_check_CL <- function(data, MS, GSA, SP, verbose = TRUE) {
  if (FALSE) {
    data <- data_exampleCL
    SP <- "Parapenaeus longirostris"
    MS <- "COUNTRY1"
    GSA <- "GSA99"
    RCG_check_CL(data_exampleCL, MS, GSA, SP)
  }

  area <- foCatEu5 <- harbour <- landCtry <- landValue <- landWt <- month <- quarter <- rect <-
  subRect <- taxon <- vslFlgCtry <- year <- Year <- foCatEu6 <- Sum_Landings <- Species <- NULL

  data <- data[as.character(data$taxon) %in% SP & data$vslFlgCtry %in% MS & data$area %in% GSA, ]

  if (nrow(data) == 0) {
    if (verbose) {
      message(paste0("No data available for the selected species (", SP, ")"))
    }
  } else if (nrow(data) > 0) {
    if (any(is.na(data$landWt))) {
      if (verbose) {
        message("Na values included in the 'landWt' were removed")
      }
      data <- data[!is.na(data$landWt), ]
    }

    # temp_covL <- aggregate(data$landWt, by = list(data$year, data$quarter, data$month), FUN = "sum")
    # colnames(temp_covL) <- c("Year", "Quarter", "Month", "Sum_Landings")
    suppressMessages(temp_covL <-  data.frame(data %>% group_by(year,quarter,month) %>% summarise(Sum_Landings=sum(landWt,na.rm=TRUE))))
    colnames(temp_covL) <- c("Year", "Quarter", "Month", "Sum_Landings")


    # temp_covLV <- aggregate(data$landValue, by = list(data$year, data$quarter, data$month), FUN = "sum")
    # colnames(temp_covLV) <- c("Year", "Quarter", "Month", "Sum_LandingsValue")
    suppressMessages(temp_covLV <- data.frame(data %>% group_by(year,quarter,month) %>% summarise(Sum_LandingsValue=sum(landValue, na.rm=TRUE))))
    colnames(temp_covLV) <- c("Year", "Quarter", "Month", "Sum_LandingsValue")



    if (length(which(is.na(data$landCtry))) > 0) data[which(is.na(data$landCtry)), ]$landCtry <- NA
    if (length(which(is.na(data$vslFlgCtry))) > 0) data[which(is.na(data$vslFlgCtry)), ]$vslFlgCtry <- NA
    if (length(which(is.na(data$rect))) > 0) data[which(is.na(data$rect)), ]$rect <- NA
    if (length(which(is.na(data$subRect))) > 0) data[which(is.na(data$subRect)), ]$subRect <- NA

    # spat_covLV <- aggregate(data$landValue, by = list(data$landCtry, data$vslFlgCtry, data$area, data$rect, data$subRect, data$harbour), FUN = "sum")
    # colnames(spat_covLV) <- c("LandCtry", "VslFlgCtry", "Area", "Rect", "SubRect", "Harbour", "Sum_LandingsValue")

    spat_covLV <- suppressMessages( data.frame(data %>% group_by(landCtry,vslFlgCtry,area,rect,subRect,harbour) %>% summarise(Sum_LandingsValue=sum(landValue ,na.rm=TRUE))))
    colnames(spat_covLV) <- c("LandCtry", "VslFlgCtry", "Area", "Rect", "SubRect", "Harbour", "Sum_LandingsValue")




    # spat_covL <- aggregate(data$landWt, by = list(data$landCtry, data$vslFlgCtry, data$area, data$rect, data$subRect, data$harbour), FUN = "sum")
    # colnames(spat_covL) <- c("LandCtry", "VslFlgCtry", "Area", "Rect", "SubRect", "Harbour", "Sum_Landings")
    spat_covL <- suppressMessages(spat_covL <- data.frame(data %>% group_by(landCtry,vslFlgCtry,area,rect,subRect,harbour) %>% summarise(Sum_Landings=sum(landWt,na.rm=TRUE))))
    colnames(spat_covL) <- c("LandCtry", "VslFlgCtry", "Area", "Rect", "SubRect", "Harbour", "Sum_Landings")

    if (length(which(is.na(data$foCatEu5))) > 0) data[which(is.na(data$foCatEu5)), ]$foCatEu5 <- NA
    if (length(which(is.na(data$foCatEu6))) > 0) data[which(is.na(data$foCatEu6)), ]$foCatEu6 <- NA

    # spe_cov_L <- aggregate(data$landWt, by = list(data$year, data$taxon, data$foCatEu5, data$foCatEu6), FUN = "sum")
    # colnames(spe_cov_L) <- c("Year", "Species", "foCatEu5", "foCatEu6", "Sum_Landings")
    suppressMessages(spe_cov_L <- data.frame(data %>% group_by(year,taxon,foCatEu5,foCatEu6) %>% summarise(Sum_Landings=sum(landWt,na.rm=TRUE))))
    colnames(spe_cov_L) <- c("Year", "Species", "foCatEu5", "foCatEu6", "Sum_Landings")


    spe_cov_LV <- aggregate(data$landValue, by = list(data$year, data$taxon, data$foCatEu5, data$foCatEu6), FUN = "sum")
    colnames(spe_cov_LV) <- c("Year", "Species", "foCatEu5", "foCatEu6", "Sum_LandingsValue")

    suppressMessages(spe_cov_LV <- data.frame(data %>% group_by(year,taxon,foCatEu5,foCatEu6) %>% summarise(Sum_LandingsValue = sum(landValue, na.rm=TRUE))))
    colnames(spe_cov_LV) <- c("Year", "Species", "foCatEu5", "foCatEu6", "Sum_LandingsValue")

    # Checks_CL=list()

    p <- ggplot(data = spe_cov_L, aes(x = Year, y = Sum_Landings, color = foCatEu6)) +
      geom_line(stat = "identity") +
      geom_point(stat = "identity") +
      facet_grid(scales = "free_y") +
      ggtitle(SP) +
      ylab("Sum Landings")
    # print(p)


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
