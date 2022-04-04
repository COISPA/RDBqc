#' Check empty fields in FDI G table
#' @description The function checks the presence of not allowed empty data in the given table, according to the \href{https://datacollection.jrc.ec.europa.eu/documents/10213/1385040/FDI2021-annex.pdf/6bb0a9b7-166c-48c8-ad12-48ea59a29ffe}{Fisheries Dependent Information data call 2021 - Annex 1}
#' @param data GFCM Task G table
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return Two lists are returned by the function. The first list gives the number of NA for each reference column. The second list gives the index of each NA in the reference column.
#' @export
#'
#' @examples check_EF_FDI_G(fdi_g_effort)
#'


check_EF_FDI_G <- function(data, verbose=TRUE){
#Declaration of variables and suppression of empty columns for dataframe1
data=data[,1:26]

if(all(is.na(data$specon_tech))) data$specon_tech="NA"
#data$specon_tech=as.character(data$specon_tech)
if(all(is.na(data$deep))) data$deep="NA"
#data$deep=as.character(data$deep)
data$totseadays=as.character(data$totseadays)
data$totkwdaysatsea=as.character(data$totkwdaysatsea)
data$totgtdaysatsea=as.character(data$totgtdaysatsea)
data$totfishdays=as.character(data$totfishdays)
data$totkwfishdays=as.character(data$totkwfishdays)
data$totgtfishdays=as.character(data$totgtfishdays)
data$hrsea=as.character(data$hrsea)
data$kwhrsea=as.character(data$kwhrsea)
data$gthrsea=as.character(data$gthrsea)
data$totves=as.character(data$totves)

#str(data)
#selection of fields of interest and definition of NA

data$country[data$country==""]=NA
data$year[data$year==""]=NA
data$quarter[data$quarter==""]=NA
data$vessel_length[data$vessel_length==""]=NA
data$fishing_tech[data$fishing_tech==""]=NA
data$gear_type[data$gear_type==""]=NA
data$target_assemblage[data$target_assemblage==""]=NA
data$mesh_size_range[data$mesh_size_range==""]=NA
data$metier[data$metier==""]=NA
data$supra_region[data$supra_region==""]=NA
data$sub_region[data$sub_region==""]=NA
data$eez_indicator[data$eez_indicator==""]=NA
data$geo_indicator[data$geo_indicator==""]=NA
data$specon_tech[data$specon_tech==""]=NA
data$deep[data$deep==""]=NA
#data$specon_tech[is.na(data$specon_tech) | data$specon_tech==""]="NA"
#data$deep[is.na(data$deep) | data$deep==""]="NA"
data$totseadays[data$totseadays==""]=NA
data$totkwdaysatsea[data$totkwdaysatsea==""]=NA
data$totgtdaysatsea[data$totgtdaysatsea==""]=NA
data$totfishdays[data$totfishdays==""]=NA
data$totkwfishdays[data$totkwfishdays==""]=NA
data$totgtfishdays[data$totgtfishdays==""]=NA
data$hrsea[data$hrsea==""]=NA
data$kwhrsea[data$kwhrsea==""]=NA
data$gthrsea[data$gthrsea==""]=NA
data$totves[data$totves==""]=NA
data$confidential[data$confidential==""]=NA
data

#Localisation of the NA
results= sapply(data, function(x) sum(is.na(x)))
NA_finder_col1=which(is.na(data[,1]),arr.ind=TRUE)
NA_finder_col2=which(is.na(data[,2]),arr.ind=TRUE)
NA_finder_col3=which(is.na(data[,3]),arr.ind=TRUE)
NA_finder_col4=which(is.na(data[,4]),arr.ind=TRUE)
NA_finder_col5=which(is.na(data[,5]),arr.ind=TRUE)
NA_finder_col6=which(is.na(data[,6]),arr.ind=TRUE)
NA_finder_col7=which(is.na(data[,7]),arr.ind=TRUE)
NA_finder_col8=which(is.na(data[,8]),arr.ind=TRUE)
NA_finder_col9=which(is.na(data[,9]),arr.ind=TRUE)
NA_finder_col10=which(is.na(data[,10]),arr.ind=TRUE)
NA_finder_col11=which(is.na(data[,11]),arr.ind=TRUE)
NA_finder_col12=which(is.na(data[,12]),arr.ind=TRUE)
NA_finder_col13=which(is.na(data[,13]),arr.ind=TRUE)
NA_finder_col14=which(is.na(data[,14]),arr.ind=TRUE)
NA_finder_col15=which(is.na(data[,15]),arr.ind=TRUE)
NA_finder_col16=which(is.na(data[,16]),arr.ind=TRUE)
NA_finder_col17=which(is.na(data[,17]),arr.ind=TRUE)
NA_finder_col18=which(is.na(data[,18]),arr.ind=TRUE)
NA_finder_col19=which(is.na(data[,19]),arr.ind=TRUE)
NA_finder_col20=which(is.na(data[,20]),arr.ind=TRUE)
NA_finder_col21=which(is.na(data[,21]),arr.ind=TRUE)
NA_finder_col22=which(is.na(data[,22]),arr.ind=TRUE)
NA_finder_col23=which(is.na(data[,23]),arr.ind=TRUE)
NA_finder_col24=which(is.na(data[,24]),arr.ind=TRUE)
NA_finder_col25=which(is.na(data[,25]),arr.ind=TRUE)
NA_finder_col26=which(is.na(data[,26]),arr.ind=TRUE)

#

results2=list(NA_finder_col1, NA_finder_col2,NA_finder_col3,NA_finder_col4,NA_finder_col5,NA_finder_col6,NA_finder_col7,NA_finder_col8,NA_finder_col9,NA_finder_col10,NA_finder_col11,NA_finder_col12,NA_finder_col13,NA_finder_col14,NA_finder_col15,NA_finder_col16,NA_finder_col17,NA_finder_col18,NA_finder_col19,NA_finder_col20,NA_finder_col21,NA_finder_col22,NA_finder_col23,NA_finder_col24,NA_finder_col25,NA_finder_col26)
names(results2)=colnames(data)

#col 1
if (verbose){
  if (length(NA_finder_col1)==0) {
    message(paste("no NA in the",colnames(data)[1], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col1)," NA in ",colnames(data)[1]))
  }
}


