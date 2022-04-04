#' weight -1 in landings
#'
#' @param data data.table object containing landing or discards data
#' @param type type of table: "l" for landings; "d" for discards
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP species reference code in the three alpha code format
#' @param verbose Boolean value to obtain further explanation messages from the function
#' @description The function checks landings in weight equal to -1 having length class filled in
#' @return The function returns the number of rows with -1 values in landing weights having length class filled in.
#' @examples MEDBS_weight_minus1(data=Landing_tab_example,type="l",MS="ITA",GSA=9,SP="DPS",verbose=TRUE)
#' MEDBS_weight_minus1(data=Discard_tab_example,type="d",MS="ITA",GSA=9,SP="DPS",verbose=TRUE)
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>
#' @importFrom utils globalVariables
#' @export MEDBS_weight_minus1
MEDBS_weight_minus1 <- function(data,type="l",MS,GSA,SP, verbose=TRUE){

    if (FALSE) {
        MS <- "ITA"
        GSA <- 18
        SP <- "HKE"
        by="year" # "quarter"
        verbose=TRUE
        data <- landing
        # data[1,"landings"] <- 0
        # data[2,"landings"] <- -1
        MEDBS_weight_minus1(data=landing,MS="ITA",GSA=18,SP="HKE", verbose=TRUE)
    }

    poi <- NULL # in combination with @importFrom utils globalVariables

    data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
    data=data[which(data$area==as.numeric(GSA) & data$country==MS & data$species==SP),]

    if (type=="l") {

        if (length(which(data$landings==-1))>0)
        {
            land_vs_length_minus1=data[data$landings==-1,]
            land_vs_length_minus1=as.data.frame (land_vs_length_minus1)
            var_land1 <- grep("lengthclass", names(land_vs_length_minus1), value=TRUE)
            sel_nl_1=c(var_land1)
            poi1=(land_vs_length_minus1[,which(names(land_vs_length_minus1) %in% sel_nl_1)])
            poi1[is.na(poi1)]=0
            poi1[poi1 == -1] <- 0
            poi1[poi1 == ""] <- 0
            poi1[poi == "-"] <- 0
            ck_nbl_1a=rowSums(poi1)
            land_vs_length_minus1=cbind(land_vs_length_minus1[,c(1,2,3,4,5,6,7,8,9,10,11,12)],ck_nbl_1a)
            land_vs_length_minus1$diff=(land_vs_length_minus1$landings-land_vs_length_minus1$ck_nbl_1a)
            n_minus1 <- which(land_vs_length_minus1$diff != 0, arr.ind=T)
            # print(paste0(length(which(land$landings==-1)),"_cases_in_which_landings_-1"))
            if (verbose){
                message(paste0(n_minus1," cases in which length class number differ from zero and landing = -1"))
            }
        } else {
            if (verbose){
                message("There aren\'t -1 landings")
            }
            n_minus1 <- 0
        }
    }


    if (type=="d") {

        if (length(which(data$discards==-1))>0)
        {
            land_vs_length_minus1=data[data$discards==-1,]
            land_vs_length_minus1=as.data.frame (land_vs_length_minus1)
            var_land1 <- grep("lengthclass", names(land_vs_length_minus1), value=TRUE)
            sel_nl_1=c(var_land1)
            poi1=(land_vs_length_minus1[,which(names(land_vs_length_minus1) %in% sel_nl_1)])
            poi1[is.na(poi1)]=0
            poi1[poi1 == -1] <- 0
            poi1[poi1 == ""] <- 0
            poi1[poi == "-"] <- 0
            ck_nbl_1a=rowSums(poi1)
            land_vs_length_minus1=cbind(land_vs_length_minus1[,c(1,2,3,4,5,6,7,8,9,10,11,12)],ck_nbl_1a)
            land_vs_length_minus1$diff=(land_vs_length_minus1$discards-land_vs_length_minus1$ck_nbl_1a)
            n_minus1 <- which(land_vs_length_minus1$diff != 0, arr.ind=T)
            # print(paste0(length(which(land$landings==-1)),"_cases_in_which_landings_-1"))
            if (verbose){
                message(paste0(n_minus1," cases in which length class number differ from zero and discard = -1"))
            }
        } else {
            if (verbose){
                message("There aren\'t -1 discards")
            }
            n_minus1 <- 0
        }
    }

    return(n_minus1)
}
