#' Plot of the relationship length weight for each species
#'
#' @param data GFCM Task VII.2 table
#'
#' @return Plot of the length weight relationship for each species
#' @export 
#' @import ggplot2
#'
#' @examples check_lw_TaskVII.2(task72_ex)

if (FALSE){
#Clean the global environment of R
rm(list=ls(all=TRUE)) 
library(ggplot2)
# set working directory
setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA")

#Data imput
data=read.csv("dc_dcrf_task_vii2_length_data.csv", sep=";",dec=".",head=T,na.strings="NA")
data
#str(data)
check_lw_TaskVII.2(data)

}

check_lw_TaskVII.2 <- function(data){
#Package


#Creation of the plot
plot=ggplot(data, aes(x = Length, y = WeightIndividualsSampled))+ 
  geom_point(size=1) +facet_wrap(~scientific_name,ncol=5,scale="free")+
  theme(strip.text = element_text(size=7,lineheight=1.0),
        strip.background = element_rect(fill="grey", colour="black",
                                        size=1))+
  xlab("Length") + ylab("Weight (kg)")
plot


#Extraction of the plot

# tiff("C:/Users/Loredana Casciaro/Desktop/controlli GFCM-FDI/TEST SA/plot length-weight.tiff", res=600, width=30, height = 30, unit="cm")
# plot
# dev.off()


return(print(plot))
}

