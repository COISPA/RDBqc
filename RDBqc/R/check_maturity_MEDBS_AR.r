#' Cross check of number of maturity measurements between MED&BS ML table and AR Table 2.2
#'
#' @param ML data frame containing MED&BS ML table
#' @param AR data frame containing Annual Report data table 2.2
#' @param MS member state code
#' @param GSA Geographical Subarea
#' @param SP Species 3-alpha code
#' @param year Reference year for the analysis
#' @param species_list table of species 3-alpha codes, reporting the MED & BS mandatory species
#' @param OUT Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory
#' @param verbose boolean. If TRUE a message is printed.
#' @description The function compares the number of maturity measurements reported in MED & BS data call ML table with the information reported in the table 2.2 ("Biol variables") of the Annual Report.
#' The user have to define the two source tables as data frames in the \code{ML} and \code{AR} parameters. The analysis should be constrained at the selected country level (\code{MS}), geographical sub-area \code{GSA} and \code{year}. When GSA and SP parameter are NA, the analysis is conducted on all the GSAs  and species included in the data frame for the selected country.
#' @return A list of three data frames is returned. The first list element contains all the species matching between the two tables; the second list element reports the species reported in Annual Report but not in the MED&BS ML table; the third list element contains the species reported in MED&BS ML table but not in the Annual Report table 2.2. Warnings are reported for data of species not included in the MED&BS data call, and for species expected in the Work Plan and not reported in the Annual Report. Errors are reported for species expected in both tables but not present at least in one of the two tables.
#' @export
#' @author Walter Zupa <zupa@@fondazionecoispa.org>
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom reshape2 dcast

