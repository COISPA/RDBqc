#' Check of growth parameters table
#' @param data growth parameters table in MED&BS data call format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the growth parameters by sex and year for a selected species
#' @return A list of objects containing a summary table and different plots of the growth curves by sex and year is returned by the function.
#' @export
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @author Walter Zupa <zupa@@coispa.it>
#' @import ggplot2 dplyr
#' @importFrom grDevices dev.off
#' @examples MEDBS_GP_check(GP_tab_example, "MUT", "ITA", "GSA 18")
MEDBS_GP_check <- function(data, SP, MS, GSA, verbose=FALSE) {
  if (FALSE) {
    data <- GP_tab_example # GP_tab_example
    SP <- "MUT"
    MS <- "ITA"
    GSA <- "GSA 18"
    MEDBS_GP_check(GP, "CTC", "ITA", "GSA 18")
  }
  AREA <- VB_LINF <- AGE <- LENGTH <- ID <- COUNTRY <- YEAR <- START_YEAR <- END_YEAR <- SPECIES <- SEX <- NULL

  colnames(data) <- toupper(colnames(data))
  GP_tab <- data

  # GP_tab$AREA <- as.numeric(gsub("[^0-9]", "", GP_tab$AREA))
  GP_tab <- GP_tab[GP_tab$SPECIES %in% SP & GP_tab$COUNTRY == MS & GP_tab$AREA == GSA, ]
  GP_tab <- GP_tab[!is.na(GP_tab$VB_LINF) & GP_tab$VB_LINF != -1, ]
  if (nrow(GP_tab) > 0) {
      Summary_GP <- suppressMessages(data.frame(GP_tab %>% group_by(COUNTRY,AREA,START_YEAR,END_YEAR,SPECIES,SEX)
                                              %>% summarize(COUNT=length(VB_LINF))))
      Summary_table_GP <- Summary_GP

      i=1
    for (i in 1:nrow(GP_tab)) {
        # if (GP_tab$SPECIES[i] %in% ck_sp) { # ck_sp
        # if (GP_tab$VB_UNITS[i] %in% c("cm", "NA")) {
          GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ", GP_tab$VB_LINF[i], ", k = ", GP_tab$VB_K[i], " t0 = ", GP_tab$VB_T0[i])
          # GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]
        # }
      # else {
      #     GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ", GP_tab$VB_LINF[i] / 10, ", k = ", GP_tab$VB_K[i], " t0 = ", GP_tab$VB_T0[i])
      #     GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i] / 10
      #   }
      # }
      # else {
      #   if (GP_tab$VB_UNITS[i] %in% c("cm", "NA")) {
      #     GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ", GP_tab$VB_LINF[i] * 10, ", k = ", GP_tab$VB_K[i], " t0 = ", GP_tab$VB_T0[i])
      #     GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i] * 10
      #   } else {
      #     GP_tab$ID[i] <- paste0(GP_tab$START_YEAR[i], " Linf = ", GP_tab$VB_LINF[i], ", k = ", GP_tab$VB_K[i], " t0 = ", GP_tab$VB_T0[i])
      #     GP_tab$VB_LINF[i] <- GP_tab$VB_LINF[i]
      #   }
      # }
    }

    Age <- seq(0.5, 20, 0.5)

    ## VBGF####
    F_age <- list()
    counter <- 1
    i <- "M"
    for (i in unique(GP_tab$SEX)) {
      GP_tab2 <- GP_tab[
                         # !GP_tab$VB_LINF %in% -999 &
                         !GP_tab$VB_LINF %in% -1 &
                         # !GP_tab$VB_LINF %in% 999 &
                         # !GP_tab$VB_K %in% -999 &
                         !GP_tab$VB_K %in% -1 &
                         # !GP_tab$VB_K %in% 999 &
                         !GP_tab$VB_T0 %in% -999 &
                         # !GP_tab$VB_T0 %in% 999 &
                         GP_tab$SEX %in% i, ]
      GP_tab2$LENGTH <- NA
      j=1
      for (j in 1:nrow(GP_tab2)) {
        F_age[[counter]] <- data.frame("ID" = GP_tab2$ID[j], "COUNTRY" = GP_tab2$COUNTRY[j], "AREA" = GP_tab2$AREA[j], "START_YEAR" = GP_tab2$START_YEAR[j], "SPECIES" = GP_tab2$SPECIES[j], "SEX" = GP_tab2$SEX[j], "AGE" = Age, "LENGTH" = GP_tab2$VB_LINF[j] * (1 - exp(-GP_tab2$VB_K[j] * (Age - GP_tab2$VB_T0[j]))),"UNIT" = GP_tab2$VB_UNITS[j])
        counter <- counter + 1
      }
    }
    VBGF <- do.call("rbind", F_age)

    VBGF <- VBGF[!is.na(VBGF$LENGTH), ]

    plots <- list()

    l <- length(plots) + 1
    plots[[l]] <- Summary_table_GP
    names(plots)[[l]] <- "summary table"

    p <- ggplot(VBGF, aes(x = AGE, y = LENGTH, col = SEX)) +
      geom_point() +
      geom_line() +
      facet_wrap(~START_YEAR) +
      ggtitle(paste0("VBGF curve of ", SP, " in ", MS, " - ", GSA)) +
      # theme(legend.position = "bottom")+
      scale_x_continuous(breaks = seq(0, 20, 2)) +
      expand_limits(x = 0, y = 0)+
      xlab("Age (years)")+
      ylab(paste0("Length (",unique(VBGF$UNIT)[1],")"))
    # print(p)

    l <- length(plots) + 1
    plots[[l]] <- p
    names(plots)[[l]] <- paste("VBGF", SP, MS, GSA, sep = " _ ")

    ## PLOT 2
    i <- "M"
    for (i in unique(VBGF$SEX)) {
      p <- ggplot(VBGF[VBGF$SEX %in% i, ], aes(x = AGE, y = LENGTH, col = ID)) +
        geom_point() +
        geom_line() +
        facet_wrap(~START_YEAR) +
        ggtitle(paste0("VBGF curve of ", i, " ", SP, " in ", MS, " - ", GSA)) +
        # theme(legend.position = "bottom")+
        theme(legend.text = element_text(color = "blue", size = 6)) +
        guides(col = guide_legend(title = ""))+
        xlab("Age (years)")+
        ylab(paste0("Length (",unique(VBGF[VBGF$SEX %in% i,"UNIT"])[1],")"))
      # print(p)

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("VBGF_year", SP, MS, GSA, i, sep = " _ ")
    }

    ## PROT 3
    for (i in unique(VBGF$SEX)) {
      p <- ggplot(VBGF[VBGF$SEX %in% i, ], aes(x = AGE, y = LENGTH, col = ID)) +
        geom_point() +
        geom_line() +
        ggtitle(paste0("VBGF curve of ", i, " ", SP, " in ", MS, " - ", GSA)) +
        # theme(legend.position = "bottom", legend.box = "vertical")+
        theme(legend.text = element_text(color = "blue", size = 6)) +
        guides(col = guide_legend(title = ""))+
        xlab("Age (years)")+
        ylab(paste0("Length (",unique(VBGF[VBGF$SEX %in% i,"UNIT"])[1],")"))
      # print(p)

      l <- length(plots) + 1
      plots[[l]] <- p
      names(plots)[[l]] <- paste("VBGF_cum", SP, MS, GSA, i, sep = " _ ")
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
