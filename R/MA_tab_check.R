#' MA_tab (maturity at age) table check
#' @param MA_tab maturity at AGE table in MED&BS datacall format
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @examples MA_tab_check(MA_tab_example)
MA_tab_check<-function(MA_tab) {

    AGECLASS<-PRM<-COUNTRY<-YEAR<-START_YEAR<-END_YEAR<-SPECIES<-SEX<-NULL
    Summary_MA_tab=aggregate(MA_tab$SEX,by=list(MA_tab$COUNTRY, MA_tab$AREA, MA_tab$START_YEAR, MA_tab$END_YEAR, MA_tab$SPECIES,MA_tab$SEX),FUN="length")
    colnames(Summary_MA_tab)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX")

    Summary_MA_tab[1:nrow(Summary_MA_tab),1:(ncol(Summary_MA_tab)-1)]

    ggplot(data=MA_tab, aes(x=AGECLASS,y= PRM,col=factor(START_YEAR))) + geom_line(stat="identity", binwidth = 0.5) + facet_grid(AREA+COUNTRY~ SEX)
    MA_tab[MA_tab$SEX==FALSE,]$SEX="F"

    for (i in unique(as.character(MA_tab$SEX))){
        ggplot(data=MA_tab[MA_tab$SEX%in% i,], aes(x=AGECLASS,y= PRM,col=factor(START_YEAR))) + geom_line(stat="identity") +theme(legend.position = "bottom") +expand_limits(x = 0, y = 0)+theme(legend.text = element_text(color = "blue", size = 6))+guides(col=guide_legend(title="")

        )}
    return(Summary_MA_tab)

}