check_maturity_MEDBS_AR <- function(ML, AR, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=FALSE, verbose = TRUE) {
  if (FALSE) {
    rm(list = ls(all.names = TRUE))
    # library(readxl)
    # library(dplyr)
    # library(reshape2)
    setwd("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\data")
    load("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/QualiTrain_scripts/QualiTrain/data/GSAs.rda")

    MS <- "ITA"
    GSA <- "9"
    SP <- "MUT" # c("ARS","HKE")
    year <- 2020
    species_list = SSPP
    # SPs <- read_excel("ASFIS_sp_2022_REV1.xlsx",sheet =1)
    # SPs <- data.frame(SPs)
    load("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/QualiTrain/QualiTrain_scripts/QualiTrain/data/Sps.rda")
    # species_list <- SSPP
    # save(SPs,file="D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\QualiTrain_scripts\\QualiTrain\\data/SPs.rda",compress="xz",compression_level=9)

    ML <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\AR-documentazione\\TEST funzioni AR\\ml.csv",sep=",", header=TRUE)
    AR <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\QualiTrain\\AR-documentazione\\TEST funzioni AR\\AR_TAB22_2022.csv",sep=",", header=TRUE)
    AR <- data.frame(AR)

    check_maturity_MEDBS_AR(ML, AR, MS = "ITA", GSA = "GSA 9", SP="MUT", year = 2020,OUT=TRUE, species_list = SSPP, verbose = TRUE)
  }

  Area <- Implementation.year <- Species <- Achieved.number.of.individuals.measured.at.national.level <- country <- area <- in.year <- ref.year <- species <- sex <- sample_size <- NULL

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
    GSA <- as.numeric(gsub("\\D", "", GSA))
    GSA <- paste("GSA" ,GSA,sep=" ")
    GSA <- GSA[GSA %in% paste("GSA", as.numeric(GSAlist$GSA))]
    user_GSA <- TRUE
  }

  ### ML data
  # filter on country
  ML <- ML[ML$country == MS & ML$area %in% GSA, ]

  # filter on species
  if (nrow(ML) == 0) {
    if (verbose) {
      message("No data avilable in ML table for the selected country")
    }
    quit <- TRUE
  } else {
    if (all(is.na(SP))) {
      SP <- sort(unique(ML$species))
      user_SP <- FALSE
    } else {
      SP <- SP[!is.na(SP)]
      SP <- SP[SP %in% unique(SPs$X3A_CODE)]
      user_SP <- TRUE
    }
    ML <- ML[ML$species %in% SP, ]
  } # nrow(ML) > 0

  # filter on year

  if (quit | nrow(ML) == 0) {
    if (verbose) {
      message("No ML data avilable for the analysis")
    }
    quit <- TRUE
  } else {
    ML$ref.year <- NA
    ML$in.year <- NA
    i <- 1

    for (i in 1:nrow(ML)) {
      if (ML$start_year[i] <= year & year <= ML$end_year[i]) {
        ML$in.year[i] <- year
      }
      ML$ref.year[i] <- ifelse(ML$start_year[i] == ML$end_year[i], ML$start_year[i], paste(ML$start_year[i], ML$end_year[i], sep = "-"))
    }
    ML <- ML[!is.na(ML$in.year) & ML$in.year == year & ML$sample_size != -1, ]
  } # nrow(ML) > 0

  #------------------
  ### AR data
  # AR[!is.na(AR$Area) & AR$Area == "GSA11", "Area"] <- "GSA 11"

  # filter on country
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
    AR <- AR[grep("maturity",tolower(AR$Biological.variable)), ]
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

  if (nrow(AR) > 0 & nrow(ML) > 0 & !quit & !quit_AR) {

    #-------------------
    # ANNUAL REPORT data
    #-------------------
    AR1 <- suppressMessages(
      AR %>%
        group_by(MS, Area, Implementation.year, Species) %>%
        summarise(numb.maturity.ML = sum(Achieved.number.of.individuals.measured.at.national.level, na.rm = TRUE))
    )
    colnames(AR1) <- c("Country", "Area", "Year", "Species", "maturity.AR")

    #--------------------
    # MED & BS ML data
    #--------------------
    if (any(!unique(ML$species) %in% SP_COUNTRY)) {
      ML_GSA <- suppressMessages(
        ML[!ML$species %in% SP_COUNTRY, ] %>% group_by(country, area, in.year, ref.year, species, sex) %>%
          summarise(numb.maturity.AR = sum(sample_size, na.rm = TRUE))
      )
      colnames(ML_GSA) <- c("Country", "Area", "Year", "Sample.Year.ML", "Species", "Sex", "numb.maturity.ML")
    }
    if (any(unique(ML$species) %in% SP_COUNTRY)) {
      ML_COUNTRY <- ML[ML$species %in% SP_COUNTRY, ]
      ML_COUNTRY$area <- MS
      ML_COUNTRY <- suppressMessages(
        ML_COUNTRY %>% group_by(country, area, in.year, ref.year, species, sex) %>%
          summarise(numb.maturity.AR = sum(sample_size, na.rm = TRUE))
      )
      colnames(ML_COUNTRY) <- c("Country", "Area", "Year", "Sample.Year.ML", "Species", "Sex", "numb.maturity.ML")
    }

    if (!exists("ML_COUNTRY") & exists("ML_GSA")) {
      ML_tab <- ML_GSA
    }
    if (!exists("ML_GSA") & exists("ML_COUNTRY")) {
      ML_tab <- ML_COUNTRY
    }
    if (exists("ML_COUNTRY") & exists("ML_GSA")) {
      ML_tab <- rbind(ML_COUNTRY, ML_GSA)
    }

    ML_tab_f <- dcast(ML_tab, Country + Area + Year + Sample.Year.ML + Species ~ Sex, value.var = "numb.maturity.ML")
    colnames(ML_tab_f)[6:ncol(ML_tab_f)] <- paste(colnames(ML_tab_f)[6:ncol(ML_tab_f)], "_maturity_ML", sep = "")

    if (! "F_maturity_ML" %in% colnames(ML_tab_f) ) {
      ML_tab_f$F_maturity_ML <- NA
    }

    if (! "M_maturity_ML" %in% colnames(ML_tab_f) ) {
      ML_tab_f$M_maturity_ML <- NA
    }

    if (! "C_maturity_ML" %in% colnames(ML_tab_f) ) {
      ML_tab_f$C_maturity_ML <- NA
    }


    tab <- suppressMessages(ML_tab_f %>% full_join(AR1))

    tab$warnings <- NA
    tab$errors <- NA

    n <- 146
    for (n in 1:nrow(tab)) {
      if (!tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        tab[n, "warnings"] <- "species not present in MEDBS data call list"
      }
      if (tab[n, "Species"] %in% unique(AR$Species)) {
        if (tab[n, "Area"] == MS & is.na(tab$maturity.AR[n])) {
          tab[n, "warnings"] <- paste(tab[n, "warnings"], "species expected in WP", sep = " - ")
        } else if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) & is.na(tab$maturity.AR[n])) {
          tab[n, "warnings"] <- "species expected in WP"
        }
      }

      if (tab[n, "Species"] %in% unique(AR$Species) & tab[n, "Species"] %in% unique(SPs[!is.na(SPs$MEDBS), "MEDBS"])) {
        # common species in MEDBS and AR with no data in AR
        if (tab[n, "Area"] == MS &
          (is.na(tab$maturity.AR[n]) | tab$maturity.AR[n] == 0) &
          !(is.na(tab$C_maturity_ML[n]) &
            is.na(tab$F_maturity_ML[n]) &
            is.na(tab$M_maturity_ML[n]))) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (is.na(tab$maturity.AR[n]) | tab$maturity.AR[n] == 0) &
          !(is.na(tab$C_maturity_ML[n]) &
            is.na(tab$F_maturity_ML[n]) &
            is.na(tab$M_maturity_ML[n]))) {
          tab[n, "errors"] <- "species present in MEDBS and not in AR"
        }
        # common species in MEDBS and AR with no data in MEDBS
        if (tab[n, "Area"] == MS &
          (!is.na(tab$maturity.AR[n]) & tab$maturity.AR[n] != 0) &
          (is.na(tab$C_maturity_ML[n]) &
            is.na(tab$F_maturity_ML[n]) &
            is.na(tab$M_maturity_ML[n]))) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        } else
        if (tab[n, "Area"] %in% unique(AR[AR$Species == tab[n, "Species"], "Area"]) &
          (!is.na(tab$maturity.AR[n]) & tab$maturity.AR[n] != 0) &
          (is.na(tab$C_maturity_ML[n]) &
            is.na(tab$F_maturity_ML[n]) &
            is.na(tab$M_maturity_ML[n]))) {
          tab[n, "errors"] <- "species present in AR and not in MEDBS"
        }
      }
    }

    tab_no_MEDBS <- tab[is.na(tab$C_maturity_ML) &
      is.na(tab$F_maturity_ML) &
      is.na(tab$M_maturity_ML) &
      (!is.na(tab$maturity.AR) & tab$maturity.AR != 0), ]
    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_MEDBS, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_Maturity_comparison_Data_not_in_MEDBS_", MS, ".csv"), row.names = F)
    }

    tab <- tab[!(is.na(tab$C_maturity_ML) &
      is.na(tab$F_maturity_ML) &
      is.na(tab$M_maturity_ML)), ]

    tab_no_AR <- tab[is.na(tab$maturity.AR) | tab$maturity.AR == 0, ]
    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_no_AR, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_Maturity_comparison_Data_not_in_AR_", MS, ".csv"), row.names = F)
    }

    tab <- tab[!is.na(tab$maturity.AR) & tab$maturity.AR != 0, ]

    tab_match <- tab[!(is.na(tab$C_maturity_ML) &
      is.na(tab$F_maturity_ML) &
      is.na(tab$M_maturity_ML)) &
      (!is.na(tab$maturity.AR & tab$maturity.AR != 0)
      ), ]
    if (OUT %in% TRUE) {
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(tab_match, paste0(WD,"/OUTPUT/CSV/MEDBS_AR_Maturity_comparison_Matching_data_", MS, ".csv"), row.names = F)
    }

    output <- list(tab_match, tab_no_MEDBS, tab_no_AR)
    names(output) <- c("Species_matches", "Species_not_in_MEDBS", "Species_not_in_AR")
    return(output)
  } else { # (nrow(AR) > 0 & nrow(ML) > 0 & !quit & !quit_AR)
    if (nrow(ML) == 0) {
      if (verbose) {
        message("No ML data available. The analysis was not completed.")
      }
    }
    if (nrow(AR) == 0) {
      if (verbose) {
        message("No AR data available. The analysis was not completed.")
      }
    }
  } # (nrow(AR) > 0 & nrow(ML) > 0 & !quit & !quit_AR)
}
