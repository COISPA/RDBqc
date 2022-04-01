#' Plot of the maturity stages per length for each sex and species
#'
#' @description Function to plot the lengths at maturity stages by species and sex to easily identify outliers.
#' @param data GFCM Task VII.3.2 table
#'
#' @return The function return a plot of the maturity stages per length and sex per species.
#' @export
#' @import ggplot2
#'
#' @examples check_lmat_TaskVII.3.2(task_vii32)


check_lmat_TaskVII.3.2 <- function(data){

    FAU_stage <- Length <- Sex <- NULL

  #Simplication of the variable
data$CATFAU_REV=substr(data$Maturity, 1, 5)

absent <- strsplit(data$Maturity,"/")
absent <- as.data.frame(do.call(rbind, absent))
colnames(absent) <- c("parte1","stage")
data$FAU_stage=paste(data$CATFAU_REV,absent$stage)

#Creation of the plot
  plot=ggplot(data, aes(x = FAU_stage, y = Length,color=Sex,shape=Sex))+
    geom_point(size=1, position=position_dodge(0.9)) +theme_bw()+facet_wrap(~Species,ncol=4,scales="free")+theme(axis.text.x=element_text(angle=270,hjust=0))
  print(plot)

}


