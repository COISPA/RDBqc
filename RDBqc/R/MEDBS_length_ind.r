#' Main length size indicators
#'
#' @param data data frame of either landings or discards data
#' @param type type of data frame. "l" for landing and "d" for discard
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param splines spline values assignment to fit cumulative distributions
#' @param Xtresholds threshold value
#' @param verbose boolean. If TRUE messages are returned
#' @description The function allows to check the consistency of length data for a selected species on both landings and discards: Main length size indicators
#' @return The function returns a plot of the Main length size indicators time series by fishery
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#' @examples MEDBS_length_ind(Landing_tab_example,
#'   type = "l", SP = "DPS", MS = c("ITA"),
#'   GSA = c("GSA 9"), splines = c(0.2, 0.4, 0.6, 0.8),
#'   Xtresholds = c(0.25, 0.5, 0.75)
#' )
#' MEDBS_length_ind(Discard_tab_example,
#'   type = "d", SP = "DPS", MS = c("ITA"),
#'   GSA = c("GSA 9"), splines = c(0.2, 0.4, 0.6, 0.8),
#'   Xtresholds = c(0.25, 0.5, 0.75)
#' )
#' @import tidyverse
#' @importFrom dplyr full_join
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr inner_join
#' @importFrom dplyr left_join
#' @importFrom dplyr summarize
#' @importFrom utils globalVariables
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom dplyr full_join
#' @importFrom data.table .SD
#' @importFrom utils tail
#' @importFrom stats aggregate approxfun loess predict setNames
#' @importFrom ggplot2 facet_wrap guide_legend guides
#' @importFrom data.table as.data.table
#' @export MEDBS_length_ind

