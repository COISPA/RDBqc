#' Cross check of number of age measurements between MED&BS ALK table and AR Table 2.2
#'
#' @param ALK data frame containing MED&BS ALK table
#' @param AR data frame containing Annual Report data table 2.2
#' @param MS member state code
#' @param GSA Geographical Subarea
#' @param SP Species 3-alpha code
#' @param year Reference year for the analysis
#' @param species_list table of species 3-alpha codes, reporting the MED & BS mandatory species
#' @param OUT Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function compares the number of age measurements reported in MED & BS data call ALK table with the information reported in the table 2.2 ("Biol variables") of the Annual Report.
#' The user have to define the two source tables as data frames in the \code{ALK} and \code{AR} parameters. The analysis should be constrained at the selected country level (\code{MS}), geographical sub-area \code{GSA} and \code{year}.
#' @return A list of three data frames is returned. The first list element contains all the species matching between the two tables; the second list element reports the species reported in Annual Report but not in the MED&BS ALK table; the third list element contains the species reported in MED&BS ALK table but not in the Annual Report table 2.2. Warnings are reported for data of species not included in the MED&BS data call, and for species expected in the Work Plan and not reported in the Annual Report. Errors are reported for species expected in both tables but not present at least in one of the two tables.
#' @export
#' @author Walter Zupa <zupa@@fondazionecoispa.org>
#' @import dplyr
#' @importFrom magrittr %>%
check_age_MEDBS_AR <- function(ALK, AR, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=FALSE, verbose = TRUE) {
  if (FALSE) {
    rm(list = ls(all.names = TRUE))
    # library(readxl)
    # library(dplyr)
    setwd("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\data")
    load("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/QualiTrain_scripts/QualiTrain/data/GSAs.rda")

    MS <- "ITA"
    GSA <- "GSA 9"
    SP <- "MUT" # c("ARS","HKE")
    year <- 2020
    species_list = RDBqc::SSPP


    load("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/QualiTrain_scripts/QualiTrain/data/SPs.rda")
    # species_list <- SSPP
    # SSPP <- read_excel("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/data/ASFIS_sp_2022_REV1.xlsx",sheet =1)
    # SSPP <- read.table("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/data/ASFIS_sp_2022_REV1.csv",sep=";",header=TRUE)
    # SSPP[!is.na(SSPP$MEDBS) & SSPP$MEDBS=="","MEDBS"] <- NA
    # SSPP <- data.frame(RDBqc::SPs)
    # save(SSPP,file="D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\QualiTrain_scripts\\QualiTrain\\data/SSPP.rda",compress="xz",compression_level=9)


    ALK <- read.table("alk.csv", sep = ";", header = TRUE)
    AR <- read_excel("table 2.1 e 2.2 med and bs.xlsx", sheet = "Table 2.2 Biol variables", skip = 1)
    AR <- data.frame(AR)
    OUT=FALSE
    check_age_MEDBS_AR(ALK, AR, MS = "ITA", GSA = NA, SP, year = 2019,OUT=TRUE, verbose = TRUE)
  }

  Area <- Implementation.year <- Species <- Achieved.number.of.individuals.measured.at.national.level <- country <- area <- in.year <- ref.year <- species <- sex <- total_number_of_hard_structure_read_by_age <- NULL
  # START function
  SPs <- species_list
  quit <- FALSE
  quit_AR <- FALSE
  GSAlist <- GSAlist[GSAlist$COUNTRY == MS, ]
  if (all(is.na(GSA))) {
    GSA <- paste("GSA", as.numeric(GSAlist$GSA))
    user_GSA <- FALSE
  } else {
    GSA <- GSA[!is.na(GSA)]
    GSA <- GSA[GSA %in% paste("GSA", as.numeric(GSAlist$GSA))]
    user_GSA <- TRUE
  }

  ### ALK data
  colnames(ALK) <- tolower(colnames(ALK))
  # filter on country
  ALK <- ALK[ALK$country == MS & ALK$area %in% GSA, ]

  # filter on species
  if (nrow(ALK) == 0) {
    if (verbose) {
      message("No data avilable in ALK table for the selected country")
    }
    quit <- TRUE
  } else {
    if (all(is.na(SP))) {
      SP <- sort(unique(ALK$species))
      user_SP <- FALSE
    } else {
      SP <- SP[!is.na(SP)]
      SP <- SP[SP %in% unique(SPs$X3A_CODE)]
      user_SP <- TRUE
    }
    ALK <- ALK[ALK$species %in% SP, ]
  } # nrow(ALK) > 0

  # filter on year

  if (quit | nrow(ALK) == 0) {
    if (verbose) {
      message("No ALK data avilable for the analysis")
    }
    quit <- TRUE
  } else {
    ALK$ref.year <- NA
    ALK$in.year <- NA
    i <- 1

    for (i in 1:nrow(ALK)) {
      if (ALK$start_year[i] <= year & year <= ALK$end_year[i]) {
        ALK$in.year[i] <- year
      }
      ALK$ref.year[i] <- ifelse(ALK$start_year[i] == ALK$end_year[i], ALK$start_year[i], paste(ALK$start_year[i], ALK$end_year[i], sep = "-"))
    }
    ALK <- ALK[!is.na(ALK$in.year) & ALK$in.year == year & ALK$total_number_of_hard_structure_read_by_age != -1, ]
  } # nrow(ALK) > 0

  #------------------
  ### AR data
  # filter on country
  AR[!is.na(AR$Area) & AR$Area == "GSA11", "Area"] <- "GSA 11"

  if (user_GSA) {
    AR <- AR[AR$MS == MS & AR$Area %in% GSA, ]
  } else {
    AR <- AR[AR$MS == MS, ]
  }


  # filter on Year
  if (nrow(AR) == 0) {
    if (verbose) {
      message("No data avilable in AR table for the selected country")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[AR$Implementation.year == year, ]
  }

  # filter on Region
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data avilable for the analysis")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[!is.na(AR$Region) & tolower(AR$Region) %in% tolower(c("Mediterranean and Black Sea", "Mediterranean Sea and Black Sea")), ]
  }

  # filter on Biological variable
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data avilable for the analysis")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[tolower(AR$Biological.variable) == "age", ]
  }


  # filter on Observation.type
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data avilable for the analysis")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[!is.na(AR$Observation.type) & AR$Observation.type %in% c("SciObsOnShore", "SciObsAtSea"), ]
  }

  # filter on Sampling.scheme.type
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data avilable for the analysis")
    }
    quit_AR <- TRUE
  } else {
    AR <- AR[tolower(AR$Sampling.scheme.type) == "commercial fishing trip", ]
  }

  #------
  excluded.sp <- NULL
  if (quit_AR | nrow(AR) == 0) {
    if (verbose) {
      message("No AR data avilable for the analysis")
    }
    quit_AR <- TRUE
  } else {
    i=1
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

  if (nrow(AR) > 0 & nrow(ALK) > 0 & !quit & !quit_AR) {

    #-------------------
    # ANNUAL REPORT data
    #-------------------
    AR$Achieved.number.of.individuals.measured.at.national.level <- as.numeric(AR$Achieved.number.of.individuals.measured.at.national.level)
    AR1 <- suppressMessages(
      AR %>%
        group_by(MS, Area, Implementation.year, Species) %>%
        summarise(numb.age.ALK = sum(Achieved.number.of.individuals.measured.at.national.level, na.rm = TRUE))
    )
    colnames(AR1) <- c("Country", "Area", "Year", "Species", "age.AR")

    #--------------------
    # MED & BS ALK data
    #--------------------
    ALK$total_number_of_hard_structure_read_by_age <- as.numeric(ALK$total_number_of_hard_structure_read_by_age)
    if (any(!unique(ALK$species) %in% SP_COUNTRY)) {
      ALK_GSA <- suppressMessages(
        ALK[!ALK$species %in% SP_COUNTRY, ] %>% group_by(country, area, in.year, ref.year, species, sex) %>%
          summarise(numb.age.AR = sum(total_number_of_hard_structure_read_by_age, na.rm = TRUE))
      )
      colnames(ALK_GSA) <- c("Country", "Area", "Year", "Sample.Year.ALK", "Species", "Sex", "numb.age.ALK")
    }
    if (any(unique(ALK$species) %in% SP_COUNTRY)) {
      ALK_COUNTRY <- ALK[ALK$species %in% SP_COUNTRY, ]
      ALK_COUNTRY$area <- MS
      ALK_COUNTRY <- suppressMessages(
        ALK_COUNTRY %>% group_by(country, area, in.year, ref.year, species, sex) %>%
          summarise(numb.age.AR = sum(total_number_of_hard_structure_read_by_age, na.rm = TRUE))
      )
      colnames(ALK_COUNTRY) <- c("Country", "Area", "Year", "Sample.Year.ALK", "Species", "Sex", "numb.age.ALK")
    }

    if (!exists("ALK_COUNTRY") & exists("ALK_GSA")) {
      ALK_tab <- ALK_GSA
    }
    if (!exists("ALK_GSA") & exists("ALK_COUNTRY")) {
      ALK_tab <- ALK_COUNTRY
    }
    if (exists("ALK_COUNTRY") & exists("ALK_GSA")) {
      ALK_tab <- rbind(ALK_COUNTRY, ALK_GSA)
    }

    ALK_tab_f <- reshape2::dcast(ALK_tab, Country + Area + Year + Sample.Year.ALK + Species ~ Sex, value.var = "numb.age.ALK")
    colnames(ALK_tab_f)[6:ncol(ALK_tab_f)] <- paste(colnames(ALK_tab_f)[6:ncol(ALK_tab_f)], "_age_ALK", sep = "")

    tab <- suppressMessages(ALK_tab_f %>% full_join(AR1))
    tab$warnings <- NA
    tab$errors <- NA

    n <- 10
    for (n in 1:nrow(tab)) {
      if (!tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        tab[n, "warnings"] <- "species not present in MEDBS data call list"
      }
      if (tab[n, "Species"] %in% unique(AR$Species)) {
        if (tab[n, "Area"] == MS & is.na(tab$age.AR[n])) {
          tab[n, "warnings"] <- paste(tab[n, "warnings"], "species expected in WP", sep = " - ")
        } else if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) & is.na(tab$age.AR[n])) {
          tab[n, "warnings"] <- "species expected in WP"
        }
      }

      if (tab[n, "Species"] %in% unique(AR$Species) & tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        # common species in MEDBS and AR with no data in AR
        if (tab[n, "Area"] == MS &
          (is.na(tab$age.AR[n]) | tab$age.AR[n] == 0) &
          !(is.na(tab$C_age_ALK[n]) &
            is.na(tab$F_age_ALK[n]) &
            is.na(tab$M_age_ALK[n]))) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (is.na(tab$age.AR[n]) | tab$age.AR[n] == 0) &
          !(is.na(tab$C_age_ALK[n]) &
            is.na(tab$F_age_ALK[n]) &
            is.na(tab$M_age_ALK[n]))) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        }
        # common species in MEDBS and AR with no data in MEDBS
        if (tab[n, "Area"] == MS &
          (!is.na(tab$age.AR[n]) & tab$age.AR[n] != 0) &
          (is.na(tab$C_age_ALK[n]) &
            is.na(tab$F_age_ALK[n]) &
            is.na(tab$M_age_ALK[n]))) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (!is.na(tab$age.AR[n]) & tab$age.AR[n] != 0) &
          (is.na(tab$C_age_ALK[n]) &
            is.na(tab$F_age_ALK[n]) &
            is.na(tab$M_age_ALK[n]))) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        }
      }
    }

    tab_no_MEDBS <- tab[is.na(tab$C_age_ALK) &
      is.na(tab$F_age_ALK) &
      is.na(tab$M_age_ALK) &
      (!is.na(tab$age.AR) & tab$age.AR != 0), ]
    if (OUT == TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_MEDBS, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_ages_comparison_Data_not_in_MEDBS_", MS, ".csv"), row.names = F)
    }

    tab <- tab[!(is.na(tab$C_age_ALK) &
      is.na(tab$F_age_ALK) &
      is.na(tab$M_age_ALK)), ]

    tab_no_AR <- tab[is.na(tab$age.AR) | tab$age.AR == 0, ]
    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_AR, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_ages_comparison_Data_not_in_AR_", MS, ".csv"), row.names = F)
    }

    tab <- tab[!is.na(tab$age.AR) & tab$age.AR != 0, ]

    tab_match <- tab[!(is.na(tab$C_age_ALK) &
      is.na(tab$F_age_ALK) &
      is.na(tab$M_age_ALK)) &
      (!is.na(tab$age.AR) & tab$age.AR != 0), ]
    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_match, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_ages_comparison_Matching_data_", MS, ".csv"), row.names = F)
    }
    output <- list(tab_match, tab_no_MEDBS, tab_no_AR)
    names(output) <- c("Species_matches", "Species_not_in_MEDBS", "Species_not_in_AR")

    return(output)
  } else { # (nrow(AR) > 0 & nrow(ALK) > 0 & !quit & !quit_AR)
    if (nrow(ALK) == 0) {
      if (verbose) {
        message("No ALK data available. The analysis was not completed.")
      }
    }
    if (nrow(AR) == 0) {
      if (verbose) {
        message("No AR data available. The analysis was not completed.")
      }
    }
  } # (nrow(AR) > 0 & nrow(ALK) > 0 & !quit & !quit_AR)
}
