#' GP_tab (growth params) table check
#' @param data growth params table in MED&BS datacall format
#' @param SP species (three alpha code)
#' @param MS Country
#' @param GSA GSA (Geographical sub-area (GFCM sensu))
#' @description The function allows to check the growth parameters by sex and year for a selected species
#' @return a list of objects containing a summary table and different plots of the growth curves by sex and year.
#' @export
#' @import ggplot2 dplyr
#' @importFrom grDevices dev.off
#' @examples MEDBS_GP_check(GP_tab_example,"MUT","ITA","GSA 18")
MEDBS_GP_check<-function(data,SP,MS,GSA) {

    if (FALSE) {
        data = GP_tab_example
        SP="MUT"
        MS="ITA"
        GSA="GSA 18"
    }
    AGE<-LENGTH<-ID<-COUNTRY<-YEAR<-START_YEAR<-END_YEAR<-SPECIES<-SEX<-NULL

    colnames(data) <- toupper(colnames(data))
    GP_tab <- data

    ck_sp <- c("HKE","MUT","MUR","SOL","CTC","PIL","ANE")

    # GP_tab$AREA <- as.numeric(gsub("[^0-9]", "", GP_tab$AREA))
    GP_tab=GP_tab[GP_tab$SPECIES %in% SP & GP_tab$COUNTRY==MS & GP_tab$AREA==GSA,]

    if (nrow(GP_tab)>0){


        Summary_GP=aggregate(GP_tab$VB_LINF,by=list(GP_tab$COUNTRY, GP_tab$AREA, GP_tab$START_YEAR,
                            GP_tab$END_YEAR, GP_tab$SPECIES,GP_tab$SEX),FUN="length")
        colnames(Summary_GP)=c("COUNTRY", "YEAR", "START_YEAR","END_YEAR","SPECIES","SEX")


        Summary_GP=   Summary_GP[1:nrow(Summary_GP),1:(ncol(Summary_GP)-1)]


        for (i in 1:nrow(GP_tab)){
            if(GP_tab$SPECIES[i]%in% ck_sp){  # ck_sp
                if(GP_tab$VB_UNITS[i]%in%c("cm","NA")){
                    GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ",GP_tab$VB_LINF[i],", k = ",GP_tab$VB_K[i]," t0 = ",GP_tab$VB_T0[i])
                    GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]
                }else{
                    GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ",GP_tab$VB_LINF[i]/10,", k = ",GP_tab$VB_K[i]," t0 = ",GP_tab$VB_T0[i])
                    GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]/10
                }
            }else{
                if(GP_tab$VB_UNITS[i]%in%c("cm","NA")){
                    GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ",GP_tab$VB_LINF[i]*10,", k = ",GP_tab$VB_K[i]," t0 = ",GP_tab$VB_T0[i])
                    GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]*10
                }else{
                    GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ",GP_tab$VB_LINF[i],", k = ",GP_tab$VB_K[i]," t0 = ",GP_tab$VB_T0[i])
                    GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]
                }

            }
        }

        Age=seq(0.5,20,0.5)

        ## VBGF####
        F_age <- list()
        counter=1
        i=1
        for (i in unique(GP_tab$SEX)){
            GP_tab2=GP_tab[!GP_tab$VB_LINF%in%-999 & !GP_tab$VB_LINF%in%-1 & !GP_tab$VB_LINF%in%999 &  !GP_tab$VB_K%in%-999 & !GP_tab$VB_K%in%-1 &  !GP_tab$VB_K%in%999 & !GP_tab$VB_T0%in%-999 & !GP_tab$VB_T0%in%999 & GP_tab$SEX%in%i,]
            GP_tab2$LENGTH <- NA
            for (j in 1:nrow(GP_tab2)){
                F_age[[counter]] <- data.frame("ID"=GP_tab2$ID[j],"COUNTRY"=GP_tab2$COUNTRY[j],"AREA"=GP_tab2$AREA[j],"START_YEAR"=GP_tab2$START_YEAR[j],"SPECIES"=GP_tab2$SPECIES[j],"SEX"=GP_tab2$SEX[j],"AGE"=Age, "LENGTH"=GP_tab2$VB_LINF[j]*(1-exp(-GP_tab2$VB_K[j]*(Age-GP_tab2$VB_T0[j]))))
                counter <- counter+1
            }

        }
        VBGF <- do.call("rbind",F_age)

        VBGF <- VBGF[!VBGF$LENGTH%in%NA,]

        plots <- list()

        l <- length(plots)+1
        plots[[l]] <- Summary_GP
        names(plots)[[l]] <- "summary table"

        p <- ggplot(VBGF,aes(x=AGE,y=LENGTH,col=SEX))+
            geom_point()+
            geom_line()+
            facet_wrap(~START_YEAR)+
            ggtitle(paste0("VBGF curve of ",SP, " in ", MS," - ",GSA))+
            # theme(legend.position = "bottom")+
            scale_x_continuous(breaks=seq(0,20,2))+
            expand_limits(x = 0, y = 0)
        # print(p)

        l <- length(plots)+1
        plots[[l]] <- p
        names(plots)[[l]] <- paste("VBGF",SP,MS,GSA,sep=" _ ")

