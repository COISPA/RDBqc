library(tidyr)
library(dplyr)
library(data.table)
library(plotly)
library(RDBqc)
library(scales)

rm(list=ls())
setwd("C:/Users/vicky/Documents/HCMR/RDBSFIS-MED/FDI checks/FDI datacall")

#Read the data and create unique Id
files = list.files(path=paste0(getwd()), pattern="TABLE_*", full.names=TRUE)
tbla <- plyr::ldply(files[1], fread)
tblg <- plyr::ldply(files[2], fread)
tblh <- plyr::ldply(files[3], fread)
tbli <- plyr::ldply(files[4], fread)
tblj <- plyr::ldply(files[5], fread)


check_FDI_disc_coverage <- function(data, MS, verbose = TRUE){
  
  # check if MS is existing
  mslist <- unique(data$COUNTRY)
  if (MS %in% mslist) {
    print(paste("Discard coverage per GSA for", MS, "data", sep=" ") ) 
  }else{
    stop('MS not existing in provided data')
  }
  
  # subset for MS 
  data1    <- subset(data, COUNTRY == 'GRC')
  #data1$id <- seq(1,nrow(data1), 1)
  
  ngsas <- unique(data1$SUB_REGION)
  nyrs  <- unique(data1$YEAR)
  
  # check there are gsas and years reported 
  if (is.null(ngsas)) {stop('No SUB_REGIONS existing')}
  if (is.null(nyrs)) {stop('No YEARS existing')}
  
  # check for NAs in gsas or years reported 
  
  gsas <- data1$SUB_REGION
  yrs  <- data1$YEAR
  
  na1 <- which(is.na(gsas))
  na2 <- which(is.na(yrs))
  
  if (verbose) {
    if (length(na1)!=0) {message(paste('Found NAs in SUB_REGIONS in', length(na1), 'rows' )) }
    if (length(na2)!=0) {message(paste('Found NAs in Years in', length(na2), 'rows' )) }
  }
  
  # Discard coverage by GSA and year. Split discards in categories ">0", "0", "NK"
  d1 <- which(data1$DISCARDS >= 0)
  d2 <- which(data1$DISCARDS == 0)
  d3 <- which(data1$DISCARDS == 'NK')
  data1$DISCcat     <- rep(NA, nrow(data1))
  data1$DISCcat[d1] <- 1
  data1$DISCcat[d2] <- 0
  data1$DISCcat[d3] <- 'NK'
  discov <- aggregate(list(landings=data1$TOTWGHTLANDG), by =list(year = data1$YEAR, gsa= data1$SUB_REGION, disccat = data1$DISCcat), FUN=sum) 
  TL     <- aggregate(list(landings=data1$TOTWGHTLANDG), by =list(year = data1$YEAR, gsa= data1$SUB_REGION), FUN=sum) 
  
  #gsals <- vector("list", length = length(ngsas))
  for(i in 1:length(ngsas)) {
    #gsals[[i]] <- discov[which(discov$gsa==ngsas[i]),] 
    d        <- discov[which(discov$gsa==ngsas[i]),] 
    l        <- TL[which(TL$gsa==ngsas[i]),] 
    if (length(d1)!=0 ) {
      l$disc1    <- d$landings[which(d$disccat==1)]
      l$disc1per <- label_percent(1)(d$landings[which(d$disccat==1)]/l$landings)
    } else {
      l$disc1    <- rep(0, nrow(l))
      l$disc1per <- label_percent(1)(rep(0, nrow(l)))
    }
    if (length(d2)!=0 ) {
      l$disc0    <- d$landings[which(d$disccat==0)]
      l$disc0per <- label_percent(1)(d$landings[which(d$disccat==0)]/l$landings)
    } else {
      l$disc0    <- rep(0, nrow(l))
      l$disc0per <- label_percent(1)(rep(0, nrow(l)))
    }
    if (length(d3)!=0 ) {
      l$discNK    <- d$landings[which(d$disccat=='NK')]
      l$discNKper <- label_percent(1)(d$landings[which(d$disccat=='NK')]/l$landings)
    } else {
      l$discNK    <- rep(0, nrow(l))
      l$discNKper <- label_percent(1)(rep(0, nrow(l)))
    }
    colnames(l) <- c('year', 'gsa', 'Total lands', 'Lands (disc > 0)',
                     '% Lands (disc >0)', 'Lands (disc = 0)',
                     '% Lands (disc = 0)', 'Lands (disc = NK)',
                     '% Lands (disc = NK)')
    print(paste("Discard coverage in", ngsas[i], sep=' '))
    print(l)
  }
  
  #return(discov)
}


tbla1 <- tbla

# some checks
#data <- tbla1
#MS <-'GRC'
check_FDI_disc_coverage(tbla1, 'GRC')

tbla1$YEAR[1] <- NA
check_FDI_disc_coverage(tbla1, 'GRC')
