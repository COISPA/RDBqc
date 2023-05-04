#' @title Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
#' @param data data frame containing MEDBS discards by length table
#' @param data1 data frame containing FDI Table A Catch data
#' @param MS member state 3 alpha code
#' @param GSA FAO Geographical Sub Area code (GSA9, GSA29, etc)
#' @param SP ASFIS FAO 3alpha code of the choosen species
#' @param MEDBSSP look up table in which requested MEDBS Data Call species (see MEDBS data call Annex I) are listed
#' @param verbose boolean. If TRUE a message is printed
#' @param OUT Default is FALSE. If set as TRUE plots and tables in csv will be saved in the OUTPUT folder created in the working directory
#' @export
#' @importFrom dplyr summarize group_by
#' @importFrom data.table fread
#' @import ggplot2
#' @importFrom cowplot plot_grid
#' @description The function compares the discards in weight values reported in the MEDBS discards by length table with the one reported in the FDI Table A catch table. The analysis is done at MS, GSA, species and gear level
#' @return The function returns plots comparison by year of the discards in weight provided through the MEDBS and FDI Data Calls. Moreover a csv file with the actual values will be created. Plot, csv and rds output files will be saved in the dedicated folders in OUTPUT folder
#' @author Alessandro Mannini <alessandro.mannini@irbim.cnr.it>
#' @examples \donttest{# Check_Tot_Disc_gear_Q (MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)}
#' # The function works by one country, subarea and species each.
#' # It is not possible assign more country, subarea or species.

