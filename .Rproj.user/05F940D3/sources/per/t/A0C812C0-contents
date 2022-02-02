#' ML_tab (maturity at length) table check
#' @param ML_tab maturity at length table in MED&BS datacall format
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples ML_tab_check(ML_tab_example)
ML_tab_check<-function(ML_tab) {

    LENGTHCLASS<-PRM<-COUNTRY<-YEAR<-START_YEAR<-END_YEAR<-SPECIES<-SEX<-NULL
    Summary_ML_tab=aggregate(ML_tab$SEX,by=list(ML_tab$COUNTRY, ML_tab$AREA, ML_tab$START_YEAR, ML_tab$END_YEAR, ML_tab$SPECIES,ML_tab$SEX),FUN="length")
    colnames(Summary_ML_tab)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX")

        Summary_ML_tab[1:nrow(Summary_ML_tab),1:(ncol(Summary_ML_tab)-1)]

    ggplot(data=ML_tab, aes(x=LENGTHCLASS,y= PRM,col=factor(START_YEAR))) + geom_line(stat="identity", binwidth = 0.5) + facet_grid(AREA+COUNTRY~ SEX)
ML_tab[ML_tab$SEX==FALSE,]$SEX="F"

    for (i in unique(as.character(ML_tab$SEX))){
        ggplot(data=ML_tab[ML_tab$SEX%in% i,], aes(x=LENGTHCLASS,y= PRM,col=factor(START_YEAR))) + geom_line(stat="identity") +theme(legend.position = "bottom") +expand_limits(x = 0, y = 0)+theme(legend.text = element_text(color = "blue", size = 6))+guides(col=guide_legend(title="")

                       )}
    return(Summary_ML_tab)

}
