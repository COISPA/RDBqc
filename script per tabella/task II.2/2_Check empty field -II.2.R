#' Check empty fields in GFCM Task II.2 table
#'
#' @param data 
#' @param verbose boolean. If TRUE a message is printed.
#'
#' @return two lists. The first list gives the number of NA for each column of interest. The second list gives the index of each NA in the column of interest
#' @export
#'
#' @examples check_EF_taskII2(task22_ex)
#' 
####
rm(list=ls(all=TRUE)) 
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_dcrf_task_ii2_catch.csv", sep=";",dec=".",head=T,na.strings="NA")

verbose=TRUE
####

check_EF_taskII2 <- function(data, verbose=TRUE){
#Declaration of variables and suppression of empty columns for dataframe1
data=data[,c(1:6,8)]

#str(data)

#selection of fields of interest and definition of NA

data$Reference_Year[data$Reference_Year==""]=NA
data$CPC[data$CPC==""]=NA
data$GSA[data$GSA==""]=NA
data$Segment[data$Segment==""]=NA
data$Species[data$Species==""]=NA
data$Landing[data$Landing==""]=NA
data$tCatch[data$Catch==""]=NA
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
#

results2=list(NA_finder_col1, NA_finder_col2,NA_finder_col3,NA_finder_col4,NA_finder_col5,NA_finder_col6,NA_finder_col7)
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

output=list(results,results2)
output
return(output)

}