Check_Tot_Disc_gear_Q <- function(data,data1,MS,GSA,SP,MEDBSSP,verbose=TRUE,OUT=FALSE){

  AREA <- COUNTRY <- DATA_CALL <- DISCARDS <- GEAR <- GEAR_TYPE <- QUARTER <- SPECIES <-  SUB_REGION <- YEAR <- NULL

  colnames(data) <- toupper(colnames(data))
  colnames(data1) <- toupper(colnames(data1))
  colnames(data1)[1] <- "COUNTRY"
  colorset = c('FDI'='red','MEDBS'='blue')

  if(!SP%in%MEDBSSP$SPECIES){
    print("Warning: selected species is not present in MEDBS data call list. Discards comparison for MEDBS could be not possible")
    }
    if(!SP%in%unique(data$SPECIES) & !SP%in%unique(data1$SPECIES)){
    print("Error: selected species is not present in both Data Calls datasets. Discards comparison is not possible")
    }
  ## Modifying FDI code according to MEDBS
  data1$GEAR_TYPE[data1$GEAR_TYPE%in%c("NO","NK")] <- "NA"
  data1$QUARTER[data1$QUARTER%in%c("ALL")] <- -1
  data$AREA <- gsub(" ","",data$AREA)
  data$DISCARDS[data$DISCARDS%in%c("-1","NA",NA,"")] <- 0
  data1$DISCARDS[data1$DISCARDS%in%c("NA",NA,"","NK")] <- 0
  id <- paste0(MS,"_",GSA,"_",SP)
  if(id%in%c(unique(paste0(data$COUNTRY,"_",data$AREA,"_",data$SPECIES))) | id%in%c(unique(paste0(data1$COUNTRY,"_",
    data1$SUB_REGION,"_",data1$SPECIES)))){
  data <- data[data$COUNTRY%in%MS & data$AREA%in%GSA & data$SPECIES%in%SP,]
  data1 <- data1[data1$COUNTRY%in%MS & data1$SUB_REGION%in%GSA & data1$SPECIES%in%SP,]
  compland <- list()
  if (nrow(data)>0){
    compland[[1]] <- setdiff(paste0(data$YEAR,"_",data$GEAR,"_",data$QUARTER),
                             paste0(data1$YEAR,"_",data1$GEAR_TYPE,"_",data1$QUARTER))

    names(compland)[[1]] <- paste("TABLE_DISCARDS_GEAR_QUARTER_IN_MEDBS_NOT_IN_FDI",MS,GSA,SP,sep="_")

    if(OUT%in%TRUE){
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
      write.csv(setdiff(paste0(data$YEAR,"_",data$GEAR,"_",data$QUARTER),
                        paste0(data1$YEAR,"_",data1$GEAR_TYPE,"_",data1$QUARTER)
      ),file=paste0(WD,"/OUTPUT/CSV/Gear_Quarter_in_MEDBS_not_in_FDI_for_",MS,"_",GSA,"_",SP,".csv"),row.names = F)
    }
  }else{
    print("Warning: selected species is not present in MEDBS dataset")
  }


  if (nrow(data1)>0){
    compland[[2]] <- setdiff(paste0(data1$YEAR,"_",data1$GEAR_TYPE,"_",data1$QUARTER),
                             paste0(data$YEAR,"_",data$GEAR,"_",data$QUARTER))
    names(compland)[[2]] <- paste("TABLE_DISCARDS_GEAR_QUARTER_IN_FDI_NOT_IN_MEDBS",MS,GSA,SP,sep="_")


    if(OUT%in%TRUE){
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
      write.csv(setdiff(paste0(data1$YEAR,"_",data1$GEAR_TYPE,"_",data1$QUARTER),
                        paste0(data$YEAR,"_",data$GEAR,"_",data$QUARTER)
      ),file=paste0(WD,"/OUTPUT/CSV/Gear_Quarter_in_FDI_not_in_MEDBS_for ",MS,"_",GSA,"_",SP,".csv"),row.names = F)
    }
  }else{
    print("Warning: selected species is not present in FDI dataset")
  }

  if(nrow(data)>0){
  data <- suppressMessages(data %>% group_by(YEAR,COUNTRY,AREA,SPECIES,GEAR,QUARTER) %>% summarize(TOT=sum(DISCARDS,na.rm=T)))
  db <- data.frame("YEAR"=data$YEAR,"COUNTRY"=data$COUNTRY,"GSA"=data$AREA,"SPECIES"=data$SPECIES,
                   "GEAR"=data$GEAR,"QUARTER"=data$QUARTER,
                   "DISCARDS"=data$TOT,"DATA_CALL"="MEDBS")
  }else{
    db <- data.frame("YEAR"=integer(),
                     "COUNTRY"=character(),
                     "GSA"=character(),
                     "SPECIES"=character(),
                     "GEAR"=character(),
                     "QUARTER"=integer(),
                     "DISCARDS"=double(),
                     "DATA_CALL"=character(),
                     stringsAsFactors=FALSE)
  }

  if(nrow(data1)>0){
  data1 <- suppressMessages(data1 %>% group_by(YEAR,COUNTRY,SUB_REGION,SPECIES,GEAR_TYPE,QUARTER) %>% summarize(TOT=sum(DISCARDS,na.rm=T)))
  db1 <- data.frame("YEAR"=data1$YEAR,"COUNTRY"=data1$COUNTRY,"GSA"=data1$SUB_REGION,"SPECIES"=data1$SPECIES,
                    "GEAR"=data1$GEAR_TYPE,"QUARTER"=data1$QUARTER,
                    "DISCARDS"=data1$TOT,"DATA_CALL"="FDI")
  }else{
    db1 <- data.frame("YEAR"=integer(),
                     "COUNTRY"=character(),
                     "GSA"=character(),
                     "SPECIES"=character(),
                     "GEAR"=character(),
                     "QUARTER"=integer(),
                     "DISCARDS"=double(),
                     "DATA_CALL"=character(),
                     stringsAsFactors=FALSE)
  }

  db$GEAR[db$GEAR%in%c(NA,"")] <- "NA"
  db1$GEAR[db1$GEAR%in%c(NA,"")] <- "NA"


  if(nrow(rbind(db,db1))>0){
    compland[[3]] <- rbind(db,db1)
    names(compland)[[3]] <- paste(paste("TABLE_DISCARDS_GEAR_QUARTER",MS,GSA,SP,sep="_"))}
    counter <- 4

    if(OUT%in%TRUE){
      WD <- getwd()
      suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
  write.csv(rbind(db,db1),paste0(WD,"/OUTPUT/CSV/Discards gear quarter comparison for ",MS,"_",GSA,"_",SP,".csv"),row.names = F)
  }

  for (i in union(db$GEAR,db1$GEAR)){

    for (j in union(db$QUARTER,db1$QUARTER)){

      if(nrow(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,])>0){
       # ggsave(paste0("../OUT/PLOT/Discard gear ",i," and quarter ",j," comparison for ",MS,"_",GSA,"_",SP,".jpeg"),  units="in", width=8, height=4, dpi=300,
               compland[[counter]] <-  suppressMessages(plot_grid(
                 ggplot(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,],aes(x=YEAR,y=DATA_CALL,col=DATA_CALL))+geom_point()+ylab("")+xlab("")+scale_color_manual(values=colorset)+
                   scale_x_continuous(breaks = seq(min(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),max(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),1))+theme_bw()+ggtitle(paste0("Time series available for ",MS,"_",GSA,"_",SP,"_",i,"_in quarter ",j))+theme(legend.position = "none"),
                 ggplot(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,],aes(x=YEAR,y=DISCARDS,col=DATA_CALL))+geom_point()+geom_line()+ylab("Discards (t)")+scale_color_manual(values=colorset)+
                   xlab("")+scale_x_continuous(breaks = seq(min(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),max(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),1))+theme_bw()+theme(legend.position = "bottom"),
                 align = "v", nrow = 2, rel_heights = c(1/4,1/2)))
        #)
               names(compland)[[counter]] <- paste("PLOT_DISCARDS_GEAR",i,"QUARTER",j,MS,GSA,SP,sep="_")
               counter <- counter+1
      }#else{print("")}

    }
  }
    if(OUT%in%TRUE){
      #WD <- getwd()
      suppressWarnings(dir.create(paste0(WD,"/OUTPUT/PLOT"),recursive = T))
      #suppressWarnings(dir.create(paste0(WD,"/OUTPUT/CSV"),recursive = T))
      #write.csv(rbind(db,db1),file=paste0(WD,"/OUTPUT/CSV/Discards_gear_",MS,"_",GSA,"_",SP,".csv"),row.names = FALSE)
      #colorset = c('FDI'='red','MEDBS'='blue')
      for (i in union(db$GEAR,db1$GEAR)){
        for (j in union(db$QUARTER,db1$QUARTER)){
          if(nrow(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,])>0){
          ggsave(paste0(WD,"/OUTPUT/PLOT/Discards gear ",i," and quarter ",j," comparison for ",MS,"_",GSA,"_",SP,".jpeg"),  units="in", width=8, height=4, dpi=300,
                plot=suppressMessages(plot_grid(
                   ggplot(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,],aes(x=YEAR,y=DATA_CALL,col=DATA_CALL))+geom_point()+ylab("")+xlab("")+scale_color_manual(values=colorset)+
                     scale_x_continuous(breaks = seq(min(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),max(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),1))+theme_bw()+ggtitle(paste0("Time series available for ",MS,"_",GSA,"_",SP,"_",i,"_in quarter ",j))+theme(legend.position = "none"),
                   ggplot(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,],aes(x=YEAR,y=DISCARDS,col=DATA_CALL))+geom_point()+geom_line()+ylab("Discards (t)")+scale_color_manual(values=colorset)+
                     xlab("")+scale_x_continuous(breaks = seq(min(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),max(rbind(db,db1)[rbind(db,db1)$GEAR%in%i & rbind(db,db1)$QUARTER%in%j,]$YEAR),1))+theme_bw()+theme(legend.position = "bottom"),
                   align = "v", nrow = 2, rel_heights = c(1/4,1/2)))
          )
        }#else{print("")

        }
      }
    }
    #}


    if(length(compland)!=0){

      return(compland)
      # return(list(compland,ifelse(OUT%in%TRUE,print("Discards comparison has been done. Please check outputs in OUTPUT folder."),
      #                           print("Discards comparison has been done."))))
    }

  }else{
    print("Error: selected MS,GSA and Species combination doesn't exist.")
  }
}
