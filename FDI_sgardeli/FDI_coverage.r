library(tidyr)
library(dplyr)
library(data.table)
library(plotly)
library(RDBqc)

rm(list=ls())
setwd("C:/Users/vicky/Documents/HCMR/RDBSFIS-MED/FDI checks/FDI datacall")

#Read the data and create unique Id
files = list.files(path=paste0(getwd()), pattern="TABLE_*", full.names=TRUE)
tbla <- plyr::ldply(files[1], fread)
tblg <- plyr::ldply(files[2], fread)
tblh <- plyr::ldply(files[3], fread)
tbli <- plyr::ldply(files[4], fread)
tblj <- plyr::ldply(files[5], fread)

# Q1: the function should take all tables as input and output equal number of tables with coverage?
# Q2: does the user supply tables as arguments or the functions reads from file and opens them?
# Q3: we could have an option for selecting species, in which case the output table has GSA, YR and SP.
#     If the species is NA we can output just GSA and YR
# Q4: In our data from GRC I found that there is an error in the name of the fields in one Table (SUB_REGION)
#     should we add a check for the consistency of the column names among tables and those required by the call

check_FDI_coverage <- function(data, MS, verbose = TRUE){
  
  # check if MS is existing
  mslist <- unique(data$COUNTRY)
  if (MS %in% mslist) {
    print(paste("Coverage of", MS, "data", sep=" ") ) 
  }else{
    stop('MS not existing in provided data')
  }
  
  # subset for MS 
  data1    <- subset(data, COUNTRY == 'GRC')
  data1$id <- seq(1,nrow(data1), 1)
  
  gsas <- unique(data1$SUB_REGION)
  yrs  <- unique(data1$YEAR)
  
  # check there are gsas and years reported 
  if (is.null(gsas)) {stop('No SUB_REGIONS existing')}
  if (is.null(yrs)) {stop('No YEARS existing')}
  
  # check for NAs in gsas or years reported 
  
  gsas <- data1$SUB_REGION
  yrs  <- data1$YEAR
  
  na1 <- which(is.na(gsas))
  na2 <- which(is.na(yrs))
  
  if (verbose) {
    if (length(na1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(na1), 'rows' )) }
    if (length(na2)!=0) {message(paste('Found NAs in Years in', length(na2), 'rows' )) }
  }
  # coverage by GSA and year
  cov <- aggregate(list(records=data1$id), by =list(year = data1$YEAR, gsa= data1$SUB_REGION), FUN=length) 
  
  return(cov)
}


tbla1 <- tbla

# some checks
#data <- tbla1
#MS <-'GRC'
check_FDI_coverage(tbla1, 'GRC', FALSE)

tbla1$YEAR[1] <- NA
check_FDI_coverage(tbla1, 'GRC')

tbla1$YEAR[2] <- NA
check_FDI_coverage(tbla1, 'GRC')

tbla1$YEAR[3] <- NA
check_FDI_coverage(tbla1, 'GRC')


#  what if all gsas for a year are NA

tbla1$SUB_REGION[which(tbla1$YEAR==2014)] <- NA
check_FDI_coverage(tbla1, 'GRC')
