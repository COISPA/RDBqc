#' Cross check of landings or landings' value between the FDI and AER databases
#' @param FDI (mandatory) data frame containing FDI catch data (i.e. TABLE_A_CATCH)
#' @param AER (mandatory) data frame containing AER catch data (i.e. map_fsfao)
#' @param var (mandatory) string to select the variable of interest. Use either 'landings' for landings
#' or 'value' for landings' value.
#' @param MS (mandatory) The MS code (e.g. 'GRC'). Only one MS code is allowed.
#' @param level (optional) character to select the level of aggregation of variable 'var', i.e.
#' 'MS', 'GSA', 'GEAR' or 'METIER'. E.g. if level 'GEAR' is selected, the comparison
#' will be performed by 'MS', 'GSA' and 'GEAR'. Default level is 'METIER'.
#' @param YEAR (optional) vector of years to perform the check on. Default is NA, which will produce a check for all
#' the years found in both data frames
#' @param GSA (optional) vector string of GSAs for the given MS to produce the check on (e.g. GSA = c('GSA20', 'GSA22')).
#' Default is NA, which will produce the check for all GSAs existing in the data frames.
#' @param SP (optional) vector string of species FAO 3-alpha codes to produce the checks on (e.g. SPECIES = c('DPS', 'TGS')).
#' Default is NA, which will produce the check for all SP existing in the data frames.
#' @param OUT If set as TRUE a table in csv will be saved in the OUTPUT folder created in the working directory. Default is FALSE
#' @param verbose (optional) boolean, if TRUE messages are printed. Default is FALSE.
#' @description The function compares landings (var='landings') or landings' value (var='value) by SP and YEAR between
#' the FDI and AER databases for the given MS. By default, the comparison is done by GSA, GEAR and METIER.
#' Optionally, the user can select a higher level of aggregation (e.g. 'MS', 'GSA', etc.) (see level variable)
#' @return The function returns a data frame containing all entries found in FDI, in AER and in both dataframes,
#' with the last column reporting the ratio FDI/AER for the selected var. This ratio equals 1 if the two entries
#' are the same, differs from 1 if the two entries differ or is NA if the entry is missing in one of the two dataframes.
#' This output table is also saved in .csv files if OUT is TRUE.
#' @export FDI_AER_land_landvalue
#' @author Vasiliki Sgardeli <vsgard@hcmr.gr>
#' @importFrom utils write.csv
#' @examples FDI_AER_land_landvalue(FDI=fdi_a_catch, AER=aer_catch, var='landings',
#' level='GEAR', MS='PSP', YEAR=NA, GSA=c('GSA97', 'GSA98'), SP=NA, OUT = TRUE, verbose = TRUE)
FDI_AER_land_landvalue <- function (FDI, AER, var = "landings", MS, level = "GSA", YEAR = NA,
          GSA = NA, SP = NA, OUT = FALSE, verbose = FALSE)
{
  species <- country <- country_code <- acronym <- var_FDI <- var_AER <- NULL
  FDI <- as.data.frame(FDI)
  AER <- as.data.frame(AER)
  colnames(FDI) <- tolower(colnames(FDI))
  colnames(AER) <- tolower(colnames(AER))
  if (!"country_code" %in% colnames(AER)) {
    AER$country_code <- MS
  }
  if ("variable_code" %in% colnames(AER)) {
    colnames(AER)[which(colnames(AER) == "variable_code")] <- "acronym"
  }
  if ("species_code" %in% colnames(AER)) {
    colnames(AER)[which(colnames(AER) == "species_code")] <- "species"
  }
  if ("sub_reg" %in% colnames(AER)) {
    colnames(AER)[which(colnames(AER) == "sub_reg")] <- "sub_region"
  }

  ### adaptation for new FDI table structure ------
  colnames(FDI) <- tolower(colnames(FDI))
  if ("latitude" %in% colnames(FDI)) {
    colnames(FDI)[which(colnames(FDI)=="latitude")] <- "rectangle_lat"
  }
  if ("longitude" %in% colnames(FDI)) {
    colnames(FDI)[which(colnames(FDI)=="longitude")] <- "rectangle_lon"
  }
  if ("metier_7" %in% colnames(FDI)) {
    FDI <- FDI[ , -(which(colnames(FDI)%in% "metier_7"))]
  }
  #-----------------------------------------------

  if (var == "landings") {
    var1 <- "totwghtlandg"
  }else if (var == "value") {
    var1 <- "totvallandg"
  }else {
    stop("incorrect argument to variable 'var'. Use either 'landings' or 'value'")
  }
  if (!(MS %in% FDI$country)) {
    stop("Member state '", MS, "' not existing in provided FDI data frame")
  }
  data1 <- subset(FDI, country == MS)
  data2 <- subset(AER, country_code == MS)
  if (nrow(data1) == 0 | nrow(data2) == 0) {
    stop("One or both of input data frames are empty")
  }
  data1$sub_region <- gsub("[^0-9]", "", data1$sub_region)
  data2$sub_region <- gsub("[^0-9]", "", data2$sub_region)
  if (!is.na(GSA)[1]) {
    GSA <- gsub("[^0-9]", "", GSA)
    data1 <- data1[data1$sub_region %in% GSA, ]
    data2 <- data2[data2$sub_region %in% GSA, ]
    for (i in 1:length(GSA)) {
      if (sum(data1$sub_region == GSA[i]) == 0) {
        print("Error: Selected COUNTRY and GSA combination doesn't exist in FDI")
        opt <- options(show.error.messages = FALSE)
        on.exit(options(opt))
        stop()
      }
    }
  }
  if ((!is.na(SP)[1])) {
    data1 <- subset(data1, species == SP)
    data2 <- subset(data2, species == SP)
    if (nrow(data1) == 0 | nrow(data2) == 0) {
      stop("One or both of input data frames are empty")
    }
  }
  level <- toupper(level)
  namelevel <- c("MS", "GSA", "GEAR", "METIER")
  if (!(level %in% namelevel)) {
    level <- "METIER"
    print("warning: Invalid value provided to 'level' argument. Proceeding with default level=METIER")
  }
  if (verbose) {
    namesub <- c(paste0("for ", toString(SP)), paste0("in GSA ",
                                                      toString(GSA)), paste0("in year(s) ", toString(YEAR)))
    sub <- which(c(sum(!is.na(YEAR)), sum(!is.na(GSA)), sum(!is.na(SP))) !=
                   0)
    if (length(sub) != 0) {
      namesub <- toString(namesub[sub])
    }else{
      namesub <- ""
    }
    print(paste0("***Cross-check ", MS, " ", var, " between FDI and AER databases at ",
                 level, " level", " ", namesub, "***"))
  }
  gsas1 <- data1$sub_region
  yrs1 <- data1$year
  gsas2 <- data2$sub_region
  yrs2 <- data2$year
  na1 <- which(is.na(gsas1))
  na1a <- which(is.na(yrs1))
  na2 <- which(is.na(gsas2))
  na2a <- which(is.na(yrs2))
  if (verbose) {
    if (length(na1) != 0) {
      message(paste("Found NAs in FDI SUB_REGIONS in",
                    length(na1), "rows"))
    }
    if (length(na1a) != 0) {
      message(paste("Found NAs in FDI Years in", length(na1a),
                    "rows"))
    }
    if (length(na2) != 0) {
      message(paste("Found NAs in AER SUB_REGIONS in",
                    length(na2), "rows"))
    }
    if (length(na2a) != 0) {
      message(paste("Found NAs in AER Years in", length(na2a),
                    "rows"))
    }
  }
  data1[which(data1 == "NK", arr.ind = T)] <- NA
  data2[which(data2 == "NK", arr.ind = T)] <- NA
  data1$totwghtlandg <- suppressWarnings(as.numeric(data1$totwghtlandg))
  data1$totvallandg <- suppressWarnings(as.numeric(data1$totvallandg))
  data2$value <- suppressWarnings(as.numeric(data2$value))
  sumfun <- function(x) {
    if (all(is.na(x))) {
      NA
    }else {
      sum(x, na.rm = TRUE)
    }
  }
  if (level == "MS") {
    tabA <- aggregate(list(var_FDI = data1[[var1]]), by = list(year = data1$year,
                                                               species = data1$species), FUN = sumfun)
    if (var == "landings") {
      tabA$var_FDI <- tabA$var_FDI * 1000
    }
    tabB <- subset(data2, acronym == var1)
    tabB <- aggregate(list(var_AER = tabB$value), by = list(year = tabB$year,
                                                            species = tabB$species), FUN = sumfun)
  }else if (level == "GSA") {
    tabA <- aggregate(list(var_FDI = data1[[var1]]), by = list(year = data1$year,
                                                               gsa = data1$sub_region, species = data1$species),
                      FUN = sumfun)
    if (var == "landings") {
      tabA$var_FDI <- tabA$var_FDI * 1000
    }
    tabB <- subset(data2, acronym == var1)
    tabB <- aggregate(list(var_AER = tabB$value), by = list(year = tabB$year,
                                                            gsa = tabB$sub_region, species = tabB$species), FUN = sumfun)
  }else if (level == "GEAR") {
    tabA <- aggregate(list(var_FDI = data1[[var1]]), by = list(year = data1$year,
                                                               gsa = data1$sub_region, species = data1$species,
                                                               fishing_tech = data1$fishing_tech), FUN = sumfun)
    if (var == "landings") {
      tabA$var_FDI <- tabA$var_FDI * 1000
    }
    tabB <- subset(data2, acronym == var1)
    tabB <- aggregate(list(var_AER = tabB$value), by = list(year = tabB$year,
                                                            gsa = tabB$sub_region, species = tabB$species, fishing_tech = tabB$fishing_tech),
                      FUN = sumfun)
  }else if (level == "METIER") {
    tabA <- aggregate(list(var_FDI = data1[[var1]]), by = list(year = data1$year,
                                                               gsa = data1$sub_region, species = data1$species,
                                                               fishing_tech = data1$fishing_tech, vessel_length = data1$vessel_length),
                      FUN = sumfun)
    if (var == "landings") {
      tabA$var_FDI <- tabA$var_FDI * 1000
    }
    tabB <- subset(data2, acronym == var1)
    tabB <- aggregate(list(var_AER = tabB$value), by = list(year = tabB$year,
                                                            gsa = tabB$sub_region, species = tabB$species, fishing_tech = tabB$fishing_tech,
                                                            vessel_length = tabB$vessel_length), FUN = sumfun)
  }
  df <- merge(tabA, tabB, all.x = TRUE, all.y = TRUE)
  df1 <- df
  if (!is.na(SP)[1]) {
    fg <- SP %in% df$species
    if ((sum(fg) != length(SP)) & verbose) {
      x <- which(fg != TRUE)
      print(paste0("warning: Species ", toString(SP[x]),
                   " not existing in provided dataframes"))
    }
    df1 <- df1[which(df1$species %in% SP), ]
  }
  if (!is.na(YEAR)[1]) {
    fg <- YEAR %in% df$year
    if ((sum(fg) != length(YEAR)) & verbose) {
      x <- which(fg != TRUE)
      print(paste0("warning: Year(s) ", toString(YEAR[x]),
                   " not existing in provided dataframes"))
    }
    df1 <- df1[which(df1$year %in% YEAR), ]
  }
  if (!is.na(GSA)[1] & (level %in% namelevel[3:4])) {
    fg <- GSA %in% df$gsa
    if ((sum(fg) != length(GSA)) & verbose) {
      x <- which(fg != TRUE)
      print(paste0("warning: ", toString(GSA[x]), " not existing in provided dataframes"))
    }
    df1 <- df1[which(df1$gsa %in% GSA), ]
  }else if (!is.na(GSA)[1] & level == namelevel[1]) {
    print(paste0("warning: cross-check produced at ", level,
                 " level. GSA provided ingnored. To cross-check by GSA use level = 'GSA' "))
  }
  df2  <- subset(df1, !(is.na(var_FDI) & is.na(var_AER)))
  frac <- df2$var_FDI/df2$var_AER
  df2$"FDI/AER" <- round(frac,3)
  df3 <- subset(df2, (!is.na(var_FDI) & !is.na(var_AER)))
  df4 <- subset(df2, (is.na(var_FDI) & !is.na(var_AER)))
  df5 <- subset(df2, (!is.na(var_FDI) & is.na(var_AER)))
  if (verbose) {
      if (nrow(df3) == 0) {
         print("No common combinations to compare between FDI and AER")
      }else{
        if (sum(df3$"FDI/AER") == nrow(df3)) {
          print("No mismatches between FDI and AER for common combinations")
        }else{
          print(paste0("There were ", length(which(df3$"FDI/AER"!=1)), " cases with mismatch in reported ",
                       var, " between FDI and AER. Check '", var,
                       "_check_FDI_AER_", level, "_level.csv'"))
        }
      }
      if (nrow(df4) != 0) {
          print(paste0("There were ", nrow(df4), " entries reported in AER not found in FDI. Check '",
                   var, "_check_FDI_AER_", level, "_level.csv'"))
      }
      if (nrow(df5) != 0) {
          print(paste0("There were ", nrow(df5), " entries reported in FDI not found in AER. Check '",
                   var, "_check_FDI_AER_", level, "_level.csv'"))
      }
  }
  if (OUT %in% TRUE) {
    WD <- getwd()
    suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"),
                                recursive = T))
    write.csv(df2, file.path(paste0(WD, "/OUTPUT/CSV"),
                                  paste0(MS,'_' ,var, "_check_FDI_AER_", level, "_level.csv")),
              row.names = F)
  }
  output   <- df2
  return(output)
}
