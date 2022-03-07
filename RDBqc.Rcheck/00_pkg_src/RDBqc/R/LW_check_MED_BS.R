#' LW params in GP_tab (sex ratio at length) table check#'
#' @param GP_tab growth params table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @return a summary table and plots
#' @export
#' @import ggplot2 dplyr
#' @importFrom grDevices dev.off
#' @examples LW_check_MED_BS(GP_tab_example,"MUT","ITA","SA 18")
LW_check_MED_BS<-function(GP_tab,SP,MS,GSA) {
GP_tab=GP_tab[GP_tab$SPECIES==SP & GP_tab$COUNTRY==MS & GP_tab$AREA==GSA,]

LENGTH<-WEIGHT<-SEX<-ID<-NULL

Summary_LW=aggregate(GP_tab$A,by=list(GP_tab$COUNTRY, GP_tab$AREA, GP_tab$START_YEAR, GP_tab$END_YEAR, GP_tab$SPECIES,GP_tab$SEX),FUN="length")
colnames(Summary_LW)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX")

GP_tab$ID <- paste0(GP_tab$START_YEAR, " a = ",GP_tab$A,", b = ",GP_tab$B)
ck_sp <- c("HKE","MUT","MUR","SOL","CTC","PIL","ANE")
if(!SP%in%ck_sp){
    len=seq(1,80,1)
}else{
    len=seq(5,40,5)
}


## FEMALE LW####
F_wt <- list()
counter=1
for (i in unique(GP_tab$SEX)){
    LW_F=GP_tab[!GP_tab$A%in%-999 & !GP_tab$A%in%-1 & !GP_tab$A%in%999 &  !GP_tab$B%in%-999 & !GP_tab$B%in%999 & !GP_tab$B%in%-1 & GP_tab$SEX%in%i,]

    LW_F$WEIGHT <- NA
    for (j in 1:nrow(LW_F)){
        F_wt[[counter]] <- data.frame("ID"=LW_F$ID[j],"COUNTRY"=LW_F$COUNTRY[j],"AREA"=LW_F$AREA[j],"START_YEAR"=LW_F$START_YEAR[j],"SPECIES"=LW_F$SPECIES[j],"SEX"=LW_F$SEX[j],"LENGTH"=len,"WEIGHT"=LW_F$A[j]*len^LW_F$B[j])
        counter <- counter+1
    }
}
LW_final <- do.call("rbind",F_wt)


LW_final <- LW_final[!LW_final$WEIGHT%in%NA,]


    steps <-seq(0,80,20)


ggplot(LW_final,aes(x=LENGTH,y=WEIGHT,col=SEX))+geom_point()+geom_line()+
           facet_wrap(~START_YEAR)+ggtitle(paste0("LW curve of ",SP, " in ", MS,"_GSA",GSA))+theme(legend.position = "bottom")+scale_x_continuous(breaks=steps)+expand_limits(x = 0, y = 0)

for (i in unique(LW_final$SEX)){
    ggplot(LW_final[LW_final$SEX%in%i,],aes(x=LENGTH,y=WEIGHT,col=ID))+geom_point()+geom_line()+
               facet_wrap(~START_YEAR)+ggtitle(paste0("LW curve of ",i," ",SP, " in ", MS,"_GSA",GSA))+theme(legend.position = "bottom")
           +scale_x_continuous(breaks=steps)+expand_limits(x = 0, y = 0)+
               theme(
                   legend.text = element_text(color = "blue", size = 6))+guides(col=guide_legend(title=paste(SP,GSA,MS)))
    }

for (i in unique(LW_final$SEX)){
    ggplot(LW_final[LW_final$SEX%in%i,],aes(x=LENGTH,y=WEIGHT,col=ID))+geom_point()+geom_line()+
               # facet_wrap(~START_YEAR)+
               ggtitle(paste0("LW curve of ",i," ",SP, " in ", MS,"_GSA",GSA))+theme(legend.position = "bottom")
           +scale_x_continuous(breaks=steps)+expand_limits(x = 0, y = 0)+
               theme(
                   legend.text = element_text(color = "blue", size = 6))+guides(col=guide_legend(title=paste(SP,GSA,MS))

                   )}
return(Summary_LW)
}

