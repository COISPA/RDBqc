#' Check for duplicated data rows
#'
#' @param data data frame containing landing data
#' @param type string vector indicating the type of table to be checked. "l" for landing; "d" for discards.
#' @param SP species reference code in the three alpha code format
#' @param MS member state code
#' @param GSA GSA code
#' @param verbose Boolean value to obtain further explanation messages from the function
#' @description The function checks the presence of duplicated rows in both landings and discards data.
#' @return The function returns a data frame containing the duplicated rows to be likely deleted from the data.
#' @examples
#' MEDBS_check_duplicates(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
#' MEDBS_check_duplicates(data=Landing_tab_example,type="l",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
#' @export MEDBS_check_duplicates
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @author Isabella Bitetto <bitetto@@coispa.it>

MEDBS_check_duplicates <- function(data,type="l",SP,MS,GSA,verbose=TRUE) {
    if (FALSE) {
        data <- landing
        type <- "l"
        MS <- "ITA"
        GSA <- 18
        SP <- "NEP"
        verbose=TRUE
#       library(data.table)


        # data <- rbind(data,data[1,])

        MEDBS_check_duplicates(data=data,type="l",MS="ITA",GSA="GSA 18",SP="NEP",verbose=FALSE)
    }

data <- as.data.frame(data)
colnames(data) <- toupper(colnames(data))
    # data$area <- as.numeric(gsub("[^0-9.-]+","\\1",data$area))
    data <- data[data$AREA==as.character(GSA) & data$COUNTRY==MS & data$SPECIES==SP,]

    if (type=="l") {
        data$LANDINGS[data$LANDINGS==-1] <- 0
    }

    if (type=="d") {
        data$DISCARDS[data$DISCARDS==-1] <- 0
    }

    duplicate_rows <- table(duplicated(data[,c(2:13)]))# FALSE means no duplicated records are present
    row_to_del <- which(duplicated(data[,c(2:13)]))
    dupl <- data[row_to_del,c(1:12)]
    if (verbose) {
        if(length(row_to_del)!=0) {
            message(paste("There is/are",length(row_to_del),"replicated row/rows in the data."))
            return(dupl)
        } else if (length(row_to_del)==0) {
            message(paste("No duplicated records in the data."))
            return(NULL)
        }
    } else {

        if(length(row_to_del)!=0) {
            return(dupl)
        } else if (length(row_to_del)==0) {
            return(NULL)
        }

    }


}
