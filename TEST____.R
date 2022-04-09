library(RDBqc)
library(roxygen2)
library(ggplot2)
library(dplyr)
roxygenise()
GP_tab_example=read.table("C:\\RDBqc\\GP_MUT18.csv",sep=";",header=T)
save(GP_tab_example,file="data/GP_tab_example.rda",compress="xz")

#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format

#' @param verbose boolean value to obtain further explanation messages from the function


if (verbose){
    message(paste0("No landing data available for the selected species (",SP,")") )
}



output <- list()
l <- length(output)+1
output[[l]] <- pivot
names(output)[[l]] <- "summary table"

l <- length(output)+1
output[[l]] <- plot
names(output)[[l]] <- paste("MeanLength",SP,MS,GSA,sep=" _ ")
