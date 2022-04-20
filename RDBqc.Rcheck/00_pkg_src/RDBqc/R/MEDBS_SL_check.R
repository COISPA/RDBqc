#' SL_tab (sex ratio at length) table check
#' @param SL_tab sex ratio at length table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @param verbose boolean value to obtain further explanation messages from the function
#' @description The function allows to check the sex ratio at length (SL) table providing a summary table of the data coverage and plots for the selected species of the proportion of sex ratio for length class by year.
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples MEDBS_SL_check(SL_tab_example,"DPS","ITA","9")

MEDBS_SL_check<-function(SL_tab,SP,MS,GSA,verbose=TRUE) {

    if (FALSE){
        SL_tab <- SL_tab_example
        SP = "DPS"
        MS = "ITA"
        GSA ="9"
    }

SEXRATIO<-Summary_SL<-LENGTHCLASS<-cOUNTRY<-YEAR<-START_YEAR<-END_YEAR<-SPECIES<-SEX_RATIO<-NULL

SL_tab=SL_tab[SL_tab$SPECIES==SP & SL_tab$COUNTRY==MS & SL_tab$AREA==GSA,]

if (nrow(SL_tab)==0) {
    if (verbose){
        message(paste0("No data available for the selected species (",SP,")") )
    }
} else if (nrow(SL_tab)>0) {

Summary_SL=aggregate(SL_tab$SEX_RATIO,by=list(SL_tab$COUNTRY, SL_tab$AREA, SL_tab$START_YEAR, SL_tab$END_YEAR, SL_tab$SPECIES),FUN="length")
colnames(Summary_SL)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX_RATIO")

Summary_SL=Summary_SL[1:nrow(Summary_SL),1:(ncol(Summary_SL)-1)]

output <- list()
l <- length(output)+1
output[[l]] <- Summary_SL
names(output)[[l]] <- "summary table"

p <- ggplot(data=SL_tab, aes(x=LENGTHCLASS,y=SEX_RATIO,col=factor(START_YEAR))) +
    geom_line(stat="identity") +
    facet_grid(AREA+COUNTRY~ .)+
    ggtitle(SP) +
    xlab("Length class") +
    ylab("Sex ratio")

# print(p)
l <- length(output)+1
output[[l]] <- p
names(output)[[l]] <- paste("SL_cum",SP,MS,GSA,sep=" _ ")

p <- ggplot(SL_tab, aes(x=LENGTHCLASS, y=SEX_RATIO,col="red"))+
    geom_point()+geom_line()+
    scale_y_continuous(breaks=seq(0,1,0.25))+
    expand_limits(x = 0, y = 0)+
    facet_wrap(~START_YEAR)+
    ggtitle(paste0("Sex ratio by length class of ",SP, " in ", MS,"_GSA",GSA))+
    theme(legend.position = "none")
# print(p)
l <- length(output)+1
output[[l]] <- p
names(output)[[l]] <- paste("SL",SP,MS,GSA,sep=" _ ")

return(output)
}
}