MEDBS_length_ind <- function(data, type, SP, MS, GSA,
                             splines = c(0.2, 0.4, 0.6, 0.8), Xtresholds = c(0.25, 0.5, 0.75), verbose = TRUE) {
  . <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
  value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- NULL

  data <- as.data.table(data)
  colnames(data) <- tolower(colnames(data))

  if (type == "l") {
    landed <- data
    landed$upload_id <- NA
    id_landings <- NA
    landed <- cbind(id_landings, landed)
    landed$landings[landed$landings == -1] <- 0

    ## Subsetting DataFrame, preparing data for further elaboration and setting output directory ##
    land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

    if (nrow(land) < 2) {
      if (verbose) {
        message(paste0("No landing data available for the selected species (", SP, ") to perform the analysis"))
      }
      output <- NULL
    } else {
      var_no_landed <- grep("lengthclass", names(land), value = TRUE)
      max_no_landed <- land[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_landed]
      max_no_landed[max_no_landed == -1] <- 0
      max_no_landed2 <- max_no_landed[, -(1:7)]

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
      suppressWarnings(ldat <- data.table::melt(dat, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))
      ldat$start_length <- as.integer(ldat$start_length)
      ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

      LFL <- suppressMessages(ldat %>% group_by(year,gear,fishery,start_length) %>% summarise(value=sum(value)))
      # aggregate(ldat$value, by = list(ldat$year, ldat$gear, ldat$fishery, ldat$start_length), sum)
      names(LFL) <- c("year", "gear", "fishery", "start_length", "value")
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
      suppressMessages(NUMBERb <- LFL %>% group_by(year, gear, fishery) %>%
        summarize(total_number = sum(value)))
      suppressMessages(MEANdb <- LFL %>% group_by(year, gear, fishery) %>%
        summarize(mean_size = (sum(start_length * value, na.rm = T)) / sum(value, na.rm = T)))
      suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))
      LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
      LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value
      suppressMessages(SDdb <- LFL_mutate %>% group_by(year, gear, fishery) %>%
        summarize(sd_size = sqrt(sum(fsquare) / (sum(value) - 1))))
      suppressMessages(MINdb <- LFL %>% group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(min_size = min(start_length, na.rm = T)))
      suppressMessages(MAXdb <- LFL %>% group_by(year, gear, fishery) %>%
        filter(value > 0, na.rm = TRUE) %>%
        summarize(max_size = max(start_length, na.rm = T)))
      suppressMessages(final_DB <- left_join(MINdb, MEANdb))
      suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
      suppressMessages(final_DB <- left_join(final_DB, SDdb))
      suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
      suppressMessages(final_DB <- as.data.frame(final_DB))
      LFLandings <- LFL
      suppressMessages(db <- left_join(NUMBERb, db))
      dbland <- setNames(NUMBERb, c("year", "gear", "fishery", "total_number_landed"))
      dbl <- filter(db, total_number != 0)
      tmp1 <- list()
      c <- 1
      for (i in unique(dbl$year)) {
        tempyr <- dbl[dbl$year %in% i, ]
        for (j in unique(tempyr$gear)) {
          tempgear <- tempyr[tempyr$gear %in% j, ]
          for (z in unique(tempgear$fishery)) {
            tempfish <- tempgear[tempgear$fishery %in% z, ]
            for (q in unique(splines)) {
              smooth_vals <- loess(tempfish$relative ~ tempfish$start_length, span = q)

              X <- seq(0, 100, 1)
              P <- abs(predict(smooth_vals, X))
              M <- which.max(P)
              Inverse1 <- suppressWarnings(approxfun(X[1:M] ~ P[1:M]))

              db1 <- data.frame(spline = q, percentile = Xtresholds, percentile_value = Inverse1(Xtresholds))
              db1$year <- i
              db1$gear <- j
              db1$fishery <- z
              tmp1[[c]] <- db1
              c <- c + 1
            }
          }
        }
      }
      db27 <- do.call(rbind, tmp1)
      suppressMessages(LFLandingsDB <- left_join(final_DB, db27))
      result <- LFLandingsDB
      result <- result[!is.na(result$percentile_value), ]
      output <- list()
      l <- length(output) + 1
      output[[l]] <- result
      names(output)[[l]] <- "summary table"

      LFLandingsDB[is.na(LFLandingsDB$fishery), "fishery"]="NA"

      ### plot MEAN
      plot <- ggplot(LFLandingsDB[LFLandingsDB$total_number > 0, ], aes(x = as.numeric(year), y = as.numeric(mean_size), col = fishery)) +
        geom_point(col = "black") +
        geom_line() +
        facet_wrap(~gear, scales = "free") +
        scale_x_continuous(breaks = seq(min(LFLandingsDB$year), max(LFLandingsDB$year), by = 2)) +
        theme(axis.text.x = element_text(angle = 45, size = 8)) +
        theme(strip.background = element_rect(fill = "white")) +
        theme(axis.text.y = element_text(angle = 90, size = 8)) +
        ggtitle(paste0("Landing Mean Length ", SP, " ", MS, " ", GSA)) +
        xlab("") +
        ylab(paste0("Mean size ", "(", unit, ")")) +
        theme(legend.position = "bottom") +
        guides(colour = guide_legend(nrow = 1))

      l <- length(output) + 1
      output[[l]] <- plot
      names(output)[[l]] <- paste("MeanLength", SP, MS, GSA, sep = " _ ")

      #### plot MEDIAN
      plot <- ggplot(LFLandingsDB[LFLandingsDB$spline %in% 0.2 & LFLandingsDB$percentile %in% 0.50 & LFLandingsDB$total_number > 0, ], aes(x = as.numeric(year), y = as.numeric(percentile_value), col = fishery)) +
        geom_point(col = "black") +
        geom_line() +
        facet_wrap(~gear, scales = "free") +
        scale_x_continuous(breaks = seq(min(LFLandingsDB$year), max(LFLandingsDB$year), by = 2)) +
        theme(axis.text.x = element_text(angle = 45, size = 8)) +
        theme(strip.background = element_rect(fill = "white")) +
        theme(axis.text.y = element_text(angle = 90, size = 8)) +
        ggtitle(paste0("Landing Median Length ", SP, " ", MS, " ", GSA)) +
        xlab("") +
        ylab(paste0("Median size", "(", unit, ")")) +
        theme(legend.position = "bottom") +
        guides(colour = guide_legend(nrow = 1))
      print(plot)

      l <- length(output) + 1
      output[[l]] <- plot
      names(output)[[l]] <- paste("MedianLength", SP, MS, GSA, sep = " _ ")
    }
  }

  if (type == "d") {
    discarded <- data
    discarded$upload_id <- NA
    discarded$discards[discarded$discards == -1] <- 0
    disc <- discarded[which(discarded$area == GSA & discarded$country == MS & discarded$species == SP), ]

    if (nrow(disc) < 2) {
      if (verbose) {
        message(paste0("No discard data available for the selected species (", SP, ") to perform the analysis"))
      }
      output <- NULL
    } else {
      var_no_discard <- grep("lengthclass", names(disc), value = TRUE)
      max_no_discard <- disc[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_discard]
      max_no_discard[max_no_discard == -1] <- 0
      max_no_discard2 <- max_no_discard[, -(1:7)]
      p <- as.data.frame(colSums(max_no_discard2, na.rm = TRUE))
      p$Length <- c(0:100)
      names(p) <- c("Sum", "Length")

      if (sum(p$Sum) > 0) {
        maxlength <- max(p[which(p$Sum > 0), "Length"])
        unit <- unique(disc$unit)
        cols <- c(which(colnames(disc) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(disc)))
        dat1 <- disc[, cols, with = FALSE]
        lccols <- grep("lengthclass", colnames(dat1))
        colnames(dat1)[lccols] <- gsub("[^0-9]", "", colnames(dat1)[lccols])
        suppressWarnings(ddat <- data.table::melt(dat1, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))
        ddat$start_length <- as.integer(ddat$start_length)
        ddat[(ddat$value < 0) | is.na(ddat$value), "value"] <- 0
        LFD <- suppressMessages(ddat %>% group_by(year,gear,fishery,start_length) %>% summarise(value=sum(value)))
        # aggregate(ddat$value, by = list(ddat$year, ddat$gear, ddat$fishery, ddat$start_length), sum)
        names(LFD) <- c("year", "gear", "fishery", "start_length", "value")
        LFD$ID <- paste0(LFD$gear, "_", LFD$fishery, sep = "")
        LFD$start_length <- LFD$start_length - 1
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
        suppressMessages(NUMBERb <- LFL %>% group_by(year, gear, fishery) %>%
          summarize(total_number = sum(value)))
        suppressMessages(MEANdb <- LFL %>% group_by(year, gear, fishery) %>%
          summarize(mean_size = (sum(start_length * value, na.rm = T)) / sum(value, na.rm = T)))
        suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))
        LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
        LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value
        suppressMessages(SDdb <- suppressWarnings(LFL_mutate %>% group_by(year, gear, fishery) %>% summarize(sd_size = sqrt(sum(fsquare) / (sum(value) - 1)))))
        suppressMessages(MINdb <- LFL %>% group_by(year, gear, fishery) %>%
          filter(value > 0, na.rm = TRUE) %>%
          summarize(min_size = min(start_length, na.rm = T)))
        suppressMessages(MAXdb <- LFL %>% group_by(year, gear, fishery) %>%
          filter(value > 0, na.rm = TRUE) %>%
          summarize(max_size = max(start_length, na.rm = T)))
        suppressMessages(final_DB <- left_join(MINdb, MEANdb))
        suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
        suppressMessages(final_DB <- left_join(final_DB, SDdb))
        suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
        final_DB <- as.data.frame(final_DB)
        LFDiscards <- LFL
        suppressMessages(db <- left_join(NUMBERb, db))
        dbdisc <- setNames(NUMBERb, c("year", "gear", "fishery", "total_number_discarded"))
        dbs <- filter(db, total_number != 0)
        tmp1 <- list()
        c <- 1
        for (i in unique(dbs$year)) {
          tempyr <- dbs[dbs$year %in% i, ]
          for (j in unique(tempyr$gear)) {
            tempgear <- tempyr[tempyr$gear %in% j, ]
            for (z in unique(tempgear$fishery)) {
              tempfish <- tempgear[tempgear$fishery %in% z, ]
              for (q in unique(splines)) {
                smooth_vals <- loess(tempfish$relative ~ tempfish$start_length, span = q)
                X <- seq(0, 100, 1)
                P <- abs(predict(smooth_vals, X))
                M <- which.max(P)
                Inverse1 <- suppressWarnings(approxfun(X[1:M] ~ P[1:M]))
                db1 <- data.frame(spline = q, percentile = Xtresholds, percentile_value = Inverse1(Xtresholds))
                db1$year <- i
                db1$gear <- j
                db1$fishery <- z
                tmp1[[c]] <- db1
                c <- c + 1
              }
            }
          }
        }
        db27 <- do.call(rbind, tmp1)
        suppressMessages(LFDiscardsDB <- left_join(final_DB, db27))
        result <- LFDiscardsDB
        result <- result[!is.na(result$percentile_value), ]
        output <- list()
        l <- length(output) + 1
        output[[l]] <- result
        names(output)[[l]] <- "summary table"

        LFDiscardsDB[is.na(LFDiscardsDB$fishery), "fishery"]="NA"

        ### Plot MEAN
        plot <- ggplot(LFDiscardsDB[LFDiscardsDB$total_number > 0, ], aes(x = as.numeric(year), y = as.numeric(mean_size), col = fishery)) +
          geom_point() +
          geom_line() +
          facet_wrap(~gear, scales = "free") +
          scale_x_continuous(breaks = seq(min(LFDiscardsDB$year), max(LFDiscardsDB$year), by = 2)) +
          theme(axis.text.x = element_text(angle = 45, size = 8)) +
          theme(strip.background = element_rect(fill = "white")) +
          theme(axis.text.y = element_text(angle = 90, size = 8)) +
          ggtitle(paste0("Discard Mean Length ", SP, " ", MS, " ", GSA)) +
          xlab("") +
          ylab(paste0("Mean size", "(", unit, ")")) +
          theme(legend.position = "bottom") +
          guides(colour = guide_legend(nrow = 1))
        l <- length(output) + 1
        output[[l]] <- plot
        names(output)[[l]] <- paste("MeanLength", SP, MS, GSA, sep = " _ ")

        ### Plot MEDIAN
        plot <- ggplot(LFDiscardsDB[LFDiscardsDB$spline %in% 0.2 & LFDiscardsDB$percentile %in% 0.50 & LFDiscardsDB$total_number > 0, ], aes(x = as.numeric(year), y = as.numeric(percentile_value), col = fishery)) +
          geom_point() +
          geom_line() +
          facet_wrap(~gear, scales = "free") +
          scale_x_continuous(breaks = seq(min(LFDiscardsDB$year), max(LFDiscardsDB$year), by = 2)) +
          theme(axis.text.x = element_text(angle = 45, size = 8)) +
          theme(strip.background = element_rect(fill = "white")) +
          theme(axis.text.y = element_text(angle = 90, size = 8)) +
          ggtitle(paste0("Discard Median Length ", SP, " ", MS, " ", GSA)) +
          xlab("") +
          ylab(paste0("Median size", "(", unit, ")")) +
          theme(legend.position = "bottom") +
          guides(colour = guide_legend(nrow = 1))
        l <- length(output) + 1
        output[[l]] <- plot
        names(output)[[l]] <- paste("MedianLength", SP, MS, GSA, sep = " _ ")
      } else {
        print("No discards data available for this stock")
        output <- NULL
      }
    }
  }
  return(output)
}
