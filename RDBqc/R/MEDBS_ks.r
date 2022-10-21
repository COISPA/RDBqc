#' Kolmogorov-Smirnov test
#'
#' @param data data frame of either landings or discards data
#' @param type type of data frame. "l" for landing and "d" for discard
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param Rt ratio to be applied to subsample data to reduce the risk of rejection of H0 Hypothesis
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to perform the Kolmogorov-Smirnov test on both landings and discards for a selected species providing cumulative length distribution plots by fishery and year. The function performs Kolmogorov-Smirnov tests on couples of years to assess if they belong to the same population.
#' @return the function returns a list of data frames and cumulative distribution plots
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_ks(data = Landing_tab_example, type = "l", SP = "DPS", MS = "ITA", GSA = "GSA 9", Rt = 1)
#' @import tidyverse
#' @importFrom dplyr full_join group_by inner_join left_join summarize mutate filter
#' @importFrom magrittr %>%
#' @importFrom utils globalVariables
#' @importFrom fishmethods clus.lf
#' @importFrom tidyr pivot_longer
#' @importFrom data.table as.data.table
#' @importFrom gridExtra grid.arrange
#' @export MEDBS_ks

MEDBS_ks <- function(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE) {
  if (FALSE) {
    data <- Disc # landing # Landing_tab_example
    # splines <- c(0.2,0.4,0.6,0.8)
    # Xtresholds = c(0.25,0.5,0.75)
    type <- "d"
    # out = "mean" # "mean"
    MS <- c("ITA")
    GSA <- c("GSA 18")
    SP <- "HKE"
    Rt <- 1
    # tic()
    data <- Landing_tab_example <- as.data.table(Landing_tab_example)

    MEDBS_ks(data = Disc, type = "d", SP = "HKE", MS = "ITA", GSA = "GSA 18", Rt = 1)
  }

  . <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
  len <- variable <- dbland <- NULL
  value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- NULL

  colnames(data) <- tolower(colnames(data))
  data <- as.data.table(data)

  if (type == "l") {
    landed <- data # landed<-fread("../data/landings.csv")
    # landed$area <- as.numeric(gsub("[^0-9]", "", landed$area))
    landed$upload_id <- NA
    id_landings <- NA
    landed <- cbind(id_landings, landed)
    landed$landings[landed$landings == -1] <- 0

    ## Subsetting DataFrame, preparing data for further elaboration and setting output directory ####
    land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

    if (nrow(land) == 0) {
      if (verbose) {
        message(paste0("No landing data available for the selected species (", SP, ")"))
      }
    } else {
      var_no_landed <- grep("lengthclass", names(land), value = TRUE)
      max_no_landed <- land[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_landed]
      max_no_landed[max_no_landed == -1] <- 0
      max_no_landed2 <- max_no_landed[, -(1:7)]

      # is.na(max_no_landed)
      p <- as.data.frame(colSums(max_no_landed2, na.rm = TRUE))
      p$Length <- c(0:100)
      names(p) <- c("Sum", "Length")
      maxlength <- max(p[which(p$Sum > 0), "Length"])
      unit <- unique(land$unit)

      ###### LANDINGS #######
      cols <- c(which(colnames(land) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(land)))
      dat <- land[, cols, with = FALSE]
      lccols <- grep("lengthclass", colnames(dat))
      colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])
      ldat <- data.table::melt(dat, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value")
      ldat$start_length <- as.integer(ldat$start_length)
      ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

      LFL <- ldat %>% group_by(year,gear,fishery,start_length) %>% summarise(value=sum(value,na.rm=TRUE))
      #   aggregate(ldat$value, by = list(ldat$year, ldat$gear, ldat$fishery, ldat$start_length), sum)
      # names(LFL) <- c("year", "gear", "fishery", "start_length", "value")

      LFL$ID <- paste0(LFL$gear, "_", LFL$fishery, sep = "")
      LFL$start_length <- LFL$start_length - 1


      tempcum <- list()
      c <- 1

      for (i in unique(LFL$year)) {
        tempyr <- LFL[LFL$year %in% i, ]
        for (j in unique(tempyr$gear)) {
          tempgear <- tempyr[tempyr$gear %in% j, ]
          for (z in unique(tempgear$fishery)) {
            tempfish <- tempgear[tempgear$fishery %in% z, ]
            xout <- as.data.frame(transform(tempfish, cumFreq = cumsum(value)))
            xout$relative <- xout$cumFreq / max(xout$cumFreq)
            tempcum[[c]] <- xout
            c <- c + 1
          }
        }
      }

      db <- do.call(rbind, tempcum)

      suppressMessages(NUMBERb <- LFL %>%
        group_by(year, gear, fishery) %>%
        summarize(total_number = sum(value)))

      suppressMessages(MEANdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        summarize(mean_size = (sum(start_length * value, na.rm = T)) / sum(value, na.rm = T)))

      suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))
      LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
      LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value

      suppressMessages(SDdb <- LFL_mutate %>%
        group_by(year, gear, fishery) %>%
        summarize(sd_size = sqrt(sum(fsquare) / (sum(value) - 1))))

      suppressMessages(MINdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(min_size = min(start_length, na.rm = T)))

      suppressMessages(MAXdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(max_size = max(start_length, na.rm = T)))

      suppressMessages(final_DB <- left_join(MINdb, MEANdb))
      suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
      suppressMessages(final_DB <- left_join(final_DB, SDdb))
      suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
      suppressMessages(final_DB <- as.data.frame(final_DB))

      ###########

      LFLandings <- LFL

      LFLandings$ID1 <- paste0(LFLandings$year, LFLandings$gear, LFLandings$fishery)
      LFLandings_tot <- LFLandings %>%
        group_by(year, gear, fishery) %>%
        summarize(tot = sum(value))
      LFLandings_tot$ID1 <- paste0(LFLandings_tot$year, LFLandings_tot$gear, LFLandings_tot$fishery)
      toremove <- LFLandings_tot[LFLandings_tot$tot %in% 0, ]
      LFLandingssub <- LFLandings[!LFLandings$ID1 %in% toremove$ID1, ]
      tmpdb <- list()
      tmpdb1 <- list()
      counter <- 1
      counter1 <- 1

      i <- "OTB_DEMSP"
      plots <- list()
      for (i in unique(LFLandingssub$ID)) {
        # i="OTB_MDD"
        LFLandingsred <- LFLandingssub[LFLandingssub$ID %in% i, ]
        LFLandingsred$value <- LFLandingsred$value / Rt
        if (length(unique(LFLandingsred$year)) == 1) {
          tmpdb1[[counter1]] <- LFLandingsred
          counter1 <- counter1 + 1
        } else {
          results <- clus.lf(group = LFLandingsred$year, haul = LFLandingsred$ID, len = LFLandingsred$start_length, number = LFLandingsred$value, binsize = 0, resamples = 100)
          mdata <- as.data.frame(results$obs_prop %>% pivot_longer(names_to = "variable", values_to = "value", -len)) # melt(results$obs_prop, id=c("len"))
          plot <- ggplot(mdata, aes(x = len, y = value, col = variable)) +
            geom_line() +
            ggtitle(paste0(i, " ", SP, " ", MS, " ", GSA, " ", "Landing")) +
            xlab("Length") +
            ylab("Cumulative proportion")
          plots[[i]] <- plot
          t1 <- unlist(names(results$Drandom))
          t2 <- as.data.frame(unlist(results$results[1]))
          tmp1 <- setNames(as.data.frame(substr(t1, start = 1, stop = 4)), c("year1"))

          tmp2 <- setNames(as.data.frame(substr(t1, start = 9, stop = 12)), c("year2"))
          tmp3 <- setNames(t2, c("Ds"))
          tmp4 <- cbind(tmp1, tmp2, tmp3)
          yrSums <- as.data.frame(LFLandingsred %>% group_by(year) %>% summarize(tot = sum(value)))
          yrSums$year <- as.character(yrSums$year)
          bands2 <- left_join(tmp1, yrSums, by = c("year1" = "year"))
          bands3 <- left_join(tmp2, yrSums, by = c("year2" = "year"))
          tmp5 <- cbind(tmp4, bands2, bands3)
          tmp5$dcalc <- 1.73 * (sqrt((tmp5[, 5] + tmp5[, 7]) / (tmp5[, 5] * tmp5[, 7]))) # Formula from my book

          tmp5$H0 <- ifelse(tmp5[, 3] >= tmp5[, 8], "rejected", "accepted")
          tmp5$comment <- ifelse(tmp5[, 3] >= tmp5[, 8], "not belong to same population", "belong to same population")
          KS <- tmp5[, c(1, 2, 3, 5, 7, 8, 9, 10)]
          KS$Group <- paste0(KS$year1, " vs ", KS$year2)
          KS <- setNames(KS[, c(9, 4, 5, 3, 6, 7, 8)], c("Group", "NTot_yr1", "NTot_yr2", "Dmax", "Dcalc", "H0_p0.05", "Comment"))
          KS$ID <- i
          tmpdb[[counter]] <- KS
          counter <- counter + 1
        }
      }

      n <- length(plots)
      nsq <- round(sqrt(n), 0)
      nCol <- floor(sqrt(n))
      cols <- max(nsq, nCol)
      plots <- do.call(grid.arrange, c(plots, ncol = cols))
      KS_final_landings <- do.call(rbind, tmpdb)
      KS_noTest_landings <- do.call(rbind, tmpdb1)

      results <- list(final_DB, KS_final_landings, KS_noTest_landings, plots)
      return(results)
    } # nrow(land) > 0
  }

  ############################################################



  if (type == "d") {
    discarded <- data # fread("../data/discards.csv")
    # discarded$area <- as.numeric(gsub("[^0-9]", "", discarded$area))
    discarded$upload_id <- NA
    id_discards <- NA
    discarded <- cbind(id_discards, discarded)
    discarded$discards[discarded$discards == -1] <- 0

    disc <- discarded[which(discarded$area == GSA & discarded$country == MS & discarded$species == SP), ]
    var_no_discard <- grep("lengthclass", names(disc), value = TRUE)
    max_no_discard <- disc[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_discard]
    max_no_discard[max_no_discard == -1] <- 0
    max_no_discard2 <- max_no_discard[, -(1:7)]

    # is.na(max_no_landed)
    p <- as.data.frame(colSums(max_no_discard2, na.rm = TRUE))
    p$Length <- c(0:100)
    names(p) <- c("Sum", "Length")
    maxlength <- max(p[which(p$Sum > 0), "Length"])
    unit <- unique(disc$unit)

    cols <- c(which(colnames(disc) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(disc)))
    dat1 <- disc[, cols, with = FALSE]
    lccols <- grep("lengthclass", colnames(dat1))
    colnames(dat1)[lccols] <- gsub("[^0-9]", "", colnames(dat1)[lccols])
    ddat <- data.table::melt(dat1, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value")
    ddat$start_length <- as.integer(ddat$start_length)
    ddat[(ddat$value < 0) | is.na(ddat$value), "value"] <- 0


    LFD <- ddat %>% group_by(year,gear,fishery,start_length) %>% summarise(value=sum(value,na.rm=TRUE))
    # LFD <- aggregate(ddat$value, by = list(ddat$year, ddat$gear, ddat$fishery, ddat$start_length), sum)
    # names(LFD) <- c("year", "gear", "fishery", "start_length", "value")

    LFD$ID <- paste0(LFD$gear, "_", LFD$fishery, sep = "")
    LFD$start_length <- LFD$start_length - 1


    if (nrow(disc) > 0) {
      LFL <- LFD
      tempcum <- list()
      c <- 1
      for (i in unique(LFL$year)) {
        tempyr <- LFL[LFL$year %in% i, ]
        for (j in unique(tempyr$gear)) {
          tempgear <- tempyr[tempyr$gear %in% j, ]
          for (z in unique(tempgear$fishery)) {
            tempfish <- tempgear[tempgear$fishery %in% z, ]
            xout <- as.data.frame(transform(tempfish, cumFreq = cumsum(value)))
            xout$relative <- xout$cumFreq / max(xout$cumFreq)
            tempcum[[c]] <- xout
            c <- c + 1
          }
        }
      }


      db <- do.call(rbind, tempcum)


      suppressMessages(NUMBERb <- LFL %>%
        group_by(year, gear, fishery) %>%
        summarize(total_number = sum(value)))

      suppressMessages(MEANdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        summarize(mean_size = (sum(start_length * value, na.rm = T)) / sum(value, na.rm = T)))

      suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))
      LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
      LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value

      suppressMessages(suppressWarnings(SDdb <- LFL_mutate %>%
        group_by(year, gear, fishery) %>%
        summarize(sd_size = sqrt(sum(fsquare) / (sum(value) - 1)))))


      suppressMessages(MINdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(min_size = min(start_length, na.rm = T)))


      suppressMessages(MAXdb <- LFL %>%
        group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(max_size = max(start_length, na.rm = T)))



      suppressMessages(final_DB <- left_join(MINdb, MEANdb))
      suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
      suppressMessages(final_DB <- left_join(final_DB, SDdb))

      suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
      final_DB <- as.data.frame(final_DB)
      # tail(final_DB)

      ##################

      LFLandings <- LFL

      LFLandings$ID1 <- paste0(LFLandings$year, LFLandings$gear, LFLandings$fishery)
      suppressMessages(LFLandings_tot <- LFLandings %>%
        group_by(year, gear, fishery) %>%
        summarize(tot = sum(value)))
      LFLandings_tot$ID1 <- paste0(LFLandings_tot$year, LFLandings_tot$gear, LFLandings_tot$fishery)
      toremove <- LFLandings_tot[LFLandings_tot$tot %in% 0, ]
      LFLandingssub <- LFLandings[!LFLandings$ID1 %in% toremove$ID1, ]
      # LFLandingssub$value <-LFLandingssub$value
      tmpdb <- list()
      tmpdb1 <- list()
      counter <- 1
      counter1 <- 1

      plots <- list()
      i <- "OTB_DEF"
      for (i in unique(LFLandingssub$ID)) {
        LFLandingsred <- LFLandingssub[LFLandingssub$ID %in% i, ]
        LFLandingsred$value <- LFLandingsred$value / Rt
        if (length(unique(LFLandingsred$year)) == 1) {
          tmpdb1[[counter1]] <- LFLandingsred
          counter1 <- counter1 + 1
        } else {
          results <- clus.lf(group = LFLandingsred$year, haul = LFLandingsred$ID, len = LFLandingsred$start_length, number = LFLandingsred$value, binsize = 0, resamples = 100)
          # results$results
          mdata <- as.data.frame(results$obs_prop %>% pivot_longer(names_to = "variable", values_to = "value", -len)) # melt(results$obs_prop, id=c("len"))
          plot <- ggplot(mdata, aes(x = len, y = value, col = variable)) +
            geom_line() +
            ggtitle(paste0(i, " ", SP, " ", MS, " ", GSA, " ", "Discard")) +
            xlab("Length") +
            ylab("Cumulative proportion")
          plots[[i]] <- plot
          t1 <- unlist(names(results$Drandom))
          t2 <- as.data.frame(unlist(results$results[1]))
          tmp1 <- setNames(as.data.frame(substr(t1, start = 1, stop = 4)), c("year1"))
          # tmp1$year1 <-as.integer(levels(tmp1$year1))[tmp1$year1]
          tmp2 <- setNames(as.data.frame(substr(t1, start = 9, stop = 12)), c("year2"))
          # tmp2$year2 <-as.integer(levels(tmp2$year2))[tmp2$year2]
          tmp3 <- setNames(t2, c("Ds"))
          tmp4 <- cbind(tmp1, tmp2, tmp3)
          yrSums <- as.data.frame(LFLandingsred %>% group_by(year) %>% summarize(tot = sum(value)))
          yrSums$year <- as.character(yrSums$year)
          bands2 <- left_join(tmp1, yrSums, by = c("year1" = "year"))
          bands3 <- left_join(tmp2, yrSums, by = c("year2" = "year"))
          tmp5 <- cbind(tmp4, bands2, bands3)
          tmp5$dcalc <- 1.73 * (sqrt((tmp5[, 5] + tmp5[, 7]) / (tmp5[, 5] * tmp5[, 7]))) # Formula from my book
          # tmp5$dcalc <- 1.35810/(sqrt(tmp5[,5]+tmp5[,7])) # Another formula found at https://www.real-statistics.com/statistics-tables/kolmogorov-smirnov-table/
          # tmp5$dcalc
          tmp5$H0 <- ifelse(tmp5[, 3] >= tmp5[, 8], "rejected", "accepted")
          tmp5$comment <- ifelse(tmp5[, 3] >= tmp5[, 8], "not belong to same population", "belong to same population")
          KS <- tmp5[, c(1, 2, 3, 5, 7, 8, 9, 10)]
          KS$Group <- paste0(KS$year1, " vs ", KS$year2)
          KS <- setNames(KS[, c(9, 4, 5, 3, 6, 7, 8)], c("Group", "NTot_yr1", "NTot_yr2", "Dmax", "Dcalc", "H0_p0.05", "Comment"))
          KS$ID <- i
          tmpdb[[counter]] <- KS
          counter <- counter + 1
        }
      }

      n <- length(plots)
      nsq <- round(sqrt(n), 0)
      nCol <- floor(sqrt(n))
      cols <- max(nsq, nCol)
      plots <- do.call("grid.arrange", c(plots, ncol = cols))
      KS_final_discards <- do.call(rbind, tmpdb)
      KS_noTest_discards <- do.call(rbind, tmpdb1)

      results <- list(final_DB, KS_final_discards, KS_noTest_discards, plots)
      return(results)
    } else {
      if (verbose) {
        message(paste0("No discard data available for the selected species (", SP, ")"))
      }
    }
  }
}
