#' Years with missing length distributions
#'
#' @param data data frame of landings or discards data
#' @param type type of data frame. "l" for landing and "d" for discard
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @description The function checks the presence of years with missing length distributions in both landings and discards for a selected species.
#' @return The function returns a data frame containing the reference combination of year, gear and fishery missing length distributions.
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_yr_missing_length(data = Discard_tab_example, type = "d",
#' SP = "DPS", MS = "ITA", GSA = "GSA 9")
#' MEDBS_yr_missing_length(data = Landing_tab_example, type = "l", SP = "DPS",
#' MS = "ITA", GSA = "GSA 9")
#' @import tidyverse
#' @importFrom dplyr full_join group_by inner_join left_join summarize mutate filter
#' @importFrom magrittr %>%
#' @importFrom utils globalVariables
#' @importFrom fishmethods clus.lf
#' @importFrom tidyr pivot_longer
#' @importFrom data.table as.data.table
#' @export MEDBS_yr_missing_length

MEDBS_yr_missing_length <- function(data, type, SP, MS, GSA, verbose=FALSE) {
  if (FALSE) {
    # library(ggplot2)
    # library(data.table)
    # library(tidyverse)
    # library(fishmethods)
    data <- Landing_tab_example # Disc # Discard_tab_example #
    # splines <- c(0.2,0.4,0.6,0.8)
    # Xtresholds = c(0.25,0.5,0.75)
    type <- "l"
    # out = "mean" # "mean"
    MS <- c("ITA")
    GSA <- c("GSA 9")
    SP <- "DPS"
    # tic()

    MEDBS_yr_missing_length(data = Disc, type = "d", SP = "HKE", MS = "ITA", GSA = "GSA 18")
  }

  . <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
  len <- variable <- dbland <- NULL
  value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- NULL

  data <- as.data.table(data)
  colnames(data) <- tolower(colnames(data))

  if (type == "l") {
    landed <- data # landed<-fread("../data/landings.csv")
    # landed$area <- as.numeric(gsub("[^0-9]", "", landed$area))
    landed$upload_id <- NA
    id_landings <- NA
    landed <- cbind(id_landings, landed)
    landed$landings[landed$landings == -1] <- 0

    ## Subsetting DataFrame, preparing data for further elaboration and setting output directory ####
    land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

    if (nrow(land) >0) {

    var_no_landed <- grep("lengthclass", names(land), value = TRUE)
    land <- as.data.table(land)
    max_no_landed <- land[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_landed]
    max_no_landed[max_no_landed == -1] <- 0
    max_no_landed2 <- max_no_landed[, -(1:7)]

    # is.na(max_no_landed)
    p <- as.data.frame(colSums(max_no_landed2, na.rm = TRUE))
    p$Length <- c(0:100)
    names(p) <- c("Sum", "Length")
    maxlength <- suppressWarnings(max(p[which(p$Sum > 0), "Length"]))
    unit <- unique(land$unit)

    ###### LANDINGS #######
    cols <- c(which(colnames(land) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(land)))
    dat <- land[, cols, with = FALSE]
    lccols <- grep("lengthclass", colnames(dat))
    colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])
    ldat <- suppressWarnings(data.table::melt(dat, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))
    ldat$start_length <- as.integer(ldat$start_length)
    ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

    LFL <- aggregate(ldat$value, by = list(ldat$year, ldat$gear, ldat$fishery, ldat$start_length), sum)
    names(LFL) <- c("year", "gear", "fishery", "start_length", "value")
    LFL$ID <- paste0(LFL$gear, "_", LFL$fishery, sep = "")
    LFL$start_length <- LFL$start_length - 1

    # tempcum <- list()
    # c=1
    #
    # for (i in unique(LFL$year)){
    #     tempyr <- LFL[LFL$year%in%i,]
    #     for(j in unique(tempyr$gear)){
    #         tempgear <- tempyr[tempyr$gear%in%j,]
    #         for(z in unique(tempgear$fishery)){
    #             tempfish <- tempgear[tempgear$fishery%in%z,]
    #             xout <- as.data.frame(transform(tempfish, cumFreq = cumsum(value)))
    #             xout$relative = xout$cumFreq/max(xout$cumFreq)
    #             tempcum[[c]] <- xout
    #             c=c+1
    #         }
    #     }
    # }
    #
    # db <- do.call(rbind,tempcum)

    suppressMessages(NUMBERb <- LFL %>% group_by(year, gear, fishery) %>% summarize(total_number = sum(value)))

    dbland <- setNames(NUMBERb, c("year", "gear", "fishery", "total_number_landed"))
    yr_missing_land <- as.data.frame(dbland[dbland$total_number_landed %in% 0, ])

    if (nrow(yr_missing_land) > 0) {
      return(yr_missing_land)
    } else {
      return(NULL)
    }

    } else {
      return(NULL)
    }


  }

  ############################################################



  if (type == "d") {
    discarded <- data # fread("../data/discards.csv")
    # discarded$area <- as.numeric(gsub("[^0-9]", "", discarded$area))
    discarded$upload_id <- NA
    discarded$discards[discarded$discards == -1] <- 0

    disc <- discarded[which(discarded$area == GSA & discarded$country == MS & discarded$species == SP), ]

    if (nrow(disc)>0) {

    var_no_discard <- grep("lengthclass", names(disc), value = TRUE)
    max_no_discard <- disc[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_discard]
    max_no_discard[max_no_discard == -1] <- 0
    max_no_discard2 <- max_no_discard[, -(1:7)]

    # is.na(max_no_landed)
    p <- as.data.frame(colSums(max_no_discard2, na.rm = TRUE))
    p$Length <- c(0:100)
    names(p) <- c("Sum", "Length")

    if (sum( p$Sum )> 0) {

    maxlength <- max(p[which(p$Sum > 0), "Length"])
    unit <- unique(disc$unit)

    cols <- c(which(colnames(disc) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(disc)))
    dat1 <- disc[, cols, with = FALSE]
    lccols <- grep("lengthclass", colnames(dat1))
    colnames(dat1)[lccols] <- gsub("[^0-9]", "", colnames(dat1)[lccols])
    ddat <- suppressWarnings(data.table::melt(dat1, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))
    ddat$start_length <- as.integer(ddat$start_length)
    ddat[(ddat$value < 0) | is.na(ddat$value), "value"] <- 0

    LFD <- aggregate(ddat$value, by = list(ddat$year, ddat$gear, ddat$fishery, ddat$start_length), sum)
    names(LFD) <- c("year", "gear", "fishery", "start_length", "value")
    LFD$ID <- paste0(LFD$gear, "_", LFD$fishery, sep = "")
    LFD$start_length <- LFD$start_length - 1


    # if (nrow(disc) > 0) {


      # tempcum <- list()
      # c=1
      # for (i in unique(LFL$year)){
      #     tempyr <- LFL[LFL$year%in%i,]
      #     for(j in unique(tempyr$gear)){
      #         tempgear <- tempyr[tempyr$gear%in%j,]
      #         for(z in unique(tempgear$fishery)){
      #             tempfish <- tempgear[tempgear$fishery%in%z,]
      #             xout <- as.data.frame(transform(tempfish, cumFreq = cumsum(value)))
      #             xout$relative = xout$cumFreq/max(xout$cumFreq)
      #             tempcum[[c]] <- xout
      #             c=c+1
      #         }
      #     }
      # }
      #
      #
      # db <- do.call(rbind,tempcum)

      suppressMessages(NUMBERb <- LFD %>% group_by(year, gear, fishery) %>% summarize(total_number = sum(value)))

      dbdisc <- setNames(NUMBERb, c("year", "gear", "fishery", "total_number_discarded"))
      yr_missing_disc <- as.data.frame(dbdisc[dbdisc$total_number_discarded %in% 0, ])

      if (nrow(yr_missing_disc) > 0) {
        return(yr_missing_disc)
      } else {
        return(yr_missing_disc)
      }
    } else {
      if (verbose){
        print("No discards data available for this stock")
      }
      return(NULL)
    }

    } else {
      return(NULL)
    }


  }
}
