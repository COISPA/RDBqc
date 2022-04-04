#' Length classes number 0 in landings and discards
#'
#' @param data data frame containing landing data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards.
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose Boolean value to obtain further explanation messages from the function
#' @description The function checks landings and discards for the presence of length class filled in having weigth > 0.
#' @return The function returns a data frame with the rows with 0 values length class having weigth > 0.
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @examples MEDBS_lengthclass_0(data=landing,type="l",MS="ITA",GSA=11,SP="ARA",verbose=TRUE)
#' @importFrom utils globalVariables
#' @export MEDBS_lengthclass_0

MEDBS_lengthclass_0 <- function(data,type="l",MS,GSA,SP, verbose=TRUE){

    if (FALSE) {
        MS <- "ITA"
        GSA <- 11
        SP <- "ARA"
        by="year" # "quarter"
        verbose=TRUE
        data <- landing

        MEDBS_lengthclass_0(data=landing,type="l",MS="ITA",GSA=18,SP="ARS", verbose=TRUE)
    }

    poi2 <- NULL # in combination with @importFrom utils globalVariables

    data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
    data=data[which(data$area==as.numeric(GSA) & data$country==MS & data$species==SP),]

if (type=="l") {
    if (length(which(data$landings>0)))
    {
        land=data
        land_vs_length_minus2=land[land$landings>0,]
        land_vs_length_minus2=as.data.frame(land_vs_length_minus2)

        var_land2 <- grep("lengthclass", names(land_vs_length_minus2), value=TRUE)
        sel_nl_2=c(var_land2)
        poi2=(land_vs_length_minus2[,which(names(land_vs_length_minus2) %in% sel_nl_2)])
        poi2[is.na(poi2)]=0
        poi2[poi2 == -1] <- 0
        poi2[poi2 == ""] <- 0
        poi2[poi2 == "-"] <- 0
        ck_nbl_1b=rowSums(poi2)
        land_vs_length_minus2=cbind(land_vs_length_minus2[,c(1,2,3,4,5,6,7,8,9,10,11,12)],ck_nbl_1b)
        colnames(land_vs_length_minus2)[ncol(land_vs_length_minus2)] <- "ck_0_length"
        n_LC_0 <- length(which(land_vs_length_minus2$ck_0_length==0, arr.ind=T))
        if (verbose) {
            message(paste0(n_LC_0," cases in which length class number are zero and landings > 0"))
            result <- land_vs_length_minus2[which(land_vs_length_minus2$ck_0_length==0, arr.ind=T),]
            return(result)
        }

    } else{
        if (verbose) {
            message(paste0("No landings data > 0"))
        }
    }
}


    if (type=="d") {
        if (length(which(data$discards>0)))
        {
            land=data
            land_vs_length_minus2=land[land$discards>0,]
            land_vs_length_minus2=as.data.frame(land_vs_length_minus2)

            var_land2 <- grep("lengthclass", names(land_vs_length_minus2), value=TRUE)
            sel_nl_2=c(var_land2)
            poi2=(land_vs_length_minus2[,which(names(land_vs_length_minus2) %in% sel_nl_2)])
            poi2[is.na(poi2)]=0
            poi2[poi2 == -1] <- 0
            poi2[poi2 == ""] <- 0
            poi2[poi2 == "-"] <- 0
            ck_nbl_1b=rowSums(poi2)
            land_vs_length_minus2=cbind(land_vs_length_minus2[,c(1,2,3,4,5,6,7,8,9,10,11,12)],ck_nbl_1b)
            colnames(land_vs_length_minus2)[ncol(land_vs_length_minus2)] <- "ck_0_length"
            n_LC_0 <- length(which(land_vs_length_minus2$ck_0_length==0, arr.ind=T))
            if (verbose) {
                message(paste0(n_LC_0," cases in which length class number are zero and discards > 0"))
                result <- land_vs_length_minus2[which(land_vs_length_minus2$ck_0_length==0, arr.ind=T),]
                return(result)
            }

        } else{
            if (verbose) {
                message(paste0("No discards data > 0"))
            }
        }
    }



}
