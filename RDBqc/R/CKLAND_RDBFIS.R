#' @title Comparing total landings in weight between MEDBS and FDI EU Data Calls
#' @param data data frame containing MEDBS landings by length table
#' @param data1 data frame containing FDI Table A Catch data
#' @param MS member state 3 alpha code
#' @param GSA FAO Geographical Sub Area code (GSA9, GSA29, etc)
#' @param SP ASFIS FAO 3alpha code of the choosen species
#' @param MEDBSSP look up table in which requested MEDBS Data Call species (see MEDBS data call Annex I) are listed
#' @param verbose boolean. If TRUE a message is printed
#' @param OUT Default is FALSE. If set as TRUE plots and tables in csv will be saved in the OUTPUT folder created in the working directory
#' @export Check_Tot_Land
#' @importFrom dplyr summarize group_by
#' @importFrom data.table fread
#' @import ggplot2
#' @importFrom cowplot plot_grid
#' @description The function compares the landings in weight values reported in the MEDBS landings by length table with the one reported in the FDI Table A catch table. The analysis is done at MS, GSA and species level
#' @return The function returns a plot comparison by year of the landings in weight provided through the MEDBS and FDI Data Calls. Moreover a csv file with the actual values will be created. Plot, csv and rds output files will be saved in the dedicated folders in OUTPUT folder
#' @author Alessandro Mannini <alessandro.mannini@irbim.cnr.it>
#' @examples \donttest{
#' # Check_Tot_Land(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)
#' }
#' # The function works by one country, subarea and species each.
#' # It is not possible assign more country, subare or species.
Check_Tot_Land <- function(data, data1, MS, GSA, SP, MEDBSSP, verbose = FALSE, OUT = FALSE) {
  AREA <- COUNTRY <- DATA_CALL <- LANDINGS <- SPECIES <- SUB_REGION <- TOTWGHTLANDG <- YEAR <- NULL

  ## Assigning "update" column name to be sure that templates are in compliance with the ones officially set for the two data calls
  colnames(data) <- toupper(colnames(data))
  colnames(data1) <- toupper(colnames(data1))
  colnames(data1)[1] <- "COUNTRY"
  compland <- list()
  colorset <- c("FDI" = "red", "MEDBS" = "blue")

  if (!SP %in% MEDBSSP$SPECIES) {
    print("Warning: selected species is not present in MEDBS data call list. Landings comparison for MEDBS could be not possible")
  }
  if (!SP %in% unique(data$SPECIES) & !SP %in% unique(data1$SPECIES)) {
    print("Error: selected species is not present in both Data Calls datasets. Landings comparison is not possible")
  }
  ## Modifying codes to allign them among the data calls
  data$AREA <- gsub(" ", "", data$AREA)
  data$LANDINGS[data$LANDINGS %in% c("-1", "NA", NA, "")] <- 0
  data1$TOTWGHTLANDG[data1$TOTWGHTLANDG %in% c("NA", NA, "", "NK")] <- 0

  id <- paste0(MS, "_", GSA, "_", SP)
  if (id %in% c(unique(paste0(data$COUNTRY, "_", data$AREA, "_", data$SPECIES))) | id %in% c(unique(paste0(data1$COUNTRY, "_", data1$SUB_REGION, "_", data1$SPECIES)))) {
    data <- data[data$COUNTRY %in% MS & data$AREA %in% GSA & data$SPECIES %in% SP, ]
    if (nrow(data) > 0) {
      data <- suppressMessages(data %>% group_by(YEAR, COUNTRY, AREA, SPECIES) %>% summarize(TOT = sum(LANDINGS, na.rm = T)))
      db <- data.frame("YEAR" = data$YEAR, "COUNTRY" = data$COUNTRY, "GSA" = data$AREA, "SPECIES" = data$SPECIES, "LANDINGS" = data$TOT, "DATA_CALL" = "MEDBS")
    } else {
      db <- data.frame(
        "YEAR" = integer(),
        "COUNTRY" = character(),
        "GSA" = character(),
        "SPECIES" = character(),
        "LANDINGS" = double(),
        "DATA_CALL" = character(),
        stringsAsFactors = FALSE
      )
    }
    data1 <- data1[data1$COUNTRY %in% MS & data1$SUB_REGION %in% GSA & data1$SPECIES %in% SP, ]
    if (nrow(data1) > 0) {
      data1 <- suppressMessages(data1 %>% group_by(YEAR, COUNTRY, SUB_REGION, SPECIES) %>% summarize(TOT = sum(TOTWGHTLANDG, na.rm = T)))
      db1 <- data.frame("YEAR" = data1$YEAR, "COUNTRY" = data1$COUNTRY, "GSA" = data1$SUB_REGION, "SPECIES" = data1$SPECIES, "LANDINGS" = data1$TOT, "DATA_CALL" = "FDI")
    } else {
      db1 <- data.frame(
        "YEAR" = integer(),
        "COUNTRY" = character(),
        "GSA" = character(),
        "SPECIES" = character(),
        "LANDINGS" = double(),
        "DATA_CALL" = character(),
        stringsAsFactors = FALSE
      )
    }

    if (nrow(rbind(db, db1)) > 0) {
      # compland <- list()
      counter <- 1
      compland[[counter]] <- rbind(db, db1)
      names(compland)[[counter]] <- paste(paste("TABLE_LANDINGS", MS, GSA, SP, sep = "_"))
      compland[[counter + 1]] <- plot_grid(ggplot(rbind(db, db1), aes(x = YEAR, y = DATA_CALL, col = DATA_CALL)) +
        geom_point() +
        ylab("") +
        xlab("") +
        scale_color_manual(values = colorset) +
        scale_x_continuous(breaks = seq(min(rbind(db, db1)$YEAR), max(rbind(db, db1)$YEAR), 1)) +
        theme_bw() +
        ggtitle(paste0("Time series available for ", MS, " ", GSA, " ", SP)) +
        theme(legend.position = "none"),
      ggplot(rbind(db, db1), aes(x = YEAR, y = LANDINGS, col = DATA_CALL)) +
        geom_point() +
        geom_line() +
        ylab("Landings (t)") +
        scale_color_manual(values = colorset) +
        xlab("") +
        scale_x_continuous(breaks = seq(min(rbind(db, db1)$YEAR), max(rbind(db, db1)$YEAR), 1)) +
        theme_bw() +
        theme(legend.position = "bottom"),
      align = "v", nrow = 2, rel_heights = c(1 / 4, 1 / 2)
      )
      names(compland)[[counter + 1]] <- paste("PLOT_LANDINGS", MS, GSA, SP, sep = "_")

      if (OUT %in% TRUE) {
        WD <- getwd()
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/PLOT"), recursive = T))
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
        ggsave(paste0(WD, "/OUTPUT/PLOT/Landings_", MS, "_", GSA, "_", SP, ".jpeg"),
          units = "in", width = 8, height = 4, dpi = 300,
          plot = plot_grid(
            ggplot(rbind(db, db1), aes(x = YEAR, y = DATA_CALL, col = DATA_CALL)) +
              geom_point() +
              ylab("") +
              xlab("") +
              scale_color_manual(values = colorset) +
              scale_x_continuous(breaks = seq(min(rbind(db, db1)$YEAR), max(rbind(db, db1)$YEAR), 1)) +
              theme_bw() +
              ggtitle(paste0("Time series available for ", MS, "_", GSA, "_", SP)) +
              theme(legend.position = "none"),
            ggplot(rbind(db, db1), aes(x = YEAR, y = LANDINGS, col = DATA_CALL)) +
              geom_point() +
              geom_line() +
              ylab("Landings (t)") +
              scale_color_manual(values = colorset) +
              xlab("") +
              scale_x_continuous(breaks = seq(min(rbind(db, db1)$YEAR), max(rbind(db, db1)$YEAR), 1)) +
              theme_bw() +
              theme(legend.position = "bottom"),
            align = "v", nrow = 2, rel_heights = c(1 / 4, 1 / 2)
          )
        )
        write.csv(rbind(db, db1), file = paste0(WD, "/OUTPUT/CSV/Landings_", MS, "_", GSA, "_", SP, ".csv"), row.names = FALSE)
      } else {
        print("")
      }
    }
    ifelse(OUT %in% TRUE, print("Landings comparison has been done. Please check outputs in OUTPUT folder."),
      print("Landings comparison has been done.")
    )
  } else {
    print("Error: selected MS,GSA and Species combination doesn't exist.")
  }
  if (length(compland) != 0) {
    return(compland)
  } else {
    print("Error: it isn't possible any comparison.")
  }
}
