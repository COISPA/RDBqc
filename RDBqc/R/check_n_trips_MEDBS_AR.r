#' Cross check of number of trips between MED&BS catch table and AR Table 2.5
#'
#' @param MEDBS data frame containing MED&BS catch table
#' @param AR data frame containing Annual Report data
#' @param MS member state code
#' @param year Reference year for the analysis
#' @param OUT Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @description The function compares the number of trips reported in MED & BS data call catch table with the information reported in the table 2.5 ("Sampling plan biol") of the Annual Report.
#' The user have to define the two source tables as data frames in the \code{MEDBS} and \code{AR} parameters. The analysis should be constrained at the selected country level (\code{MS}) and at the selected \code{year}.
#' @return The function returns a data frame reporting the total number of trips related to catches, landings and discards conducted in the selected country and year. MED & BS data will be reported both as sum of the trips by year and as sum of the trips reported by quarter in the year.
#' @export check_n_trips_MEDBS_AR
#' @author Walter Zupa <zupa@@fondazionecoispa.org>
#' @import dplyr
#' @importFrom magrittr %>%

check_n_trips_MEDBS_AR <- function(MEDBS, AR, MS, year, OUT=FALSE, verbose = FALSE) {

  if (FALSE) {
    rm(list = ls(all.names = TRUE))
    # library(readxl)
    # library(dplyr)

    verbose = FALSE

    setwd("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\data")
    load("GSAs.rda")

    MS <- "ITA"
    # GSA <- NA # "GSA 18"
    year <- 2019

    # AR <- read_excel("AR_2019_template_2023_Tab_2.5.xlsx", sheet = "Table 2.5 Sampling plan biol", skip = 1)
    AR <- read_excel("table 2.5_MED&BS_ITA.xlsx", sheet = "Table 2.5 Sampling plan biol", skip = 1)
    AR <- data.frame(AR)
    AR <- AR[!AR$Sampling.frame.spatial.coverage %in% c("GSA 9, 10, 11, 16, 17, 18, 19"),]
    #---------------#
    med <- read.table("catch ita 2019.csv", sep = ";", header = TRUE)
    med <- med[, c(1:20)]

    check_n_trips_MEDBS_AR(MEDBS, AR, MS="ITA",year=2019,OUT=TRUE,verbose=TRUE)
  } # if (FALSE)

  Sampling.frame.spatial.coverage <- Implementation.year <- Achieved.number.of.PSUs.in.the.implementation.year <- country <- area <- metier <- no_samples_catch <- trips_year <- no_samples_landings <- no_samples_discards <- quarter <- trips_quarters <- Country <- Year <- MEDBS_by_Year_Catch <- MEDBS_by_Year_Landings <- MEDBS_quarters_Discards <- MEDBS_by_Year_Discards <- MEDBS_quarters_Catches <- MEDBS_quarters_Landings <- NULL

  #----------
  GSAs <- GSAs[GSAs$COUNTRY == MS, ]
  AR <- AR[AR$MS == MS, ]
  AR <- AR[AR$Implementation.year == year, ]
  AR <- AR[AR$Sampling.scheme.type == "Commercial fishing trip", ]
  AR <- AR[tolower(AR$PSU.type) %in% c("fishing trip","commercial fishing trip","trip"), ]
  AR <- AR[!is.na(AR$Region) & tolower(AR$Region) == tolower("Mediterranean and Black Sea"), ]
  AR[AR$Sampling.frame.spatial.coverage =="GSA11", "Sampling.frame.spatial.coverage"] <- "GSA 11"
  GSA <- unique(AR$Sampling.frame.spatial.coverage)

  if (all(!is.na(GSA)) & all(GSA %in% paste0("GSA",GSAs$GSA))) {
    AR <- AR[AR$Sampling.frame.spatial.coverage %in% GSA, ]
    g <- as.numeric(substr(AR$Sampling.frame.spatial.coverage,4,5))
    g <- paste("GSA",g)

    estimation <- "GSA"
  } else if (all(!is.na(GSA)) & all(GSA %in% paste0("GSA ",GSAs$GSA))) {
    AR <- AR[AR$Sampling.frame.spatial.coverage %in% GSA, ]
    g <- as.numeric(substr(AR$Sampling.frame.spatial.coverage,5,6))
    g <- paste("GSA",g)

    estimation <- "GSA"
  } else if (all(!is.na(GSA)) & all(GSA %in% paste0("GSA ",as.numeric(GSAs$GSA)))) {
    AR <- AR[AR$Sampling.frame.spatial.coverage %in% GSA, ]

    estimation <- "GSA"
  } else if (all(!is.na(GSA)) & all(GSA %in% paste0("GSA",as.numeric(GSAs$GSA)))) {
    AR <- AR[AR$Sampling.frame.spatial.coverage %in% GSA, ]
    g <- as.numeric(substr(AR$Sampling.frame.spatial.coverage,4,5))
    g <- paste("GSA",g)

    estimation <- "GSA"
  } else {
    estimation <- "COUNTRY"
  }

  AR <- AR[!is.na(AR$Achieved.number.of.PSUs.in.the.implementation.year),]

  #----------

    med <- med[med$country == MS, ]
    med <- med[med$year == year, ]

  #----------

  if (nrow(AR) > 0 & nrow(med) > 0) {

    #-------------------
    # ANNUAL REPORT data
    #-------------------
      if (estimation == "GSA") {

        AR1 <- suppressMessages(
          AR %>%
            group_by(MS, Sampling.frame.spatial.coverage, Implementation.year) %>%
            summarise(trips = sum(Achieved.number.of.PSUs.in.the.implementation.year, na.rm = TRUE))
        )
        colnames(AR1) <- c("Country", "Area", "Year", "Trips")

      }

      if (estimation == "COUNTRY") {

        AR1 <- suppressMessages(
          AR %>%
            group_by(MS, Implementation.year) %>%
            summarise(trips = sum(Achieved.number.of.PSUs.in.the.implementation.year, na.rm = TRUE))
        )
        colnames(AR1) <- c("Country", "Year", "Trips")

      }

    #--------------------
    # MED & BS catch data
    #--------------------
    med$metier <- paste(med$gear, med$fishery, med$mesh_size_range, med$vessel_length, sep = "_")
    # med <- med[med$no_samples_catch != -1 , ]

    ### table by year
    # Catches
    med_metier_year <- suppressMessages(
        med[med$quarter == -1 & med$no_samples_catch != -1, ] %>%
      group_by(country, area, year, metier) %>%
      summarise(trips_year = max(no_samples_catch))
    )

    med_year <- suppressMessages(
      med_metier_year %>%
        group_by(country, area, year) %>%
        summarise(trips = sum(trips_year, na.rm=TRUE))
    )
    colnames(med_year) <- c("Country", "Area", "Year", "MEDBS_by_Year_Catch")

    # Landings
    med_metier_year_land <- suppressMessages(
      med[med$quarter == -1 & med$no_samples_landings != -1, ] %>%
        group_by(country, area, year, metier) %>%
        summarise(trips_year = max(no_samples_landings))
    )

    med_year_land <- suppressMessages(
      med_metier_year_land %>%
        group_by(country, area, year) %>%
        summarise(trips = sum(trips_year, na.rm=TRUE))
    )
    colnames(med_year_land) <- c("Country", "Area", "Year", "MEDBS_by_Year_Landings")

    # Discards
    med_metier_year_disc <- suppressMessages(
      med[med$quarter == -1 & med$no_samples_discards != -1, ] %>%
        group_by(country, area, year, metier) %>%
        summarise(trips_year = max(no_samples_discards))
    )

    med_year_disc <- suppressMessages(
      med_metier_year_disc %>%
        group_by(country, area, year) %>%
        summarise(trips = sum(trips_year, na.rm=TRUE))
    )
    colnames(med_year_disc) <- c("Country", "Area", "Year", "MEDBS_by_Year_Discards")

    ### table by quarters
    # Catches
    med_metier_quarter0 <- suppressMessages(
        med[med$quarter != -1 & med$no_samples_catch != -1, ] %>%
      group_by(country, area, year, quarter, metier) %>%
      summarise(no_samples_catch = max(no_samples_catch,na.rm=TRUE))
    )
    med_metier_quarter <- suppressMessages(
        med_metier_quarter0 %>%
      group_by(country, area, year, metier) %>%
      summarise(trips_quarters = sum(no_samples_catch, na.rm = TRUE))
    )
    med_quarter <- suppressMessages(
      med_metier_quarter %>%
        group_by(country, area, year) %>%
        summarise(trips_quarters = sum(trips_quarters, na.rm = TRUE))
    )
    colnames(med_quarter) <- c("Country", "Area", "Year","MEDBS_quarters_Catches")

    # Landings
    med_metier_quarter0_land <- suppressMessages(
      med[med$quarter != -1 & med$no_samples_landings != -1, ] %>%
        group_by(country, area, year, quarter, metier) %>%
        summarise(no_samples_landings = max(no_samples_landings,na.rm=TRUE))
    )
    med_metier_quarter_land <- suppressMessages(
      med_metier_quarter0_land %>%
        group_by(country, area, year, metier) %>%
        summarise(trips_quarters = sum(no_samples_landings, na.rm = TRUE))
    )
    med_quarter_land <- suppressMessages(
      med_metier_quarter_land %>%
        group_by(country, area, year) %>%
        summarise(trips_quarters = sum(trips_quarters, na.rm = TRUE))
    )
    colnames(med_quarter_land) <- c("Country", "Area", "Year","MEDBS_quarters_Landings")

    # Discards
    med_metier_quarter0_disc <- suppressMessages(
      med[med$quarter != -1 & med$no_samples_discards != -1, ] %>%
        group_by(country, area, year, quarter, metier) %>%
        summarise(no_samples_discards = max(no_samples_discards,na.rm=TRUE))
    )
    med_metier_quarter_disc <- suppressMessages(
      med_metier_quarter0_disc %>%
        group_by(country, area, year, metier) %>%
        summarise(trips_quarters = sum(no_samples_discards, na.rm = TRUE))
    )
    med_quarter_disc <- suppressMessages(
      med_metier_quarter_disc %>%
        group_by(country, area, year) %>%
        summarise(trips_quarters = sum(trips_quarters, na.rm = TRUE))
    )
    colnames(med_quarter_disc) <- c("Country", "Area", "Year","MEDBS_quarters_Discards")

    #--------
    med_tab <- suppressMessages(
        med_year %>% full_join(med_year_land) %>% full_join(med_year_disc) %>% full_join(med_quarter) %>% full_join(med_quarter_land) %>% full_join(med_quarter_disc)
    )
    #--------
    med_tab_country <- med_tab %>% group_by(Country, Year) %>% summarise(
      MEDBS_by_Year_Catch = sum(MEDBS_by_Year_Catch, na.rm=TRUE),
      MEDBS_by_Year_Landings = sum(MEDBS_by_Year_Landings, na.rm=TRUE),
      MEDBS_by_Year_Discards = sum(MEDBS_by_Year_Discards, na.rm=TRUE),
      MEDBS_quarters_Catches = sum(MEDBS_quarters_Catches, na.rm=TRUE),
      MEDBS_quarters_Landings = sum(MEDBS_quarters_Landings, na.rm=TRUE),
      MEDBS_quarters_Discards = sum(MEDBS_quarters_Discards, na.rm=TRUE)
      )

    #----------------------------------------
    # Merge AR table with MED & BS catch data
    #----------------------------------------
    if (estimation =="GSA") {
      colnames(AR1) <- c("Country", "Area", "Year", "trips_AR")
      AR1$Year <- as.numeric(AR1$Year)
      AR1$trips_AR <- as.numeric(AR1$trips_AR)

      res_tab <- suppressMessages(
        med_tab %>% full_join(AR1[, c("Country", "Area", "Year", "trips_AR")])
      )
    } else if (estimation =="COUNTRY") {
      colnames(AR1) <- c("Country", "Year", "trips_AR")
      AR1$Year <- as.numeric(AR1$Year)
      AR1$trips_AR <- as.numeric(AR1$trips_AR)

      res_tab <- suppressMessages(
        med_tab_country %>% full_join(AR1[, c("Country", "Year", "trips_AR")])
      )
    }

    tab <- data.frame(res_tab)
    if(OUT%in%TRUE){
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
      write.csv(tab,paste0(WD,"/OUTPUT/CSV/MEDBS_AR_TRIPS_comparison_",MS,".csv"),row.names = F)
    }

    return(tab)
  } else { # nrow(AR)>0 & nrow(med)>0
    if (verbose) {
      message("No data available in one or both tables for the selected combination of country and GSA")
    }
  }

}
