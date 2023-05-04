#' Cross check of landings or landings' value between the FDI and AER databases
#' @param FDI (mandatory) data frame containing FDI catch data (i.e. TABLE_A_CATCH)
#' @param AER (mandatory) data frame containing AER catch data (i.e. map_fsfao)
#' @param var (mandatory) string to select the variable of interest. Use either 'landings' for landings
#' or 'value' for landings' value.
#' @param MS (mandatory) The MS code (e.g. 'GRC'). Only one MS code is allowed.
#' @param level (optional) integer 0-3 to select the level of aggregation of variable 'var'.
#' 0: 'MS', 1: 'GSA', 2: 'FISHING_TECH', 3: 'VESSEL_LENGTH'. E.g. if level = 2 is selected, the comparison
#' will be performed by 'MS', 'GSA' and 'FISHING_TECH'. Default level is 3.
#' @param YEAR (optional) vector of years to perform the check on. Default is NA, which will produce a check for all
#' the years found in both data frames
#' @param GSA (optional) vector string of GSAs for the given MS to produce the check on (e.g. GSA = c('GSA20', 'GSA22')).
#' Default is NA, which will produce the check for all GSAs existing in the data frames.
#' @param SP (optional) vector string of species FAO 3-alpha codes to produce the checks on (e.g. SPECIES = c('DPS', 'TGS')).
#' Default is NA, which will produce the check for all SP existing in the data frames.
#' @param OUT Default is FALSE. If set as TRUE tables in csv will be saved in the OUTPUT folder created in the working directory
#' @param verbose (optional) boolean, if TRUE messages are printed. Default is TRUE.
#' @description The function compares landings (var='landings') or landings' value (var='value) by SP and YEAR between
#' the FDI and AER databases for the given MS. By default, the comparison is done by GSA, FISHING_TECH and VESSEL_LENGTH.
#' Optionally, the user can select a higher level of aggregation (e.g. 'MS', 'GSA', etc.) (see level variable)
#' @return The function returns a list of three data frames, containing: a) entries for which 'var' differs between
#' the two data frames (mismatch_FDI_AER), b) entries in AER that are missing from FDI (missing_FDI) and
#' c) entries in DFI that are missing from AER (missing_AER). This output is also saved in .csv files if OUT is TRUE.
#' @export FDI_AER_land_landvalue
#' @author Vasiliki Sgardeli <vsgard@hcmr.gr>
#' @importFrom scales label_percent
#' @importFrom utils write.csv
#' @examples FDI_AER_land_landvalue(FDI=fdi_a_catch, AER=aer_catch, var='landings',
#' level=2, MS='PSP', GSA=c('GSA97', 'GSA98'), verbose = FALSE)
FDI_AER_land_landvalue <- function(FDI, AER, var='landings', MS, level=3,  YEAR=NA, GSA=NA, SP=NA, OUT=FALSE, verbose = FALSE){
  FDI <- as.data.frame(FDI)
  AER <- as.data.frame(AER)
  colnames(FDI) <- tolower(colnames(FDI))
  colnames(AER) <- tolower(colnames(AER))

  # STEP1: SEVERAL CHECKS on input data and function arguments

  # check variable var provided
  if (var =='landings'){
    var1 <- 'totwghtlandg'
    FDI$totwghtlandg <- as.numeric(FDI$totwghtlandg)
  } else if (var == 'value') {
    var1 <- 'totvallandg'
  } else {
    stop("incorrect argument to variable 'var'. Use either 'landings' or 'value'")
  }

  # subset for MS and check MS is existing
  if (!(MS %in% FDI$country)){
    stop("Member state '", MS, "' not existing in provided FDI data frame")
  }
  data1   <- subset(FDI, country == MS)
  if ('country' %in% colnames(AER)){
    data2 <- subset(AER, country == MS)
  } else {
    data2 <- AER
  }

  # check provided data sets are not empty
  if (nrow(data1)==0 | nrow(data2)==0){
    stop("One or both of input data frames are empty")
  }

  # check level argument if provided
  namelevel <- c('MS', 'GSA', 'FISHING_TECH', 'VESSEL_LENGTH')
  # level of aggregation
  if (! (level %in% c(0, 1, 2, 3)) ){
    level = 3
    print("warning: Invalid value provided to 'level' argument. Proceeding with default level=3 (VESSEL_LENGTH)")
  }

  # print title of check
  namesub <- c('YEAR', 'GSA', 'SP')
  if (verbose){
    sub <- which(c(sum(!is.na(YEAR)), sum(!is.na(GSA)), sum(!is.na(SP)))!=0)
    if (length(sub)!=0){
      name <- paste0('for selected ', toString(namesub[sub]))
    }  else {
      name <- ''
    }
    print(paste0('***Cross-check ', MS, ' ',  var, ' between FDI and AER databases at ', namelevel[level+1] ,' level', ' ',name, '***'))
  }

  country <- acronym <- var_FDI <- var_AER <- NULL

  # check for NAs in gsas or years reported
  gsas1 <- data1$sub_region
  yrs1  <- data1$year
  gsas2 <- data2$sub_region
  yrs2  <- data2$year

  na1  <- which(is.na(gsas1))
  na1a <- which(is.na(yrs1))
  na2  <- which(is.na(gsas2))
  na2a <- which(is.na(yrs2))

  if (verbose) {
    if (length(na1)!=0) {message(paste('Found NAs in FDI SUB_REGIONS in', length(na1), 'rows' )) }
    if (length(na1a)!=0) {message(paste('Found NAs in FDI Years in', length(na1a), 'rows' )) }
    if (length(na2)!=0) {message(paste('Found NAs in AER SUB_REGIONS in', length(na2), 'rows' )) }
    if (length(na2a)!=0) {message(paste('Found NAs in AER Years in', length(na2a), 'rows' )) }
  }

  # replace NKs with NAs
  data1[which(data1=='NK', arr.ind=T)] <- NA
  data2[which(data2=='NK', arr.ind=T)] <- NA

  FDI$totwghtlandg <- suppressWarnings(as.numeric(FDI$totwghtlandg))
  FDI$totvallandg  <- suppressWarnings(as.numeric(FDI$totvallandg))
  AER$value        <- suppressWarnings(as.numeric(AER$value))

  # STEP 2: Perform the aggregation of var. according to level of aggregation. If not provided the default level 3 is used
  sumfun <- function (x) {
    if(all(is.na(x))){
      NA
    }else{
      sum(x, na.rm=TRUE)
    }
  }

  if (level==0){ # MS
    tabA     <- aggregate(list(var_FDI=data1[[var1]]), by =list(year = data1$year, species=data1$species), FUN=sumfun)
    if(var=='landings') {tabA$var_FDI <- tabA$var_FDI*1000}
    tabB     <- subset(data2, acronym==var1)
    tabB     <- aggregate(list(var_AER=tabB$value), by =list(year = tabB$year, species=tabB$species), FUN=sumfun)
  } else if  (level==1){ # gsa
    tabA     <- aggregate(list(var_FDI=data1[[var1]]), by =list(year = data1$year, gsa= data1$sub_region, species=data1$species), FUN=sumfun)
    if(var=='landings') {tabA$var_FDI <- tabA$var_FDI*1000}
    tabB     <- subset(data2, acronym==var1)
    tabB     <- aggregate(list(var_AER=tabB$value), by =list(year = tabB$year, gsa= tabB$sub_region, species=tabB$species), FUN=sumfun)
    tabB$gsa <- paste0('GSA',substr(tabB$gsa, nchar(tabB$gsa)-1, nchar(tabB$gsa)))
  } else if (level==2){ # fishing tech
    tabA     <- aggregate(list(var_FDI=data1[[var1]]), by =list(year = data1$year, gsa= data1$sub_region, species=data1$species, fishing_tech = data1$fishing_tech), FUN=sumfun)
    if(var=='landings') {tabA$var_FDI <- tabA$var_FDI*1000}
    tabB     <- subset(data2, acronym==var1)
    tabB     <- aggregate(list(var_AER=tabB$value), by =list(year = tabB$year, gsa= tabB$sub_region, species=tabB$species, fishing_tech = tabB$fishing_tech), FUN=sumfun)
    tabB$gsa <- paste0('GSA',substr(tabB$gsa, nchar(tabB$gsa)-1, nchar(tabB$gsa)))
  } else if (level==3){ # vessel length
    tabA     <- aggregate(list(var_FDI=data1[[var1]]), by =list(year = data1$year, gsa= data1$sub_region, species=data1$species, fishing_tech = data1$fishing_tech, vessel_length=data1$vessel_length), FUN=sumfun)
    if(var=='landings') {tabA$var_FDI <- tabA$var_FDI*1000}
    tabB     <- subset(data2, acronym==var1)
    tabB     <- aggregate(list(var_AER=tabB$value), by =list(year = tabB$year, gsa= tabB$sub_region, species=tabB$species, fishing_tech = tabB$fishing_tech, vessel_length=tabB$vessel_length), FUN=sumfun)
    tabB$gsa <- paste0('GSA',substr(tabB$gsa, nchar(tabB$gsa)-1, nchar(tabB$gsa)))
  }

  # STEP 3: Merge tables
  df <- merge(tabA, tabB, all.x=TRUE, all.y=TRUE)

  # STEP 4: Subset table to user selection. Warning messages for non-existing values in original data frames
  df1 <- df
  if (!is.na(SP)[1]){
    fg  <- SP %in% df$species
    if ((sum(fg) != length(SP)) & verbose){
      x <- which(fg!=TRUE)
      print(paste0("warning: Species ", toString(SP[x]), " not existing in provided dataframes"))
    }
    df1 <- df1[which(df1$species %in% SP),]
  }

  if (!is.na(YEAR)[1]){
    fg  <- YEAR %in% df$year
    if ((sum(fg) != length(YEAR)) & verbose){
      x <- which(fg!=TRUE)
      print(paste0("warning: Year(s) ", toString(YEAR[x]), " not existing in provided dataframes"))
    }
    df1 <-  df1[which(df1$year %in% YEAR),]
  }

  if (!is.na(GSA)[1] & level >= 1){
    fg  <- GSA %in% df$gsa
    if ((sum(fg) != length(GSA)) & verbose){
      x <- which(fg!=TRUE)
      print(paste0("warning: ",toString(GSA[x]), " not existing in provided dataframes"))
    }
    df1 <-  df1[which(df1$gsa %in% GSA),]
  } else if (!is.na(GSA)[1] & level < 1) {
    print(paste0('warning: cross-check produced at ', namelevel[level+1], ' level. GSA provided ingnored. To cross-check by GSA use level = 1'))
  }

  # STEP5: Prepare output. Identify common combinations and produce errors (i.e. landings not equal between databases)
  df2 <- subset(df1, (!is.na(var_FDI) & !is.na(var_AER)))
  if (nrow(df2)==0){
    df2error <- df2
    if (verbose){
      print("No common combinations to compare between FDI and AER")
    }
  } else if (nrow(df2!=0)) {
    df2$'% diff' <- (scales::label_percent(1, accuracy = 0.0001, big.mark = ""))((df2$var_FDI - df2$var_AER)*100/df2$var_FDI)
    df2error     <- subset(df2, (df2$var_FDI-df2$var_AER) !=0)
    lerror       <- nrow(df2error)
    if (verbose){
      if(lerror==0){
        print("No mismatches between FDI and AER for common combinations")
      } else {
        print(paste0("There were ", lerror, " cases with mismatch in reported ", var, " between FDI and AER. Check '", var,"_mismatch_FDI_AER_",namelevel[level+1],"_level.csv'"))
      }
    }
  }
  colnames(df2error)[which(colnames(df2error)=='var_FDI')] <- paste0(var, '_FDI')
  colnames(df2error)[which(colnames(df2error)=='var_AER')] <- paste0(var, '_AER')

  if(OUT%in%TRUE){
    WD <- getwd()
  write.csv(df2error, file.path(paste0(WD,"/OUTPUT/CSV"),paste0(var,'_mismatch_FDI_AER_',namelevel[level+1],'_level.csv')), row.names=F)
  }

  # Identify un-matched records
  dfNA1 <- subset(df1, (is.na(var_FDI) & !is.na(var_AER)))
  dfNA2 <- subset(df1, (!is.na(var_FDI) & is.na(var_AER)))
  lNA1  <- nrow(dfNA1)
  lNA2  <- nrow(dfNA2)
  if (verbose){
    if(lNA1!=0){
      print(paste0("There were ", lNA1, " entries reported in AER not found in FDI. Check '", var,"_missing_FDI_",namelevel[level+1],"_level.csv'"))
    }
    if(lNA2!=0){
      print(paste0("There were ", lNA2, " entries reported in FDI not found in AER. Check '",var, "_missing_AER_",namelevel[level+1],"_level.csv'"))
    }
  }
  colnames(dfNA1)[which(colnames(dfNA1)=='var_FDI')] <- paste0(var, '_FDI')
  colnames(dfNA1)[which(colnames(dfNA1)=='var_AER')] <- paste0(var, '_AER')
  colnames(dfNA2)[which(colnames(dfNA2)=='var_FDI')] <- paste0(var, '_FDI')
  colnames(dfNA2)[which(colnames(dfNA2)=='var_AER')] <- paste0(var, '_AER')

  if(OUT%in%TRUE){
    WD <- getwd()
    suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
    write.csv(dfNA1, file.path(paste0(WD,"/OUTPUT/CSV"),paste0(var, '_missing_FDI_',namelevel[level+1],'_level.csv')), row.names=FALSE)
    write.csv(dfNA2, file.path(paste0(WD,"/OUTPUT/CSV"),paste0(var, '_missing_AER_',namelevel[level+1],'_level.csv')), row.names=FALSE)
  }

  outputs        <- list()
  outputs[[1]]   <- df2error
  outputs[[2]]   <- dfNA1
  outputs[[3]]   <- dfNA2
  names(outputs) <- c('mismatch_FDI_AER', 'missingFDI', 'missingAER')

  return(outputs)
}