#col 2
if (verbose){
  if (length(NA_finder_col2)==0) {
    message(paste("no NA in the",colnames(data)[2], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col2)," NA in ",colnames(data)[2]))
  }
}

#col 3
if (verbose){
  if (length(NA_finder_col3)==0) {
    message(paste("no NA in the",colnames(data)[3], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col3)," NA in ",colnames(data)[3]))
  }
}

#col 4
if (verbose){
  if (length(NA_finder_col4)==0) {
    message(paste("no NA in the",colnames(data)[4], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col4)," NA in ",colnames(data)[4]))
  }
}

#col 5
if (verbose){
  if (length(NA_finder_col5)==0) {
    message(paste("no NA in the",colnames(data)[5], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col5)," NA in ",colnames(data)[5]))
  }
}

#col 6
if (verbose){
  if (length(NA_finder_col6)==0) {
    message(paste("no NA in the",colnames(data)[6], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col6)," NA in ",colnames(data)[6]))
  }
}

#col 7
if (verbose){
  if (length(NA_finder_col7)==0) {
    message(paste("no NA in the",colnames(data)[7], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col7)," NA in ",colnames(data)[7]))
  }
}

#col 8
if (verbose){
  if (length(NA_finder_col8)==0) {
    message(paste("no NA in the",colnames(data)[8], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col8)," NA in ",colnames(data)[8]))
  }
}

#col 9
if (verbose){
  if (length(NA_finder_col9)==0) {
    message(paste("no NA in the",colnames(data)[9], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col9)," NA in ",colnames(data)[9]))
  }
}

#col 10
if (verbose){
  if (length(NA_finder_col10)==0) {
    message(paste("no NA in the",colnames(data)[10], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col10)," NA in ",colnames(data)[10]))
  }
}

#col 11
if (verbose){
  if (length(NA_finder_col11)==0) {
    message(paste("no NA in the",colnames(data)[11], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col11)," NA in ",colnames(data)[11]))
  }
}

#col 12
if (verbose){
  if (length(NA_finder_col12)==0) {
    message(paste("no NA in the",colnames(data)[12], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col12)," NA in ",colnames(data)[12]))
  }
}
#col 13
if (verbose){
  if (length(NA_finder_col13)==0) {
    message(paste("no NA in the",colnames(data)[13], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col13)," NA in ",colnames(data)[13]))
  }
}
#col 14
if (verbose){
  if (length(NA_finder_col14)==0) {
    message(paste("no NA in the",colnames(data)[14], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col14)," NA in ",colnames(data)[14]))
  }
}
#col 15
if (verbose){
  if (length(NA_finder_col15)==0) {
    message(paste("no NA in the",colnames(data)[15], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col15)," NA in ",colnames(data)[15]))
  }
}
#col 16
if (verbose){
  if (length(NA_finder_col16)==0) {
    message(paste("no NA in the",colnames(data)[16], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col16)," NA in ",colnames(data)[16]))
  }
}
#col 17
if (verbose){
  if (length(NA_finder_col17)==0) {
    message(paste("no NA in the",colnames(data)[17], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col17)," NA in ",colnames(data)[17]))
  }
}
#col 18
if (verbose){
  if (length(NA_finder_col18)==0) {
    message(paste("no NA in the",colnames(data)[18], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col18)," NA in ",colnames(data)[18]))
  }
}
#col 19
if (verbose){
  if (length(NA_finder_col19)==0) {
    message(paste("no NA in the",colnames(data)[19], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col19)," NA in ",colnames(data)[19]))
  }
}
#col 20
if (verbose){
  if (length(NA_finder_col20)==0) {
    message(paste("no NA in the",colnames(data)[20], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col20)," NA in ",colnames(data)[20]))
  }
}

#col 21
if (verbose){
  if (length(NA_finder_col21)==0) {
    message(paste("no NA in the",colnames(data)[21], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col21)," NA in ",colnames(data)[21]))
  }
}

#col 22
if (verbose){
  if (length(NA_finder_col22)==0) {
    message(paste("no NA in the",colnames(data)[22], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col22)," NA in ",colnames(data)[22]))
  }
}

#col 23
if (verbose){
  if (length(NA_finder_col23)==0) {
    message(paste("no NA in the",colnames(data)[23], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col23)," NA in ",colnames(data)[23]))
  }
}

#col 24
if (verbose){
  if (length(NA_finder_col24)==0) {
    message(paste("no NA in the",colnames(data)[24], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col24)," NA in ",colnames(data)[24]))
  }
}

#col 25
if (verbose){
  if (length(NA_finder_col25)==0) {
    message(paste("no NA in the",colnames(data)[25], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col25)," NA in ",colnames(data)[25]))
  }
}

#col 26
if (verbose){
  if (length(NA_finder_col26)==0) {
    message(paste("no NA in the",colnames(data)[26], "column"))
  } else {
    message(paste("There are ",length(NA_finder_col26)," NA in ",colnames(data)[26]))
  }
}



output=list(results,results2)
output
return(output)

}