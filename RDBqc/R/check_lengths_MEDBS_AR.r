#' Cross check of number of lengths between MED&BS catch table and AR Table 2.1
#'
#' @param MEDBS data frame containing MED&BS catch table
#' @param AR data frame containing Annual Report data
#' @param MS member state code
#' @param GSA Geographical Subarea
#' @param SP Species 3-alpha code
#' @param year Reference year for the analysis
#' @param species_list table of species 3-alpha codes, reporting the MED & BS mandatory species
#' @param OUT Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function compares the number of length measurements reported in MED & BS data call catch table with the information reported in the table 2.1 ("Stocks") of the Annual Report.
#' The user have to define the two source tables as data frames in the \code{MEDBS} and \code{AR} parameters. The analysis should be constrained at the selected country level (\code{MS}) and at the selected \code{year}.
#' @return The function returns a data frame reporting the total number of length measurements related to catches, landings and discards conducted in the selected country and year. MED & BS data will be reported as sum of the measurements by year and sum of the trips reported by quarter in the year.
#' @export
#' @author Walter Zupa <zupa@@fondazionecoispa.org>
#' @import dplyr
#' @importFrom magrittr %>%

check_lengths_MEDBS_AR <- function(MEDBS, AR, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=FALSE, verbose = FALSE) {
  if (FALSE) {
    rm(list = ls(all.names = TRUE))
    # library(readxl)
    # library(dplyr)

    verbose <- FALSE

    setwd("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\data")
    load("GSAs.rda")
    load("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/QualiTrain_scripts/QualiTrain/data/Sps.rda")
    # SPs <- read_excel("ASFIS_sp_2022_REV1.xlsx",sheet =1)
    # SPs <- data.frame(SPs)

    # species_list <- SSPP
    MS <- "ITA"
    SP <- "KLK"
    GSA <- "GSA 17"
    year <- 2020

    # AR <- read_excel("AR_2019_template_2023_Tab_2.5.xlsx", sheet = "Table 2.5 Sampling plan biol", skip = 1)
    AR <- read_excel("table 2.1 e 2.2 med and bs.xlsx", sheet = "Table 2.1 Stocks", skip = 1)
    AR <- data.frame(AR)
    # AR <- AR[!AR$Area %in% c("GSA11","GSA 9, 10, 11, 16, 17, 18, 19"),]
    #---------------#
    med <- read.table("catch ita 2019.csv", sep = ";", header = TRUE)
    # med <- med[, c(1:30)]

    species_list = SSPP
    MEDBS <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\AR-documentazione\\TEST funzioni AR\\catch.csv",sep=",", header=TRUE)
    AR <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\AR-documentazione\\TEST funzioni AR\\AR_TAB21_2022.csv",sep=",", header=TRUE)


    res <- check_lengths_MEDBS_AR(MEDBS=MEDBS, AR=AR, MS = "ITA", GSA = GSA, SP = SP, year = 2020, species_list = SSPP, verbose = TRUE,OUT=TRUE)
  } # if (FALSE)

  Area <- Implementation.year <- Achieved.number.of.PSUs.in.the.implementation.year <- country <- area <- metier <- no_samples_catch <- trips_year <- no_samples_landings <- no_samples_discards <- quarter <- trips_quarters <- Country <- Year <- MEDBS_by_Year_Catch <- MEDBS_by_Year_Landings <- MEDBS_quarters_Discards <- MEDBS_by_Year_Discards <- MEDBS_quarters_Catches <- MEDBS_quarters_Landings <- Species <- Achieved.number.of.individuals.measured.for.length.at.national.level.from.commercial.sampling <- species <- no_length_measurements_catch <- no_length_measurements_landings <- no_length_measurements_discards <- no_length_catch <- no_length_landings <- no_length_discards <- NULL

  SPs <- species_list

  quit <- FALSE
  quit_AR <- FALSE

  GSAlist <- GSAlist[GSAlist$COUNTRY == MS, ]
  if (all(is.na(GSA))) {
    GSA <- paste("GSA", as.numeric(GSAlist$GSA))
    user_GSA <- FALSE
  } else {
    GSA <- GSA[!is.na(GSA)]
    GSA <- as.numeric(gsub("\\D", "", GSA))
    GSA <- paste("GSA" ,GSA,sep=" ")
    GSA <- GSA[GSA %in% paste("GSA", as.numeric(GSAlist$GSA))]
    user_GSA <- TRUE
  }




  #### MED & BS Catch

  #----------
  med <- MEDBS
  med <- med[med$country == MS & med$area %in% GSA, ]
  med <- med[med$year == year, ]

  #----------

  # filter on species
  if (nrow(med) == 0) {
    if (verbose) {
      message("No data available in Catch table for the selected country")
    }
    quit <- TRUE
  } else {
    if (all(is.na(SP))) {
      SP <- sort(unique(med$species))
      user_SP <- FALSE
    } else {
      SP <- SP[!is.na(SP)]
      SP <- SP[SP %in% unique(SPs$X3A_CODE)]
      user_SP <- TRUE
    }
    med <- med[med$species %in% SP, ]
  } # nrow(med) > 0

  #### AR
  #----------
  # AR[!is.na(AR$Area) & AR$Area == "GSA11", "Area"] <- "GSA 11"

  if (user_GSA) {
    AR <- AR[AR$MS == MS & AR$Area %in% GSA, ]
  } else {
    AR <- AR[AR$MS == MS, ]
  }

  # filter by year
  if (nrow(AR) == 0) {
    if (verbose) {
      message("No data available in AR table for the selected country")
    }
    quit_AR <- TRUE
  } else {
    if ("year" %in% colnames(AR)) {
      AR <- AR[AR$year == year, ]
    } else {
      AR$year <- year
    }
  }

  # filter by Region
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data available for the analysis")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[!is.na(AR$Region) & tolower(AR$Region) %in% tolower(c("Mediterranean and Black Sea", "Mediterranean Sea and Black Sea")), ]
  }

  # Species conversion and filter by GSA
  excluded.sp <- NULL
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data available for the analysis")
    }
    quit_AR <- TRUE
  } else {
    i <- 1
    for (i in 1:nrow(AR)) {
      if (AR$Species[i] %in% SPs$Scientific_Name) {
        AR$Species[i] <- SPs[SPs$Scientific_Name == AR$Species[i], "X3A_CODE"]
      } else {
        excluded.sp[length(excluded.sp) + 1] <- AR$Species[i]
      }
    }

    excluded.sp <- unique(excluded.sp)
    if (length(excluded.sp) > 0) {
      AR <- AR[!AR$Species %in% excluded.sp, ]
    }

    if (user_SP) {
      AR <- AR[AR$Species %in% SP, ]
    }
    species.AR <- unique(AR$Species)

    GSAR <- unique(AR$Area)

    tab.AR <- list()

    s <- 1
    for (s in 1:length(species.AR)) {
      AR_GSA <- AR[AR$Species == species.AR[s], ]
      GSAR <- unique(AR_GSA$Area)
      if (all(!is.na(GSAR)) & all(GSAR %in% paste0("GSA", GSAlist$GSA))) {
        AR_GSA <- AR_GSA[AR_GSA$Area %in% GSAR, ]
        g <- as.numeric(substr(AR_GSA$Area, 4, 5))
        g <- paste("GSA", g)
        AR_GSA$Area <- g
        AR_GSA$estimation <- "GSA"
      } else if (all(!is.na(GSAR)) & all(GSAR %in% paste0("GSA ", GSAlist$GSA))) {
        AR_GSA <- AR_GSA[AR_GSA$Area %in% GSAR, ]
        g <- as.numeric(substr(AR_GSA$Area, 5, 6))
        g <- paste("GSA", g)
        AR_GSA$Area <- g
        AR_GSA$estimation <- "GSA"
      } else if (all(!is.na(GSAR)) & all(GSAR %in% paste0("GSA ", as.numeric(GSAlist$GSA)))) {
        AR_GSA <- AR_GSA[!is.na(AR_GSA$Area) & AR_GSA$Area %in% GSAR, ]
        AR_GSA$estimation <- "GSA"
      } else if (all(!is.na(GSAR)) & all(GSAR %in% paste0("GSA", as.numeric(GSAlist$GSA)))) {
        AR_GSA <- AR_GSA[AR_GSA$Area %in% GSAR, ]
        g <- as.numeric(substr(AR_GSA$Area, 4, 5))
        g <- paste("GSA", g)
        AR_GSA$Area <- g
        AR_GSA$estimation <- "GSA"
      } else {
        AR_GSA$estimation <- "COUNTRY"
        AR_GSA$Area <- MS
      }

      tab.AR[[s]] <- AR_GSA
    }

    AR <- do.call(rbind, tab.AR)
    SP_GSA <- unique(AR[AR$estimation == "GSA", "Species"])
    SP_COUNTRY <- unique(AR[AR$estimation == "COUNTRY", "Species"])
  }

  AR <- AR[!is.na(AR$Achieved.number.of.individuals.measured.for.length.at.national.level.from.commercial.sampling), ]

  if (nrow(AR) > 0 & nrow(med) > 0 & !quit & !quit_AR) {

    #-------------------
    # ANNUAL REPORT data
    #-------------------

    AR1 <- suppressMessages(
      AR %>%
        group_by(MS, Area, year, Species) %>%
        summarise(lengths = sum(Achieved.number.of.individuals.measured.for.length.at.national.level.from.commercial.sampling, na.rm = TRUE))
    )
    colnames(AR1) <- c("Country", "Area", "Year", "Species", "Lengths")

    #--------------------
    # MED & BS catch data
    #--------------------

    ### table by year
    # Catches

    med_year_catch <- suppressMessages(
      med[med$quarter == -1 & med$no_length_measurements_catch != -1, ] %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_year = sum(no_length_measurements_catch))
    )

    colnames(med_year_catch) <- c("Country", "Area", "Year", "Species", "MEDBS_by_Year_Catch")

    # Landings
    med_year_land <- suppressMessages(
      med[med$quarter == -1 & med$no_length_measurements_landings != -1, ] %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_year = sum(no_length_measurements_landings))
    )

    colnames(med_year_land) <- c("Country", "Area", "Year", "Species", "MEDBS_by_Year_Landings")

    # Discards
    med_year_disc <- suppressMessages(
      med[med$quarter == -1 & med$no_length_measurements_discards != -1, ] %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_year = sum(no_length_measurements_discards))
    )

    colnames(med_year_disc) <- c("Country", "Area", "Year", "Species", "MEDBS_by_Year_Discards")

    ### table by quarters
    # Catches
    med_quarter0 <- suppressMessages(
      med[med$quarter != -1 & med$no_length_measurements_catch != -1, ] %>%
        group_by(country, area, year, quarter, species) %>%
        summarise(no_length_catch = sum(no_length_measurements_catch, na.rm = TRUE))
    )

    med_quarter_catch <- suppressMessages(
      med_quarter0 %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_quarters = sum(no_length_catch, na.rm = TRUE))
    )
    colnames(med_quarter_catch) <- c("Country", "Area", "Year", "Species", "MEDBS_quarters_Catches")

    # Landings
    med_quarter0 <- suppressMessages(
      med[med$quarter != -1 & med$no_length_measurements_landings != -1, ] %>%
        group_by(country, area, year, quarter, species) %>%
        summarise(no_length_landings = sum(no_length_measurements_landings, na.rm = TRUE))
    )

    med_quarter_landings <- suppressMessages(
      med_quarter0 %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_quarters = sum(no_length_landings, na.rm = TRUE))
    )
    colnames(med_quarter_landings) <- c("Country", "Area", "Year", "Species", "MEDBS_quarters_Landings")

    # Discards
    med_quarter0 <- suppressMessages(
      med[med$quarter != -1 & med$no_length_measurements_discards != -1, ] %>%
        group_by(country, area, year, quarter, species) %>%
        summarise(no_length_discards = sum(no_length_measurements_discards, na.rm = TRUE))
    )

    med_quarter_discards <- suppressMessages(
      med_quarter0 %>%
        group_by(country, area, year, species) %>%
        summarise(lengths_quarters = sum(no_length_discards, na.rm = TRUE))
    )
    colnames(med_quarter_discards) <- c("Country", "Area", "Year", "Species", "MEDBS_quarters_Discards")

    #--------
    med_tab <- suppressMessages(
      med_year_catch %>% full_join(med_year_land) %>% full_join(med_year_disc) %>% full_join(med_quarter_catch) %>% full_join(med_quarter_landings) %>% full_join(med_quarter_discards)
    )
    #--------
    med_tab_c <- med_tab
    med_tab_c$Area <- MS
    med_tab_country <- med_tab_c %>%
      group_by(Country, Area, Year, Species) %>%
      summarise(
        MEDBS_by_Year_Catch = sum(MEDBS_by_Year_Catch, na.rm = TRUE),
        MEDBS_by_Year_Landings = sum(MEDBS_by_Year_Landings, na.rm = TRUE),
        MEDBS_by_Year_Discards = sum(MEDBS_by_Year_Discards, na.rm = TRUE),
        MEDBS_quarters_Catches = sum(MEDBS_quarters_Catches, na.rm = TRUE),
        MEDBS_quarters_Landings = sum(MEDBS_quarters_Landings, na.rm = TRUE),
        MEDBS_quarters_Discards = sum(MEDBS_quarters_Discards, na.rm = TRUE)
      )

    if (length(SP_COUNTRY) > 0 & any(SP_COUNTRY %in% unique(med_tab_country$Species))) {
      med_tab_country <- med_tab_country[med_tab_country$Species %in% SP_COUNTRY, ]
      med_tab <- med_tab[!med_tab$Species %in% SP_COUNTRY, ]
      med_tab <- rbind(med_tab_country, med_tab)
    }


    #----------------------------------------
    # Merge AR table with MED & BS catch data
    #----------------------------------------

    colnames(AR1) <- c("Country", "Area", "Year", "Species", "Lengths_AR")

    res_tab <- suppressMessages(
      med_tab %>% full_join(AR1[, c("Country", "Area", "Year", "Species", "Lengths_AR")])
    )

    tab <- data.frame(res_tab)
    tab$warnings <- NA
    tab$errors <- NA
    n <- 1
    for (n in 1:nrow(tab)) {
      if (!tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        tab[n, "warnings"] <- "species not present in MEDBS data call list"
      }
      if (tab[n, "Species"] %in% unique(AR$Species)) {
        if (tab[n, "Area"] == MS & is.na(tab$Lengths_AR[n])) {
          tab[n, "warnings"] <- paste(tab[n, "warnings"], "species expected in WP", sep = " - ")
        } else if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) & is.na(tab$Lengths_AR[n])) {
          tab[n, "warnings"] <- "species expected in WP"
        }
      }

      if (tab[n, "Species"] %in% unique(AR$Species) & tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        # common species in MEDBS and AR with no data in AR
        if (tab[n, "Area"] == MS &
          (is.na(tab$Lengths_AR[n]) | tab$Lengths_AR[n] == 0) &
          !(is.na(tab$MEDBS_by_Year_Catch[n]) &
            is.na(tab$MEDBS_by_Year_Landings[n]) &
            is.na(tab$MEDBS_by_Year_Discards[n]) &
            is.na(tab$MEDBS_quarters_Catches[n]) &
            is.na(tab$MEDBS_quarters_Landings[n]) &
            is.na(tab$MEDBS_quarters_Discards[n])
          )) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (is.na(tab$Lengths_AR[n]) | tab$Lengths_AR[n] == 0) &
          !(is.na(tab$MEDBS_by_Year_Catch[n]) &
            is.na(tab$MEDBS_by_Year_Landings[n]) &
            is.na(tab$MEDBS_by_Year_Discards[n]) &
            is.na(tab$MEDBS_quarters_Catches[n]) &
            is.na(tab$MEDBS_quarters_Landings[n]) &
            is.na(tab$MEDBS_quarters_Discards[n])
          )) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        }
        # common species in MEDBS and AR with no data in MEDBS
        if (tab[n, "Area"] == MS &
          (!is.na(tab$Lengths_AR[n]) & tab$Lengths_AR[n] != 0) &
          (is.na(tab$MEDBS_by_Year_Catch[n]) &
            is.na(tab$MEDBS_by_Year_Landings[n]) &
            is.na(tab$MEDBS_by_Year_Discards[n]) &
            is.na(tab$MEDBS_quarters_Catches[n]) &
            is.na(tab$MEDBS_quarters_Landings[n]) &
            is.na(tab$MEDBS_quarters_Discards[n])
          )) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (!is.na(tab$Lengths_AR[n]) & tab$Lengths_AR[n] != 0) &
          (is.na(tab$MEDBS_by_Year_Catch[n]) &
            is.na(tab$MEDBS_by_Year_Landings[n]) &
            is.na(tab$MEDBS_by_Year_Discards[n]) &
            is.na(tab$MEDBS_quarters_Catches[n]) &
            is.na(tab$MEDBS_quarters_Landings[n]) &
            is.na(tab$MEDBS_quarters_Discards[n])
          )) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        }
      }
    }



    tab_no_MEDBS <- tab[is.na(tab$MEDBS_by_Year_Catch) &
      is.na(tab$MEDBS_by_Year_Landings) &
      is.na(tab$MEDBS_by_Year_Discards) &
      is.na(tab$MEDBS_quarters_Catches) &
      is.na(tab$MEDBS_quarters_Landings) &
      is.na(tab$MEDBS_quarters_Discards) &
      (!is.na(tab$Lengths_AR) & tab$Lengths_AR != 0), ]

    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_MEDBS, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_lengths_comparison_Data_not_in_MEDBS_", MS, ".csv"), row.names = F)
    }


    tab <- tab[!(is.na(tab$MEDBS_by_Year_Catch) &
      is.na(tab$MEDBS_by_Year_Landings) &
      is.na(tab$MEDBS_by_Year_Discards) &
      is.na(tab$MEDBS_quarters_Catches) &
      is.na(tab$MEDBS_quarters_Landings) &
      is.na(tab$MEDBS_quarters_Discards)), ]

    tab_no_AR <- tab[is.na(tab$Lengths_AR) | tab$Lengths_AR == 0, ]

    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_AR, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_lengths_comparison_Data_not_in_AR_", MS, ".csv"), row.names = F)
    }

    tab <- tab[!is.na(tab$Lengths_AR), ]

    tab_match <- tab[!(is.na(tab$MEDBS_by_Year_Catch) &
      is.na(tab$MEDBS_by_Year_Landings) &
      is.na(tab$MEDBS_by_Year_Discards) &
      is.na(tab$MEDBS_quarters_Catches) &
      is.na(tab$MEDBS_quarters_Landings) &
      is.na(tab$MEDBS_quarters_Discards)) &
      (!is.na(tab$Lengths_AR) & tab$Lengths_AR != 0), ]

    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_match, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_lengths_comparison_Matching_data_", MS, ".csv"), row.names = F)
    }

    output <- list(tab_match, tab_no_MEDBS, tab_no_AR)
    names(output) <- c("Species_matches", "Species_not_in_MEDBS", "Species_not_in_AR")
    return(output)
  } else { # nrow(AR)>0 & nrow(med)>0
    if (verbose) {
      message("No data available in one or both tables for the selected combination of country and GSA")
    }
    return(NULL)
  }
}
