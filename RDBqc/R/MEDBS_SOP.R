#' check of the sum of products
#'
#' @param data Catch table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param threshold threshold value in percentage to check the percentage difference between SOP and both volumes of landing and discard. Default value is 5%
#' @param verbose boolean. If TRUE messages are returned
#' @return the function returns a data frame of the record with values of percentage difference between SOP and both volumes of landing and discard greater then threshold value.
#' @export
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_SOP(data = Catch_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9", threshold = 5)
MEDBS_SOP <- function(data, SP, MS, GSA, threshold = 5, verbose = TRUE) {
  colnames(data) <- toupper(colnames(data))
  data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
  data[is.na(data$GEAR), "GEAR"] <- "NA"
  data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
  data[is.na(data$FISHERY), "FISHERY"] <- "NA"
  data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, ]
  Data_call <- data

  if (nrow(data) > 0) {
    #-----------CHECK CONSISTENCY LANDING-----------
    Data_call[Data_call$LANDINGS == -1, "LANDINGS"] <- 0
    Data_call[Data_call$DISCARDS == -1, "DISCARDS"] <- 0
    for (p in 25:ncol(Data_call)) {
      Data_call[, p] <- as.numeric(Data_call[, p])
      Data_call[is.na(Data_call[, p]), p] <- 0
      Data_call[Data_call[, p] == -1, p] <- 0
    }
    Landing_nb <- Data_call[, 1:12]
    i <- 1
    for (i in 1:20) {
      Landing_nb <- cbind(Landing_nb, Data_call[, which(colnames(Data_call) == paste("AGE_", i - 1, "_NO_LANDED", sep = ""))])
      colnames(Landing_nb)[ncol(Landing_nb)] <- paste("AGE_", i - 1, "_NO_LANDED", sep = "")
    }
    Landing_nb <- cbind(Landing_nb, Data_call[, (colnames(Data_call) == "AGE_20_PLUS_NO_LANDED" | colnames(Data_call) == "AGE_20_NO_LANDED")])

    colnames(Landing_nb) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_NO_LANDED", sep = ""), "AGE_20_PLUS_NO_LANDED")

    Landing_nb[, 13:ncol(Landing_nb)][Landing_nb[, 13:ncol(Landing_nb)] == -1] <- 0
    Landing_nb$Sum <- rowSums(Landing_nb[, 13:ncol(Landing_nb)])
    pos_indices <- which(Landing_nb$Sum > 0)
    Landing_wt <- Data_call[, 1:12]
    for (i in 1:20) {
      Landing_wt <- cbind(Landing_wt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_WEIGHT_LANDED", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_WT_LANDED", sep = "")])
    }
    Landing_wt <- cbind(Landing_wt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_LANDED" | colnames(Data_call) == "AGE_20_WT_LANDED"])
    colnames(Landing_wt) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_MEAN_WEIGHT_LANDED", sep = ""), "AGE_20_PLUS_MEAN_WEIGHT_LANDED")

    Landing_wt[, 13:ncol(Landing_wt)][Landing_wt[, 13:ncol(Landing_wt)] == -1] <- 0

    Data_call$check_LANDING <- NA
    Data_call$check_DISCARD <- NA
    Data_call$sumprodl <- NA
    Data_call$SOPl <- NA
    Data_call$sumprodd <- NA
    Data_call$SOPd <- NA

    not_run <- NULL

    r <- 1
    for (r in pos_indices) {
      nb <- as.numeric(Landing_nb[r, 13:(ncol(Landing_nb) - 1)])
      wt <- as.numeric(Landing_wt[r, 13:ncol(Landing_wt)])
      Prod <- sum(nb * wt)
      if (Prod!=0 & Landing_wt[r, "LANDINGS"] !=0){
        percentage <- (Landing_wt[r, "LANDINGS"]/Prod)
      } else if (Prod==0 & Landing_wt[r, "LANDINGS"] !=0){
        percentage <- (Landing_wt[r, "LANDINGS"]/Prod)
      } else {
        percentage <- NA
      }

      if (is.na(percentage) | round(percentage, 2) > 1+(threshold/100) | round(percentage, 2) < 1-(threshold/100)) {
        Data_call$check_LANDING[r] <- round((percentage), 2)
        Data_call$sumprodl[r] <- Prod
        Data_call$SOPl[r] <- percentage
      }
      # percentage <- (Prod - Landing_wt[r, 12]) / Landing_wt[r, 12] * 100
      # if (abs(round(percentage, 2)) > threshold) {
      #   Data_call$check_LANDING[r] <- round((percentage), 2)
      # }
    }
    #-----------CHECK CONSISTENCY DISCARD--------

    Discard_nb <- Data_call[, c(1:11, 13)]
    for (i in 1:20) {
      Discard_nb <- cbind(Discard_nb, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_NO_DISCARD", sep = "")])
    }
    Discard_nb <- cbind(Discard_nb, Data_call[, colnames(Data_call) == "AGE_20_PLUS_NO_DISCARD" | colnames(Data_call) == "AGE_20_NO_DISCARD"])

    colnames(Discard_nb) <- c(colnames(Data_call[c(1:11, 13)]), paste("AGE_", c(0:19), "_NO_DISCARD", sep = ""), "AGE_20_PLUS_NO_DISCARD")


    Discard_nb[, 13:ncol(Discard_nb)][Discard_nb[, 13:ncol(Discard_nb)] == -1] <- 0
    Discard_nb$Sum <- rowSums((Discard_nb[, 13:ncol(Discard_nb)]))

    pos_indices <- which(Discard_nb$Sum > 0)

    Discard_wt <- Data_call[, c(1:11, 13)]
    for (i in 1:20) {
      Discard_wt <- cbind(Discard_wt, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_MEAN_WEIGHT_DISCARD", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_WT_DISCARD", sep = "")])
    }
    Discard_wt <- cbind(Discard_wt, Data_call[, colnames(Data_call) == "AGE_20_PLUS_MEAN_WEIGHT_DISCARD" | colnames(Data_call) == "AGE_20_WT_DISCARD"])
    colnames(Discard_wt) <- c(colnames(Data_call[c(1:11, 13)]), paste("AGE_", c(0:19), "_MEAN_WEIGHT_DISCARD", sep = ""), "AGE_20_PLUS_MEAN_WEIGHT_DISCARD")

    Discard_wt[, 13:ncol(Discard_wt)][Discard_wt[, 13:ncol(Discard_wt)] == -1] <- 0

    r=1
    for (r in pos_indices) {
      nb <- Discard_nb[r, 13:(ncol(Discard_nb) - 1)]
      wt <- Discard_wt[r, 13:ncol(Discard_wt)]
      Prod <- sum(nb * wt)
      if (Prod!=0 & Discard_wt[r, "DISCARDS"] !=0){
        percentage <- (Discard_wt[r, "DISCARDS"]/Prod)
      } else if (Prod==0 & Discard_wt[r, "DISCARDS"] !=0){
        percentage <- (Discard_wt[r, "DISCARDS"]/Prod)
      } else {
        percentage <- NA
      }
      if (is.na(percentage) | round(percentage, 2) > 1+(threshold/100) | round(percentage, 2) < 1-(threshold/100)) {
        Data_call$check_DISCARD[r] <- round((percentage), 2)
        Data_call$sumprodd[r] <- Prod
        Data_call$SOPd[r] <- percentage
      }





      # Prod <- sum(nb * wt)
      # percentage <- ifelse((Discard_wt[r, 12] == 0) & (Prod == 0), NA, (Prod - Discard_wt[r, 12]) / Discard_wt[r, 12] * 100)
      # if (!is.na(percentage) & abs(round(percentage, 2)) > threshold) {
      #   Data_call$check_DISCARD[r] <- round(percentage, 2)
      # }
    }

    # error <- Data_call[
    #   (Data_call$check_LANDING >= threshold & !is.na(Data_call$check_LANDING)) | (Data_call$check_LANDING <= threshold & !is.na(Data_call$check_LANDING)) | (Data_call$check_DISCARD >= threshold & !is.na(Data_call$check_DISCARD)) | (Data_call$check_DISCARD <= threshold & !is.na(Data_call$check_DISCARD)),
    #   c(
    #     3:8,
    #     which(colnames(Data_call) == "check_LANDING"),
    #     which(colnames(Data_call) == "check_DISCARD")
    #   )
    # ]

    errorl <- Data_call[!is.na(Data_call$check_LANDING),c("COUNTRY", "YEAR", "QUARTER",  "GEAR", "MESH_SIZE_RANGE", "FISHERY",   "AREA", "SPECIES", "LANDINGS", "sumprodl", "SOPl")]
    colnames(errorl) <- c("COUNTRY", "YEAR", "QUARTER",  "GEAR", "MESH_SIZE_RANGE", "FISHERY",   "AREA", "SPECIES", "VOLUME", "sumprod", "SOP")
    if (nrow(errorl)>0){
      errorl$DATA <- "LANDINGS"
    }

    errord <- Data_call[!is.na(Data_call$check_DISCARD),c("COUNTRY", "YEAR", "QUARTER",  "GEAR", "MESH_SIZE_RANGE", "FISHERY",   "AREA", "SPECIES", "DISCARDS", "sumprodd", "SOPd")]
    colnames(errord) <- c("COUNTRY", "YEAR", "QUARTER",  "GEAR", "MESH_SIZE_RANGE", "FISHERY",   "AREA", "SPECIES", "VOLUME", "sumprod", "SOP")
    if (nrow(errord)>0){
       errord$DATA <- "DISCARDS"
    }

    if (nrow(errorl)>0 & nrow(errord)>0) {
      error <- rbind(errorl,errord)
    } else if (nrow(errorl)==0 & nrow(errord)>0) {
      error <- errord
    } else if (nrow(errord)==0 & nrow(errorl)>0) {
      error <- errorl
    } else {
      error <- data.frame(matrix(ncol=11,nrow=0))
      colnames(errord) <- c("COUNTRY", "YEAR", "QUARTER",  "GEAR", "MESH_SIZE_RANGE", "FISHERY",   "AREA", "SPECIES", "VOLUME", "sumprod", "SOP")
    }

    if (nrow(error)>0){
       error$SOP <- round(as.numeric(error$SOP),5)
      }


    return(error)
  } else {
    if (verbose) {
      message("No data for the selected combination of SP, MS, GSA ")
    }
    df <- data.frame(matrix(ncol = 11, nrow = 0))
    colnames(df) <- c("YEAR", "QUARTER", "VESSEL_LENGTH", "GEAR", "MESH_SIZE_RANGE", "FISHERY", "check_LANDING", "check_DISCARD")
    return(df)
  }
}