## PLOT 2
        for (i in unique(VBGF$SEX)){
            p <- ggplot(VBGF[VBGF$SEX%in%i,],aes(x=AGE,y=LENGTH,col=ID))+
                geom_point()+
                geom_line()+
                facet_wrap(~START_YEAR)+
                ggtitle(paste0("VBGF curve of ",i," ",SP, " in ", MS," - ",GSA))+
                # theme(legend.position = "bottom")+
                theme(legend.text = element_text(color = "blue", size = 6))+
                guides(col=guide_legend(title=""))
            # print(p)

            l <- length(plots)+1
            plots[[l]] <- p
            names(plots)[[l]] <- paste("VBGF_year",SP,MS,GSA,i,sep=" _ ")
        }

## PROT 3
        for (i in unique(VBGF$SEX)){
            p <- ggplot(VBGF[VBGF$SEX%in%i,],aes(x=AGE,y=LENGTH,col=ID))+
                geom_point()+
                geom_line()+
                ggtitle(paste0("VBGF curve of ",i," ",SP, " in ", MS," - ",GSA))+
                # theme(legend.position = "bottom", legend.box = "vertical")+
                theme(legend.text = element_text(color = "blue", size = 6))+
                guides(col=guide_legend(title=""))
            # print(p)

            l <- length(plots)+1
            plots[[l]] <- p
            names(plots)[[l]] <- paste("VBGF_cum",SP,MS,GSA,i,sep=" _ ")
        }


        # #############  MALES  ###############
        #
        # GP_M=GP_tab[GP_tab$VB_LINF!=999 & GP_tab$VB_K!=999 & GP_tab$VB_T0!=999 & as.character(GP_tab$SEX)=="M",]
        #
        #
        # for (i in 1:nrow(GP_M)){
        #     if(i==1 ){
        #         Length=GP_M$VB_LINF[i]*(1-exp(-GP_M$VB_K[i]*(Age-GP_M$VB_T0[i])))
        #         plot(Age,  Length,type="l",col="black",lwd=2, main=paste(SP,"_males",sep=""),ylim=c(1,max(GP_M$VB_LINF)))
        #     }  else if(i>1 ){
        #         Length=GP_M$VB_LINF[i]*(1-exp(-GP_M$VB_K[i]*(Age-GP_M$VB_T0[i])))
        #         lines(Age,  Length,type="l",col=i,lwd=2)
        #     }
        # }
        #
        # legend("bottomright",legend=GP_M$START_YEAR,lwd=1,col=c(1,seq(2,nrow(GP_M),1)))
        # dev.off()

        #####################################


        # #############  FEMALES   #############
        #
        # GP_F=GP_tab[GP_tab$VB_LINF!=999 & GP_tab$VB_K!=999 & GP_tab$VB_T0!=999 & as.character(GP_tab$SEX)=="F",]
        #
        # Age=seq(0.5,20,0.5)
        #
        # for (i in 1:nrow(GP_F)){
        #     if(i==1 ){
        #         Length=GP_F$VB_LINF[i]*(1-exp(-GP_F$VB_K[i]*(Age-GP_F$VB_T0[i])))
        #         plot(Age,  Length,type="l",col="black",lwd=2, main=paste(SP,"_females",sep=""),ylim=c(1,max(GP_F$VB_LINF)))
        #     }  else if(i>1 ){
        #         Length=GP_F$VB_LINF[i]*(1-exp(-GP_F$VB_K[i]*(Age-GP_F$VB_T0[i])))
        #         lines(Age,  Length,type="l",col=i,lwd=2)
        #     }
        # }
        #
        # legend("bottomright",legend=as.character(GP_F$START_YEAR),lwd=1,col=seq(1,nrow(GP_F),1))
        # dev.off()

        #####################################


        return(plots)
}
}
