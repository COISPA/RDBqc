#' SL_tab (sex ratio at length) table check
#' @param SL_tab sex ratio at length table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples SL_tab_check(SL_tab_example,"DPS","ITA","9")

SL_tab_check<-function(SL_tab,SP,MS,GSA) {

SL_tab=SL_tab[SL_tab$SPECIES==SP & SL_tab$COUNTRY==MS & SL_tab$AREA==GSA,]
SEXRATIO<-Summary_SL<-LENGTHCLASS<-cOUNTRY<-YEAR<-START_YEAR<-END_YEAR<-SPECIES<-SEX_RATIO<-NULL
Summary_SL=aggregate(SL_tab$SEX_RATIO,by=list(SL_tab$COUNTRY, SL_tab$AREA, SL_tab$START_YEAR, SL_tab$END_YEAR, SL_tab$SPECIES),FUN="length")
colnames(Summary_SL)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX_RATIO")

Summary_SL=Summary_SL[1:nrow(Summary_SL),1:(ncol(Summary_SL)-1)]


print(ggplot(data=SL_tab, aes(x=LENGTHCLASS,y=SEX_RATIO,col=factor(START_YEAR))) + geom_line(stat="identity", binwidth = 0.5) + facet_grid(AREA+COUNTRY~ .))


print(ggplot(SL_tab, aes(x=LENGTHCLASS, y=SEX_RATIO,col="red"))+geom_point()+geom_line()+scale_y_continuous(breaks=seq(0,1,0.25))+expand_limits(x = 0, y = 0)+facet_wrap(~START_YEAR)+ggtitle(paste0("Sexratio by length class of ",SP, " in ", MS,"_GSA",GSA))+theme(legend.position = "none"))

return(Summary_SL)
}
