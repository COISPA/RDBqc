#' LFD of MED & BS landing and discard data
#'
#' @param data data frame of either landings or discards data
#' @param data2 data frame of discards data, only in case type="b"
#' @param type type of data frame. "l" for landing, "d" for discard and "b" for both the data
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param OUT boolean. If TRUE outputs are saved in the OUTPUT folder
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to report the observed Length Frequency Distributions of a selected species.
#' @return The function returns different data frame and plots of LFD of Landing, Discards and Catches according to the source data used in the analysis.
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples
#' MEDBS_LFD(data=RDBqc::Landing_tab_example,
#' data2=RDBqc::Discard_tab_example, type="b",
#' SP="DPS", MS="ITA", GSA="GSA 9", OUT=TRUE, verbose = TRUE)
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join
#' @importFrom data.table data.table
#' @export


MEDBS_LFD <- function(data, data2, type, SP, MS, GSA, OUT=FALSE, verbose = FALSE){
  if (FALSE) {
    # library(ggplot2)
    # library(data.table)
    # library(tidyverse)
    # library(dplyr)
    # library(RDBqc)
    # library(fishmethods)
    # library(utils)
    # library(magrittr)
    # library(tidyr)
    type="b"
    landed<- RDBqc::Landing_tab_example
    discarded <- RDBqc::Discard_tab_example
    data <- landed
    data2 <-  discarded

    Land <- landed
    Disc <- discarded
    data <- discarded

    # ddddd <- read.csv("~/GitHub/RDBqc_appoggio/dataset/discards_BGR.csv")
    # data <- ddddd
    # SP <- "ANE"
    # GSA <- "GSA 29"
    # MS <- "BGR"
    # res <- MEDBS_LFD(data=ddddd, data2=NA, type="d", SP, MS, GSA, OUT=TRUE, verbose = TRUE)


    SP <- "DPS"
    GSA <- "GSA 9"
    MS <- "ITA"

    res <- MEDBS_LFD(data=landed, data2=discarded, type="b", SP, MS, GSA, OUT=TRUE, verbose = TRUE)

    data = Land
    data2=NA
    type="l"
    MS = MS
    GSA = GSAs[g]
    SP = SPs[s]
    OUT=FALSE
    verbose = TRUE

  }

  . <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- ID <- value <- start_length <- discards <- landings<- tot_val <- NULL

    output_csv <- list()
    output_jpg <- list()
    i_csv <- 0
    i_jpg <- 0

  if (type=="l" | type=="b"){
    landed <-   as.data.table(data)
    colnames(landed) <- tolower(colnames(landed))
    # landed$upload_id <- NA
    landed[landed$landings==-1]=0
    # id_landings <- NA
    # landed <- cbind(id_landings, landed)
    landed$landings[landed$landings == -1] <- 0

    ## Subsetting DataFrame, preparing data for further elaboration and setting output directory ####
    land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

    if (SP %in% c("ARA","ARS","NEP","DPS")){
      step <- 25 # 5 should be ok for crustaceans and cephalopods and 50 for fish. Change this value accordingly on how plot resulted.
    }else{
      step <- 50
    }

    land <- landed[which(landed$area==GSA & landed$country==MS & landed$species==SP),]

    var_no_landed <- grep("lengthclass", colnames(land), value = TRUE)
    max_no_landed <- land[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_landed]
    max_no_landed[max_no_landed == -1] <- 0
    max_no_landed2 <- max_no_landed[, -(1:7)]

    # is.na(max_no_landed)
    p=as.data.frame(colSums(max_no_landed2,na.rm=TRUE))
    p$Length=c(0:100)
    names(p)=c("Sum","Length")

    maxlength= max(p[which(p$Sum > 0),"Length"])
    unit=unique(land$unit)

    if (OUT) {
      WD <- getwd()
      dir_csv <- paste0(WD, "/OUTPUT/CSV")
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(land,file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","Landings.csv"),row.names=F)
    }

    i_csv <- i_csv + 1
    output_csv[[i_csv]] <- land
    names(output_csv)[i_csv] <- "Table_Landing"

    ##### LANDINGS data analysis #####

    cols <- c(which(colnames(land) %in% c("year", "area", "species", "unit","gear","fishery","country")), grep("lengthclass", colnames(land)))
    dat <- land[, cols, with=FALSE]
    lccols <- grep("lengthclass", colnames(dat))
    colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])
    ldat <- suppressWarnings(melt(dat, id.vars=c("year", "area","species", "unit", "country", "gear", "fishery"), variable.name="start_length", value.name="value"))
    ldat$start_length=as.integer(ldat$start_length)
    ldat[(ldat$value<0) | is.na(ldat$value),"value"] <- 0

    LFL=suppressMessages(ldat %>% group_by(year,gear,fishery,start_length) %>% summarise(value=sum(value, na.rm=TRUE)))
     # aggregate(ldat$value,by=list(ldat$year,ldat$gear,ldat$fishery,ldat$start_length),sum)
    names(LFL)=c("year","gear","fishery","start_length","value")
    LFL$ID=paste0(LFL$gear,"_",LFL$fishery,sep="")

    LFL$start_length=LFL$start_length-1
    ck <- suppressMessages(LFL %>% group_by(year,ID) %>% dplyr::summarize (tot=sum(value,na.rm=T)))
    ck$ck <- ifelse(ck$tot>0,1,0)
    LFL2 <- suppressMessages(as.data.frame(left_join(LFL,ck)))
    LFL2 <- subset(LFL2[LFL2$ck>0,])

    if (nrow(LFL2)>0){

      plot1=ggplot(subset(LFL2,start_length<maxlength), aes(x=start_length, y=value,fill=ID)) +
               geom_bar(stat="identity") + facet_grid(ID~year,scales = "free") +
               #theme(strip.background =element_rect(fill="white"))+
               theme(axis.text.x = element_text(angle=90,size=4)) +
               theme_bw()+
               ggtitle(paste0(SP," ",MS," ",GSA," ","Landings Length Frequency")) +
               xlab(paste0("Length","_","(",unit,")")) +
               ylab("Number  (thousands)")+xlab(paste0("Length","(",unit,")")) +
               scale_x_continuous(breaks = seq(0,maxlength,by=step)) +
               theme(legend.position="none")+
               theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
      i_jpg <- i_jpg + 1
      output_jpg[[i_jpg]] <- plot1
      names(output_jpg)[i_jpg] <- "Plot_Landing_LFD_GEAR"

      LFL_sum <- subset(LFL2,start_length<maxlength) %>% group_by(year,gear,fishery) %>% summarise(total_number = sum(value,na.rm=TRUE))

         if (OUT) {
           # save plot
           WD <- getwd()
           dir_plot <- paste0(WD, "/OUTPUT/JPG")
           suppressWarnings(dir.create(dir_plot, recursive = T))
           ggsave(filename=paste0(dir_plot,"/",MS,"_",GSA,"_",SP,"_","LFD_LANDING.jpg"),width = 10, height = 8, dpi = 150, units = "in")

           #save csv
           WD <- getwd()
           dir_csv <- paste0(WD, "/OUTPUT/CSV")
           suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
           write.csv(arrange(LFL_sum,desc(year),desc(gear)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFL_land_gear.csv"),row.names=F)
         }

         i_csv <- i_csv + 1
         output_csv[[i_csv]] <- arrange(LFL_sum,desc(year),desc(gear))
         names(output_csv)[i_csv] <- "Table_Landing_LFD_GEAR"


    }else{
      print("No length frequency disributions available")
    }

    LFL_fin=as.data.frame(LFL)
    LFL_fin= suppressMessages(LFL_fin %>% group_by(year,start_length) %>% summarise(value=sum(value, na.rm=TRUE)))
    # aggregate(LFL_fin$value,by=list(LFL_fin$year,LFL_fin$start_length),sum)
    names(LFL_fin)=c("year","length","value")

    temp1 <- data.frame(cbind(rep(unique(LFL$year),each=length(unique(LFL_fin$length))),rep(rep(0:100,each=1),length(unique(LFL_fin$year)))))
    names(temp1) <- c("year","length")
    temp1 <- merge(temp1,LFL_fin,by=c("year","length"),all=T)
    temp1[is.na(temp1)] <- 0
    LFL_fin <- temp1

    # if (OUT) {
    #   WD <- getwd()
    #   dir_csv <- paste0(WD, "/OUTPUT/CSV")
    #   write.csv(arrange(LFL_fin,desc(year),desc(length)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFL_yr.csv"),row.names=F)
    # }
    #
    # i_csv <- i_csv + 1
    # output_csv[[i_csv]] <- arrange(LFL_fin,desc(year),desc(length))
    # names(output_csv)[i_csv] <- "Table_Landing_LFD_YEAR"

    yield=land[,-c(14:114)]  # [,-c(15:116)]
    yield_tot= suppressMessages(yield %>% group_by(year,gear,fishery) %>% summarise(value=sum(landings,na.rm=TRUE))) # aggregate(yield$landings,by=list(yield$year,yield$gear,yield$fishery),sum)
    yield_totali= suppressMessages(yield %>% group_by(year) %>% summarise(tonnes=sum(landings, na.rm=TRUE)))
      # aggregate(yield$landings,by=list(yield$year),sum)
    names(yield_totali)=c("year","tonnes")
    names(yield_tot)=c("year","gear","fishery","value")
    yield_tot$ID=paste0(yield_tot$gear,"_",yield_tot$fishery,sep="")



    plot2=ggplot(yield_tot, aes(x=year, y=value,color=ID))+
         geom_point()+
         geom_line(stat="identity") + facet_grid(gear~.,scales = "free")+
         ggtitle(paste0(SP," ",MS," ",GSA," ","TOTAL LANDING")) + xlab("YEAR") + ylab("tons")+
         theme(axis.text.x = element_text(angle=0, vjust=0.6))+
         scale_x_continuous(breaks = seq(min(yield_tot$year),max(yield_tot$year),by=2))+
         theme(legend.position="right")+
         theme_bw()+
         theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

    i_jpg <- i_jpg + 1
    output_jpg[[i_jpg]] <- plot2
    names(output_jpg)[i_jpg] <- "Plot_Landing_TOTAL LANDING"

    if (OUT){
      WD <- getwd()
      dir_plot <- paste0(WD, "/OUTPUT/JPG")
      suppressWarnings(dir.create(dir_plot, recursive = T))
      ggsave(filename=paste0(dir_plot,"/",MS,"_",GSA,"_",SP,"_TOTAL_WEIGTH_LAND.jpg"),width = 10, height = 8, dpi = 150, units = "in" )
    }

  }  # END Landing analysis

  if (type == "b"){
    discarded <- as.data.frame(data2)
    colnames(discarded) <- tolower(colnames(discarded))
  } else if (type=="d") {
    discarded <- as.data.frame(data)
    colnames(discarded) <- tolower(colnames(discarded))
  }



  if (type == "d" | type=="b") {
    discarded$upload_id <- NA
    discarded[discarded$discards==-1,]=0
    # id_discards <- NA
    # discarded <- cbind(id_discards,discarded)

    # discarded$discards[discarded$discards == -1] <- 0

    ## Subsetting DataFrame, preparing data for further elaboration and setting output directory ####
    disc <- data.table(discarded[which(discarded$area == GSA & discarded$country == MS & discarded$species == SP), ])

    if (nrow(disc)==0) {
      if (verbose) {
        print("No discard data available for the selected combination of country, GSA and species")
      }
      no_discard_data <- TRUE
      LFD <- data.frame(matrix(ncol=5,nrow=0))
      colnames(LFD) <- c("year","gear","fishery","start_length","value")
    } else {
      no_discard_data <- FALSE
    if (SP %in% c("ARA","ARS","NEP","DPS")){
      step <- 25 # 5 should be ok for crustaceans and cephalopods and 50 for fish. Change this value accordingly on how plot resulted.
    }else{
      step <- 50
    }

    var_no_discarded <- grep("lengthclass", colnames(disc), value = TRUE)
    max_no_discarded <- disc[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_discarded]
    max_no_discarded[max_no_discarded == -1] <- 0
    max_no_discarded2 <- max_no_discarded[, -(1:7)]

    # is.na(max_no_landed)
    p=as.data.frame(colSums(max_no_discarded2,na.rm=TRUE))
    p$Length=c(0:100)
    names(p)=c("Sum","Length")

    maxlength= max(p[which(p$Sum > 0),"Length"])
    unit=unique(disc$unit)

    if (OUT) {
      WD <- getwd()
      dir_csv <- paste0(WD, "/OUTPUT/CSV")
      suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      write.csv(disc,file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","Discards.csv"),row.names=F)
    }
    i_csv <- i_csv + 1
    output_csv[[i_csv]] <- disc
    names(output_csv)[i_csv] <- "Table_Discards"

    ####### DISCARDS ##########
    cols <- c(which(colnames(disc) %in% c("year", "area", "species", "unit","gear","fishery","country")), grep("lengthclass", colnames(disc)))
    dat1 <- disc[, cols, with=FALSE]
    lccols <- grep("lengthclass", colnames(dat1))
    colnames(dat1)[lccols] <- gsub("[^0-9]", "", colnames(dat1)[lccols])
    ddat <- suppressWarnings(melt(dat1, id.vars=c("year", "area","species", "unit", "country", "gear", "fishery"), variable.name="start_length", value.name="value"))
    ddat$start_length=as.integer(ddat$start_length)
    ddat[(ddat$value<0) | is.na(ddat$value),"value"] <- 0
    LFD <- suppressMessages(ddat %>% group_by(year,gear,fishery,start_length) %>% dplyr::summarize(value=sum(value,na.rm=T)))
    names(LFD)=c("year","gear","fishery","start_length","value")
    LFD$ID=paste0(LFD$gear,"_",LFD$fishery,sep="")
    LFD$start_length=LFD$start_length-1

    ckd <- suppressMessages(LFD %>% group_by(year,ID) %>% dplyr::summarize (tot=sum(value,na.rm=T)))
    ckd$ckd <- ifelse(ckd$tot>0,1,0)
    LFD2 <- suppressMessages(as.data.frame(left_join(LFD,ckd)))
    LFD2 <- subset(LFD2[LFD2$ckd>0,])
    # droplevels(LFD2)

    if(nrow(LFD2)>0){

      plot3=ggplot(subset(LFD2,start_length<maxlength), aes(x=start_length, y=value,fill=ID)) +
        geom_bar(stat="identity") + facet_grid(ID~year,scales = "free") +
        theme(axis.text.x = element_text(angle=90,size=4)) +
        theme_bw()+
        ggtitle(paste0(SP," ",MS," ",GSA," ","Discards Length Frequency")) +
        xlab(paste0("Length","_","(",unit,")")) +
        ylab("Number  (thousands)")+xlab(paste0("Length","(",unit,")")) +
        scale_x_continuous(breaks = seq(0,maxlength,by=step)) +
        theme(legend.position="none")+
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

      i_jpg <- i_jpg + 1
      output_jpg[[i_jpg]] <- plot3
      names(output_jpg)[i_jpg] <- "Plot_Discards_LFD_GEAR"

      LFD_sum <-subset(LFD2,start_length<maxlength) %>% group_by(year,gear,fishery) %>% summarise(total_number = sum(value,na.rm=TRUE))

      if (OUT) {
        # save plot
        WD <- getwd()
        dir_plot <- paste0(WD, "/OUTPUT/JPG")
        suppressWarnings(dir.create(dir_plot, recursive = T))
        ggsave(filename=paste0(dir_plot,"/",MS,"_",GSA,"_",SP,"_","LFD_DISCARD.jpg"),width = 10, height = 8, dpi = 150, units = "in")

        #save csv
        WD <- getwd()
        dir_csv <- paste0(WD, "/OUTPUT/CSV")
        suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
        write.csv(arrange(LFD_sum,desc(year),desc(gear)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFD_disc_gear.csv"),row.names=F)
      }

      i_csv <- i_csv + 1
      output_csv[[i_csv]] <- arrange(LFD_sum,desc(year),desc(gear))
      names(output_csv)[i_csv] <- "Table_Discards_LFD_GEAR"

    }else{
      print("Discards LFDs not available")
    }

      LFD_fin=as.data.frame(LFD)
      LFD_fin=suppressMessages(LFD_fin %>% group_by(year,start_length) %>% summarise(value=sum(value,na.rm=TRUE)))
      #aggregate(LFD_fin$value,by=list(LFD_fin$year,LFD_fin$start_length),sum)
      names(LFD_fin)=c("year","length","value")
      temp <- data.frame(cbind(rep(unique(LFD$year),each=length(unique(LFD_fin$length))),rep(rep(0:100,each=1),length(unique(LFD_fin$year)))))
      names(temp) <- c("year","length")
      temp <- merge(temp,LFD_fin,by=c("year","length"),all=T)
      temp[is.na(temp)] <- 0
      LFD_fin <- temp

      # if (OUT) {
      #   WD <- getwd()
      #   dir_csv <- paste0(WD, "/OUTPUT/CSV")
      #   suppressWarnings(dir.create(paste0(WD, "/OUTPUT/CSV"), recursive = T))
      # write.csv(arrange(LFD_fin,desc(year),desc(length)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFD_yr.csv"),row.names=F)
      # }
      #
      # i_csv <- i_csv + 1
      # output_csv[[i_csv]] <- arrange(LFD_fin,desc(year),desc(length))
      # names(output_csv)[i_csv] <- "Table_Discards_LFD_YEAR"


      dyield=disc[,-c(14:115)]
      dyield_tot <- suppressMessages( dyield %>% group_by(year,gear,fishery) %>% dplyr::summarize(discards=sum(discards,na.rm=T)))
      dyield_totali <- dyield %>% group_by(year) %>% dplyr::summarize(discards=sum(discards,na.rm=T))

      names(dyield_totali)=c("year","tonnes")
      names(dyield_tot)=c("year","gear","fishery","value")
      dyield_tot$ID=paste0(dyield_tot$gear,"_",dyield_tot$fishery,sep="")


      if (nrow(dyield_tot)>0){

               plot4=ggplot(dyield_tot, aes(x=year, y=value,color=ID))+
                 geom_point()+
                 geom_line(stat="identity") + facet_grid(gear~.,scales = "free")+
                 ggtitle(paste0(SP," ",MS," ",GSA," ","TOTAL DISCARD")) + xlab("YEAR") + ylab("tons")+
                 theme(axis.text.x = element_text(angle=0, vjust=0.6))+
                 scale_x_continuous(breaks = seq(min(dyield_tot$year),max(dyield_tot$year),by=2))+
                 theme(legend.position="right")+
                 theme_bw()+
                 theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
               i_jpg <- i_jpg + 1
               output_jpg[[i_jpg]] <- plot4
               names(output_jpg)[i_jpg] <- "Plot_Discards_TOTAL DISCARDS"

               if (OUT) {
                 WD <- getwd()
                 dir_plot <- paste0(WD, "/OUTPUT/JPG")
                 suppressWarnings(dir.create(dir_plot, recursive = T))
               ggsave(filename=paste0(dir_plot,"/",MS,"_",GSA,"_",SP,"_","TOTAL_WEIGHT_DISC.jpg"),width = 10, height = 8, dpi = 150, units = "in")
                 }
      }else{
        print("No discards available")
      }
    }
  } # type="d"


  if (type == "b") {
    #### Total ####
    if(nrow(LFD)>0 & !no_discard_data){
      LFT=suppressMessages(full_join(LFL,LFD,by=c("year","start_length","gear","fishery","ID")))
      LFT[is.na(LFT)] <- 0
      LFT$tot_val <- NA
      for (i in 1:(nrow(LFT))){
        LFT$tot_val[i]=LFT$value.x[i]+LFT$value.y[i]
      }
    }else{
      LFT=LFL
      #str(LFT)
      LFT[is.na(LFT)] <- 0
    }

    if(nrow(LFD)>0){
      LFT2= suppressMessages(LFT %>% group_by(year,ID,start_length) %>% summarise(tot_val=sum(tot_val,na.rm=TRUE)))
        #aggregate(LFT$tot_val,by=list(LFT$year,LFT$ID,LFT$start_length),sum)
      names(LFT2)=c("year","ID","length","tot_val")
      LFT_fin <- suppressMessages(LFT %>% group_by(year,start_length) %>% summarise(tot_val=sum(tot_val,na.rm=TRUE)))
        #aggregate(LFT$tot_val,by=list(LFT$year,LFT$start_length),sum)
      names(LFT_fin)=c("year","length","tot_val")
      if (OUT){
        WD <- getwd()
        dir_csv <- paste0(WD, "/OUTPUT/CSV")
      write.csv(arrange(LFT[,c("year","gear","tot_val")],desc(year),desc(gear)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFD_total_gear.csv"),row.names=F)

      i_csv <- i_csv + 1
      output_csv[[i_csv]] <- arrange(LFT[,c("year","gear","tot_val")],desc(year),desc(gear))
      names(output_csv)[i_csv] <- "Table_Catches_LFD_GEAR"

      write.csv(arrange(LFT_fin,desc(year),desc(length)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_LFT_yr.csv"),row.names=F)

      i_csv <- i_csv + 1
      output_csv[[i_csv]] <- arrange(LFT_fin,desc(year),desc(length))
      names(output_csv)[i_csv] <- "Table_Catches_LFD_YEAR"

      }
    }else{
      LFT2= suppressMessages(LFL %>% group_by(year,ID,start_length) %>% summarise(tot_value=sum(value,na.rm=TRUE)))
        #aggregate(LFL$val,by=list(LFL$year,LFL$ID,LFL$start_length),sum)
      names(LFT2)=c("year","ID","length","tot_value")
      LFT_fin <- aggregate(LFL$value,by=list(LFL$year,LFL$start_length),sum)
      names(LFT_fin)=c("year","length","tot_value")
      if (OUT){
        WD <- getwd()
        dir_csv <- paste0(WD, "/OUTPUT/CSV")
      write.csv(arrange(LFL[,c("year","gear","value")],desc(year),desc(gear)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFD_total_gear.csv"),row.names=F)

      i_csv <- i_csv + 1
      output_csv[[i_csv]] <- arrange(LFL[,c("year","gear","value")],desc(year),desc(gear))
      names(output_csv)[i_csv] <- "Table_Catches_LFD_GEAR"

      write.csv(arrange(LFT_fin,desc(year),desc(length)),file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","LFT_yr.csv"),row.names=F)

      i_csv <- i_csv + 1
      output_csv[[i_csv]] <- arrange(LFT_fin,desc(year),desc(length))
      names(output_csv)[i_csv] <- "Table_Catches_LFD_YEAR"

      }
    }

    if(nrow(LFT2)>0){

             plot5=ggplot(subset(LFT2,length<maxlength), aes(x=length, y=tot_val,fill=ID)) +
               geom_bar(stat="identity") + facet_grid(ID~year,scales = "free") +
               #theme(strip.background =element_rect(fill="white"))+
               theme(axis.text.x = element_text(angle=90,size=4)) +
               theme_bw()+
               ggtitle(paste0(SP," ",MS," ",GSA," ","Catches Length Frequency")) +
               xlab(paste0("Length","_","(",unit,")")) +
               ylab("Number  (thousands)")+xlab(paste0("Length","(",unit,")")) +
               scale_x_continuous(breaks = seq(0,maxlength,by=step)) +
               theme(legend.position="none")+
               theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

             i_jpg <- i_jpg + 1
             output_jpg[[i_jpg]] <- plot5
             names(output_jpg)[i_jpg] <- "Plot_Catches_LFD"

             if (OUT){
               WD <- getwd()
               dir_plot <- paste0(WD, "/OUTPUT/JPG")
               suppressWarnings(dir.create(dir_plot, recursive = T))
             ggsave(filename=paste0(dir_plot,"/",MS,"_",GSA,"_",SP,"_","LFD_Catches.jpg"),width = 10, height = 8, dpi = 150, units = "in")
      }
    }else{
      print("There aren't any length frequencies distributions available")
    }

    ### TOTAL CATCHES ###
    tl <- land[,-c(1,2,4:11,13:114)]
    tl <- tl %>% group_by(year) %>%
      dplyr::summarize(landings=sum(landings,na.rm = T))

    td <- disc[,-c(1,2,4:11,13:115)]

    if(nrow(td)>0){
      td <- td %>% group_by(year) %>%
        dplyr::summarize(discards=sum(discards,na.rm = T))
    }else{
      td <- setNames(data.frame(tl$year,0),c("year","discards"))
    }

    total_catches <- suppressMessages(as.data.frame(left_join(tl,td)))
    total_catches[is.na(total_catches)]=0
    total_catches$total=total_catches$landings+total_catches$discards
    time <- data.frame("year"=seq(min(total_catches$year),max(total_catches$year),1))
    total_catches <- suppressMessages(full_join(total_catches,time))

    i_csv <- i_csv + 1
    output_csv[[i_csv]] <- total_catches
    names(output_csv)[i_csv] <- "total_catches_weight"

    i_csv <- i_csv + 1
    output_csv[[i_csv]] <- total_catches[,-c(2,4)]
    names(output_csv)[i_csv] <- "Discard_wg"

    i_csv <- i_csv + 1
    output_csv[[i_csv]] <- total_catches[,-c(3,4)]
    names(output_csv)[i_csv] <- "Landing_wg"

    if (OUT){
      WD <- getwd()
      dir_csv <- paste0(WD, "/OUTPUT/CSV")
    write.csv(total_catches,file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","Total_catches_weight.csv"),row.names = F)
    write.csv(total_catches[,-c(2,4)],file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","Discard_wg.csv"),row.names=F)
    write.csv(total_catches[,-c(3,4)],file=paste0(dir_csv,"/",MS,"_",GSA,"_",SP,"_","Landing_wg.csv"),row.names=F)
    }

  } # type == "b"

    output <- c(output_csv,output_jpg)

    return(output)
}  # FUNCTION END
