#' Plot of the maturity stages per length for each sex and species
#'
#' @param data GFCM Task VII.3.2 table
#'
#' @return Plot of the maturity stages per length for each sex and species
#' @export 
#' @import ggplot2
#'
#' @examples check_lmat_TaskVII.3.2(task732_ex)


#Clean the global environment of R
rm(list=ls(all=TRUE)) 

# set working directory
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_dcrf_task_vii32_maturity_data.csv", sep=";",dec=".",head=T,na.strings="NA")
data
#str(data)
###
check_lmat_TaskVII.3.2(data)

check_lmat_TaskVII.3.2 <- function(data){
#Package
library(ggplot2)

  #Simplication of the variable
data$CATFAU_REV=str_sub(data$Maturity, 1, 5)

absent <- strsplit(data$Maturity,"/")
absent <- as.data.frame(do.call(rbind, absent))
colnames(absent) <- c("parte1","stage")
str(absent)
data$FAU_stage=paste(data$CATFAU_REV,absent$stage)
data$FAU_stage
#Creation of the plot
  plot=ggplot(data, aes(x = FAU_stage, y = len,color=sex,shape=sex))+ 
    geom_point(size=1, position=position_dodge(0.9)) +theme_bw()+facet_wrap(~scientific_name,ncol=4,scale="free")+theme(axis.text.x=element_text(angle=270,hjust=0))
  plot

  #Extraction of the plot
  tiff("C:/Users/Loredana Casciaro/Desktop/controlli GFCM-FDI/TEST SA/plot length-Maturity.tiff", res=600, width=30, height = 20, unit="cm")
  plot
  dev.off()
  
  return(plot)
}


