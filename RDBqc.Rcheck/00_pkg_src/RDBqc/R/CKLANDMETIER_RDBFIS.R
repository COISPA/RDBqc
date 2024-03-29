## Defining function
#' @title Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Metier
#' @param data data frame containing MEDBS landings by length table
#' @param data1 data frame containing FDI Table A Catch data
#' @param MS member state 3 alpha code
#' @param GSA FAO Geographical Sub Area code (GSA9, GSA29, etc)
#' @param SP ASFIS FAO 3alpha code of the choosen species
#' @param MEDBSSP look up table in which requested MEDBS Data Call species (see MEDBS data call Annex I) are listed
#' @param verbose boolean. If TRUE a message is printed
#' @param OUT Default is FALSE. If set as TRUE plots and tables in csv will be saved in the OUTPUT folder created in the working directory
#' @export Check_Tot_Land_metier
#' @importFrom dplyr summarize group_by
#' @importFrom data.table fread
#' @import ggplot2
#' @importFrom cowplot plot_grid
#' @description The function compares the landings in weight values reported in the MEDBS landings by length table with the one reported in the FDI Table A catch table. The analysis is done at MS, GSA, species and metier level
#' @return The function returns plots comparison by year of the landings in weight provided through the MEDBS and FDI Data Calls. Moreover a csv file with the actual values will be created. Plot, csv and rds output files will be saved in the dedicated folders in OUTPUT folder
#' @author Alessandro Mannini <alessandro.mannini@irbim.cnr.it>
#' @examples \donttest{
#' # Check_Tot_Land_metier(MEDBS, FDI, "ITA", "GSA10", "HKE", MEDBSSP, verbose = TRUE, OUT = FALSE)
#' }
#' # The function works by one country, subarea and species each.
#' # It is not possible assign more country, subarea or species.
Check_Tot_Land_metier <- function(data, data1, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = FALSE) {

  AREA <- COUNTRY <- DATA_CALL <- FISHERY <- GEAR <- GEAR_TYPE <- LANDINGS  <-  MESH_SIZE_RANGE <- SPECIES <- SUB_REGION <- TARGET_ASSEMBLAGE <- TOTWGHTLANDG <- YEAR <- NULL

  colnames(data) <- toupper(colnames(data))
  colnames(data1) <- toupper(colnames(data1))
  colnames(data1)[1] <- "COUNTRY"

  if (!SP %in% MEDBSSP$SPECIES) {
    print("Warning: selected species is not present in MEDBS data call list. Landings comparison for MEDBS could be not possible")
  }
  if (!SP %in% unique(data$SPECIES) & !SP %in% unique(data1$SPECIES)) {
    print("Error: selected species is not present in both Data Calls datasets. Landings comparison is not possible")
  }
  ## Modifying FDI code according to MEDBS
  GSA <- gsub(" ", "", GSA)
  data1$GEAR_TYPE[data1$GEAR_TYPE %in% c("NO", "NK")] <- "NA"
  data1$MESH_SIZE_RANGE[data1$MESH_SIZE_RANGE %in% c("NK")] <- "NA"
  data1$VESSEL_LENGTH[data1$VESSEL_LENGTH %in% c("NK")] <- "NA"
  data1$TARGET_ASSEMBLAGE[data1$TARGET_ASSEMBLAGE %in% c("NK")] <- "NA"
  data1$TARGET_ASSEMBLAGE[data1$TARGET_ASSEMBLAGE %in% c("DEF")] <- "DES"
  data1$QUARTER[data1$QUARTER %in% c("ALL")] <- -1
  data$FISHERY[data$FISHERY %in% c("DEF", "DEMSP")] <- "DES"
  data$AREA <- gsub(" ", "", data$AREA)
  data$LANDINGS[data$LANDINGS %in% c("-1", "NA", NA, "")] <- 0
  data1$TOTWGHTLANDG[data1$TOTWGHTLANDG %in% c("NA", NA, "", "NK")] <- 0
  data$LANDINGS <- as.numeric(data$LANDINGS)
  data1$TOTWGHTLANDG <- as.numeric(data1$TOTWGHTLANDG)

  id <- paste0(MS, "_", GSA, "_", SP)
  if (id %in% paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES) |
    id %in% paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES)) {
    data <- data[data$COUNTRY %in% MS & data$AREA %in% GSA & data$SPECIES %in% SP, ]
    data1 <- data1[data1$COUNTRY %in% MS & data1$SUB_REGION %in% GSA & data1$SPECIES %in% SP, ]
    compland <- list()
    if (nrow(data) > 0) {
      compland[[1]] <- setdiff(
        paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES, "_", data$GEAR, "_", data$FISHERY, "_", data$MESH_SIZE_RANGE),
        paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES, "_", data1$GEAR_TYPE, "_", data1$TARGET_ASSEMBLAGE, "_", data1$MESH_SIZE_RANGE)
      )
      names(compland)[[1]] <- paste("TABLE_LANDINGS_METIER_IN_MEDBS_NOT_IN_FDI", MS, GSA, SP, sep = "_")

      if (OUT %in% TRUE) {
        WD <- getwd()
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
        write.csv(setdiff(
          paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES, "_", data$GEAR, "_", data$FISHERY, "_", data$MESH_SIZE_RANGE),
          paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES, "_", data1$GEAR_TYPE, "_", data1$TARGET_ASSEMBLAGE, "_", data1$MESH_SIZE_RANGE)
        ),
        file = paste0(WD, "/OUTPUT/CSV/Metier_in_MEDBS_not_in_FDI_for_", MS, "_", GSA, "_", SP, ".csv"), row.names = F
        )
      }
    } else {
      print("Warning: selected species is not present in MEDBS dataset")
    }
    if (nrow(data1) > 0) {
      compland[[2]] <- setdiff(
        paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES, "_", data1$GEAR_TYPE, "_", data1$TARGET_ASSEMBLAGE, "_", data1$MESH_SIZE_RANGE),
        paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES, "_", data$GEAR, "_", data$FISHERY, "_", data$MESH_SIZE_RANGE)
      )
      names(compland)[[2]] <- paste("TABLE_LANDINGS_METIER_IN_FDI_NOT_IN_MEDBS", MS, GSA, SP, sep = "_")

      if (OUT %in% TRUE) {
        WD <- getwd()
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
        write.csv(setdiff(
          paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES, "_", data1$GEAR_TYPE, "_", data1$TARGET_ASSEMBLAGE, "_", data1$MESH_SIZE_RANGE),
          paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES, "_", data$GEAR, "_", data$FISHERY, "_", data$MESH_SIZE_RANGE)
        ),
        file = paste0(WD, "/OUTPUT/CSV/Metier in FDI not in MEDBS for ", MS, "_", GSA, "_", SP, ".csv"), row.names = F
        )
      }
    } else {
      print("Warning: selected species is not present in FDI dataset")
    }

    if (nrow(data) > 0) {
      data <- suppressMessages(data %>% group_by(YEAR, COUNTRY, AREA, SPECIES, GEAR, FISHERY, MESH_SIZE_RANGE) %>% summarize(TOT = sum(LANDINGS, na.rm = T)))
      db <- data.frame(
        "YEAR" = data$YEAR, "COUNTRY" = data$COUNTRY, "GSA" = data$AREA, "SPECIES" = data$SPECIES,
        "GEAR" = data$GEAR, "FISHERY" = data$FISHERY, "MESH" = data$MESH_SIZE_RANGE,
        "METIER" = paste0(data$GEAR, "_", data$FISHERY, "_", data$MESH_SIZE_RANGE),
        "LANDINGS" = data$TOT, "DATA_CALL" = "MEDBS"
      )
    } else {
      db <- data.frame(
        "YEAR" = integer(),
        "COUNTRY" = character(),
        "GSA" = character(),
        "SPECIES" = character(),
        "GEAR" = character(),
        "FISHERY" = character(),
        "MESH" = character(),
        "METIER" = character(),
        "LANDINGS" = double(),
        "DATA_CALL" = character(),
        stringsAsFactors = FALSE
      )
    }

    if (nrow(data1) > 0) {
      data1 <- suppressMessages(data1 %>% group_by(YEAR, COUNTRY, SUB_REGION, SPECIES, GEAR_TYPE, TARGET_ASSEMBLAGE, MESH_SIZE_RANGE) %>% summarize(TOT = sum(TOTWGHTLANDG, na.rm = T)))
      db1 <- data.frame(
        "YEAR" = data1$YEAR, "COUNTRY" = data1$COUNTRY, "GSA" = data1$SUB_REGION, "SPECIES" = data1$SPECIES,
        "GEAR" = data1$GEAR_TYPE, "FISHERY" = data1$TARGET_ASSEMBLAGE, "MESH" = data1$MESH_SIZE_RANGE,
        "METIER" = paste0(data1$GEAR_TYPE, "_", data1$TARGET_ASSEMBLAGE, "_", data1$MESH_SIZE_RANGE),
        "LANDINGS" = data1$TOT, "DATA_CALL" = "FDI"
      )
    } else {
      db1 <- data.frame(
        "YEAR" = integer(),
        "COUNTRY" = character(),
        "GSA" = character(),
        "SPECIES" = character(),
        "GEAR" = character(),
        "FISHERY" = character(),
        "MESH" = character(),
        "METIER" = character(),
        "LANDINGS" = double(),
        "DATA_CALL" = character(),
        stringsAsFactors = FALSE
      )
    }

    if (nrow(rbind(db, db1)) > 0) {
      compland[[3]] <- rbind(db, db1)
      names(compland)[[3]] <- paste(paste("TABLE_LANDINGS_METIER", MS, GSA, SP, sep = "_"))
      counter <- 4

      # write.csv(rbind(db,db1),paste0("../OUT/CSV/Landings metier comparison for ",MS,"_",GSA,"_",SP,".csv"),row.names = F)
      colorset <- c("FDI" = "red", "MEDBS" = "blue")
      for (i in union(db$METIER, db1$METIER)) {
        if (nrow(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]) > 0) {
          compland[[counter]] <- suppressMessages(plot_grid(
            ggplot(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ], aes(x = YEAR, y = DATA_CALL, col = DATA_CALL)) +
              geom_point() +
              ylab("") +
              xlab("") +
              scale_color_manual(values = colorset) +
              scale_x_continuous(breaks = seq(min(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), max(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), 1)) +
              theme_bw() +
              ggtitle(paste0("Time series available for ", MS, "_", GSA, "_", SP, "_", i)) +
              theme(legend.position = "none"),
            ggplot(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ], aes(x = YEAR, y = LANDINGS, col = DATA_CALL)) +
              geom_point() +
              geom_line() +
              ylab("Landings (t)") +
              scale_color_manual(values = colorset) +
              xlab("") +
              scale_x_continuous(breaks = seq(min(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), max(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), 1)) +
              theme_bw() +
              theme(legend.position = "bottom"),
            align = "v", nrow = 2, rel_heights = c(1 / 4, 1 / 2)
          ))
          names(compland)[[counter]] <- paste("PLOT_LANDINGS_METIER", i, MS, GSA, SP, sep = "_")
          counter <- counter + 1
        }
      }
      if (OUT %in% TRUE) {
        WD <- getwd()
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/PLOT"), recursive = T))
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
        write.csv(rbind(db, db1), file = paste0(WD, "/OUTPUT/CSV/Landings_metier_", MS, "_", GSA, "_", SP, ".csv"), row.names = FALSE)
        colorset <- c("FDI" = "red", "MEDBS" = "blue")
        for (i in union(db$METIER, db1$METIER)) {
          if (nrow(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]) > 0) {
            ggsave(paste0(WD, "/OUTPUT/PLOT/Landings metier comparison for ", MS, "_", GSA, "_", SP, "_", i, ".jpeg"),
              units = "in", width = 8, height = 4, dpi = 300,
              plot = suppressMessages(plot_grid(
                ggplot(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ], aes(x = YEAR, y = DATA_CALL, col = DATA_CALL)) +
                  geom_point() +
                  ylab("") +
                  xlab("") +
                  scale_color_manual(values = colorset) +
                  scale_x_continuous(breaks = seq(min(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), max(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), 1)) +
                  theme_bw() +
                  ggtitle(paste0("Time series available for ", MS, "_", GSA, "_", SP, "_", i)) +
                  theme(legend.position = "none"),
                ggplot(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ], aes(x = YEAR, y = LANDINGS, col = DATA_CALL)) +
                  geom_point() +
                  geom_line() +
                  ylab("Landings (t)") +
                  scale_color_manual(values = colorset) +
                  xlab("") +
                  scale_x_continuous(breaks = seq(min(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), max(rbind(db, db1)[rbind(db, db1)$METIER %in% i, ]$YEAR), 1)) +
                  theme_bw() +
                  theme(legend.position = "bottom"),
                align = "v", nrow = 2, rel_heights = c(1 / 4, 1 / 2)
              ))
            )
          }
        }
      }
      if (length(compland) != 0) {
        return(compland)
      }
    } else {
      print("Error: it isn't possible any comparison.")
    }
  } else {
    print("Error: selected MS,GSA and Species combination doesn't exist.")
  }
}
