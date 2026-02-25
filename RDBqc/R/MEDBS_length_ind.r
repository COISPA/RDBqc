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
#' @param embedded boolean. If TRUE, the function generates only Min, Median and Max
#'   in a single combined plot. If FALSE, the combined plot includes also Mean, 25th and 75th percentiles.
#'
#' @description The function allows to check the consistency of length data for a selected species
#'   on both landings and discards: Main length size indicators. The function keeps the same
#'   calculations and checks of the original implementation, but it returns a single combined
#'   time series plot (instead of multiple plots).
#'
#' @return The function returns a list containing a summary table and a combined plot of length indicators.
#'
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#'
#' @examples
#' MEDBS_length_ind(Landing_tab_example,
#'   type = "l", SP = "DPS", MS = c("ITA"),
#'   GSA = c("GSA 9"), splines = c(0.2, 0.4, 0.6, 0.8),
#'   Xtresholds = c(0.25, 0.5, 0.75), embedded = FALSE
#' )
#' MEDBS_length_ind(Discard_tab_example,
#'   type = "d", SP = "DPS", MS = c("ITA"),
#'   GSA = c("GSA 9"), splines = c(0.2),
#'   Xtresholds = c(0.5), embedded = TRUE
#' )
#'
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
                             splines = c(0.2, 0.4, 0.6, 0.8),
                             Xtresholds = c(0.25, 0.5, 0.75),
                             verbose = TRUE,
                             embedded = FALSE) {

  . <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
  value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- max_size <- min_size <- NULL

  data <- as.data.table(data)
  colnames(data) <- tolower(colnames(data))

  #---------
  # Early filtering to avoid preprocessing the full dataset on repeated calls
  if (all(c("area", "country", "species") %in% names(data))) {
    data <- data[area == GSA & country == MS & species == SP]
  }

  data <- as.data.frame(data)

  var_no_landed <- grep("lengthclass", names(data), value = TRUE)
  sel_nl <- c(var_no_landed)
  cols_no_length <- colnames(data)[which(!colnames(data) %in% sel_nl)]
  length_cols <- (data[, which(names(data) %in% sel_nl), drop = FALSE])

  # Convert length columns without materializing a matrix
  length_cols <- suppressWarnings(as.data.frame(lapply(length_cols, function(x) as.numeric(as.character(x)))))
  length_cols[is.na(length_cols)] <- 0

  no_lenght_col <- data[, which(colnames(data) %in% cols_no_length), drop = FALSE]
  data <- cbind(no_lenght_col, length_cols)
  #-------------

  if (type == "l") {

    landed <- data
    landed$upload_id <- rep(NA, nrow(landed))
    id_landings <- rep(NA, nrow(landed))
    landed <- cbind(id_landings = id_landings, landed)
    landed$landings[landed$landings == -1] <- 0

    land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

    if (nrow(land) < 2) {
      if (verbose) {
        message(paste0(
          "No landing data available for the selected species (",
          SP, ") to perform the analysis"
        ))
      }
      output <- NULL

    } else {

      var_no_landed <- grep("lengthclass", names(land), value = TRUE)
      land <- data.table(land)

      max_no_landed <- land[, lapply(.SD, max),
                            by = .(country, area, species, year, gear, mesh_size_range, fishery),
                            .SDcols = var_no_landed]

      max_no_landed[max_no_landed == -1] <- 0
      max_no_landed2 <- max_no_landed[, -(1:7)]

      p <- as.data.frame(colSums(max_no_landed2, na.rm = TRUE))
      p$Length <- c(0:100)
      names(p) <- c("Sum", "Length")

      if (sum(p$Sum) > 0) {

        maxlength <- max(p[which(p$Sum > 0), "Length"])
        unit <- unique(land$unit)

        cols <- c(
          which(colnames(land) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")),
          grep("lengthclass", colnames(land))
        )

        dat <- land[, cols, with = FALSE]

        lccols <- grep("lengthclass", colnames(dat))
        colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])

        suppressWarnings(
          ldat <- data.table::melt(
            dat,
            id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"),
            variable.name = "start_length",
            value.name = "value"
          )
        )

        ldat$start_length <- as.integer(ldat$start_length)
        ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

        LFL <- suppressMessages(ldat %>%
                                  group_by(year, gear, fishery, start_length) %>%
                                  summarise(value = sum(value)))

        names(LFL) <- c("year", "gear", "fishery", "start_length", "value")
        LFL$ID <- paste0(LFL$gear, "_", LFL$fishery, sep = "")
        LFL$start_length <- LFL$start_length - 1

        # Compute cumulative distributions by group (same logic as nested loops)
        LFL_dt <- as.data.table(LFL)
        data.table::setorder(LFL_dt, year, gear, fishery, start_length)

        db <- LFL_dt[, {
          cumFreq <- cumsum(value)
          .(
            start_length = start_length,
            value = value,
            ID = ID,
            cumFreq = cumFreq,
            relative = cumFreq / max(cumFreq)
          )
        }, by = .(year, gear, fishery)]
        db <- as.data.frame(db)

        suppressMessages(NUMBERb <- LFL %>% group_by(year, gear, fishery) %>% summarize(total_number = sum(value)))
        suppressMessages(MEANdb <- LFL %>% group_by(year, gear, fishery) %>% summarize(mean_size = (sum(start_length * value, na.rm = TRUE)) / sum(value, na.rm = TRUE)))
        suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))

        LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
        LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value

        suppressMessages(
          SDdb <- suppressWarnings(
            LFL_mutate %>%
              group_by(year, gear, fishery) %>%
              summarize(sd_size = sqrt(sum(fsquare) / (sum(value) - 1)))
          )
        )
        suppressMessages(MINdb <- LFL %>% group_by(year, gear, fishery) %>% filter(value > 0, na.rm = TRUE) %>% summarize(min_size = min(start_length, na.rm = TRUE)))
        suppressMessages(MAXdb <- LFL %>% group_by(year, gear, fishery) %>% filter(value > 0, na.rm = TRUE) %>% summarize(max_size = max(start_length, na.rm = TRUE)))

        suppressMessages(final_DB <- left_join(MINdb, MEANdb))
        suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
        suppressMessages(final_DB <- left_join(final_DB, SDdb))
        suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
        suppressMessages(final_DB <- as.data.frame(final_DB))

        suppressMessages(db <- left_join(NUMBERb, db))
        dbl <- filter(db, total_number != 0)

        tmp1 <- list()
        c <- 1

        # Define X once (avoid re-allocations in the inner loop)
        X <- seq(0, 100, 1)

        for (i in unique(dbl$year)) {
          tempyr <- dbl[dbl$year %in% i, ]
          for (j in unique(tempyr$gear)) {
            tempgear <- tempyr[tempyr$gear %in% j, ]
            for (z in unique(tempgear$fishery)) {
              tempfish <- tempgear[tempgear$fishery %in% z, ]
              for (q in unique(splines)) {
                smooth_vals <- loess(tempfish$relative ~ tempfish$start_length, span = q)
                P <- abs(predict(smooth_vals, X))
                M <- which.max(P)
                Inverse1 <- suppressWarnings(approxfun(X[1:M] ~ P[1:M]))

                db1 <- data.frame(
                  spline = q,
                  percentile = Xtresholds,
                  percentile_value = Inverse1(Xtresholds)
                )
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

        LFLandingsDB[is.na(LFLandingsDB$fishery), "fishery"] <- "NA"

        # ============================================================
        # SINGLE COMBINED PLOT (same checks, same data, only plotting differs)
        # Requested style: only different colours for series; same linetype;
        # points and lines share the same colour; facet by gear x fishery.
        # ============================================================

        base_ts <- LFLandingsDB[LFLandingsDB$total_number > 0, ]
        if (nrow(base_ts) == 0) {
          return(output)
        }

        # Always keep these base metrics from final_DB join
        comb <- unique(base_ts[, c("year", "gear", "fishery", "min_size", "mean_size", "max_size")])

        # Percentiles kept exactly as original plots: spline == 0.2
        want_perc <- if (isTRUE(embedded)) c(0.5) else c(0.25, 0.5, 0.75)

        perc_df <- base_ts[
          base_ts$spline %in% 0.2 & base_ts$percentile %in% want_perc,
          c("year", "gear", "fishery", "percentile", "percentile_value")
        ]

        if (nrow(perc_df) > 0) {
          perc_wide <- suppressMessages(
            tidyr::pivot_wider(
              perc_df,
              names_from = percentile,
              values_from = percentile_value
            )
          )
          names(perc_wide) <- gsub("^0\\.25$", "p25", names(perc_wide))
          names(perc_wide) <- gsub("^0\\.5$",  "p50", names(perc_wide))
          names(perc_wide) <- gsub("^0\\.75$", "p75", names(perc_wide))

          comb <- suppressMessages(dplyr::left_join(comb, perc_wide, by = c("year", "gear", "fishery")))
        } else {
          comb$p50 <- NA_real_
          if (!isTRUE(embedded)) {
            comb$p25 <- NA_real_
            comb$p75 <- NA_real_
          }
        }

        # Build long data in a robust way (avoids unequal-length vector issues)
        if (isTRUE(embedded)) {
          stat_keep <- c("min_size", "p50", "max_size")
          stat_lab  <- c(min_size = "Min", p50 = "Median", max_size = "Max")
        } else {
          stat_keep <- c("min_size", "mean_size", "p25", "p50", "p75", "max_size")
          stat_lab  <- c(min_size = "Min", mean_size = "Mean", p25 = "P25", p50 = "Median", p75 = "P75", max_size = "Max")
        }

        plot_df <- comb %>%
          dplyr::select(year, gear, fishery, dplyr::all_of(stat_keep)) %>%
          tidyr::pivot_longer(
            cols = dplyr::all_of(stat_keep),
            names_to = "STAT",
            values_to = "VALUE"
          ) %>%
          dplyr::mutate(STAT = stat_lab[STAT]) %>%
          dplyr::filter(!is.na(VALUE))

        if (nrow(plot_df) == 0) {
          return(output)
        }

        stat_levels <- if (isTRUE(embedded)) {
          c("Min", "Median", "Max")
        } else {
          c("Min", "Mean", "P25", "Median", "P75", "Max")
        }
        plot_df$STAT <- factor(plot_df$STAT, levels = stat_levels)

        x_breaks <- if (dplyr::n_distinct(plot_df$year) <= 1) unique(plot_df$year) else seq(min(plot_df$year), max(plot_df$year), by = 2)

        plot <- ggplot(plot_df, aes(
          x = as.numeric(year),
          y = as.numeric(VALUE),
          colour = STAT,
          group = interaction(gear, fishery, STAT)
        )) +
          geom_line() +
          geom_point(size = 2) +
          facet_grid(gear ~ fishery, scales = "free") +
          scale_x_continuous(breaks = x_breaks) +
          theme(axis.text.x = element_text(angle = 45, size = 8)) +
          theme(strip.background = element_rect(fill = "white")) +
          theme(axis.text.y = element_text(angle = 90, size = 8)) +
          ggtitle(paste0(
            "Landing length indicators (",
            paste(stat_levels, collapse = ", "),
            ") ", SP, " ", MS, " ", GSA
          )) +
          xlab("") +
          ylab(paste0("Length (", unit, ")")) +
          theme(legend.position = "bottom") +
          guides(colour = guide_legend(nrow = 1))

        l <- length(output) + 1
        output[[l]] <- plot
        names(output)[[l]] <- paste("LengthIndicators_L", SP, MS, GSA, sep = " _ ")

      } else {
        print("No landings data available for this stock")
        output <- NULL
      }
    }
  }

  if (type == "d") {

    #-----------------------------
    data <- as.data.frame(data)
    var_no_landed <- grep("lengthclass", names(data), value = TRUE)
    sel_nl <- c(var_no_landed)
    cols_no_length <- colnames(data)[which(!colnames(data) %in% sel_nl)]
    length_cols <- (data[, which(names(data) %in% sel_nl), drop = FALSE])
    length_cols <- suppressWarnings(as.data.frame(lapply(length_cols, function(x) as.numeric(as.character(x)))))
    length_cols[is.na(length_cols)] <- 0
    no_lenght_col <- data[, which(colnames(data) %in% cols_no_length), drop = FALSE]
    data <- cbind(no_lenght_col, length_cols)
    #-----------------------------

    discarded <- data
    discarded$upload_id <- rep(NA, nrow(discarded))
    discarded$discards[discarded$discards == -1] <- 0

    disc <- discarded[which(discarded$area == GSA & discarded$country == MS & discarded$species == SP), ]

    if (nrow(disc) < 2) {
      if (verbose) {
        message(paste0(
          "No discard data available for the selected species (",
          SP, ") to perform the analysis"
        ))
      }
      output <- NULL

    } else {

      var_no_discard <- grep("lengthclass", names(disc), value = TRUE)
      disc <- as.data.table(disc)

      max_no_discard <- disc[, lapply(.SD, max),
                             by = .(country, area, species, year, gear, mesh_size_range, fishery),
                             .SDcols = var_no_discard]
      max_no_discard[max_no_discard == -1] <- 0

      max_no_discard2 <- max_no_discard[, -(1:7)]
      p <- as.data.frame(colSums(max_no_discard2, na.rm = TRUE))
      p$Length <- c(0:100)
      names(p) <- c("Sum", "Length")

      if (sum(p$Sum) > 0) {

        maxlength <- max(p[which(p$Sum > 0), "Length"])
        unit <- unique(disc$unit)

        cols <- c(
          which(colnames(disc) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")),
          grep("lengthclass", colnames(disc))
        )

        dat1 <- disc[, cols, with = FALSE]

        lccols <- grep("lengthclass", colnames(dat1))
        colnames(dat1)[lccols] <- gsub("[^0-9]", "", colnames(dat1)[lccols])

        suppressWarnings(
          ddat <- data.table::melt(
            dat1,
            id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"),
            variable.name = "start_length",
            value.name = "value"
          )
        )

        ddat$start_length <- as.integer(ddat$start_length)
        ddat[(ddat$value < 0) | is.na(ddat$value), "value"] <- 0

        LFD <- suppressMessages(ddat %>%
                                  group_by(year, gear, fishery, start_length) %>%
                                  summarise(value = sum(value)))

        names(LFD) <- c("year", "gear", "fishery", "start_length", "value")
        LFD$ID <- paste0(LFD$gear, "_", LFD$fishery, sep = "")
        LFD$start_length <- LFD$start_length - 1

        LFL <- LFD

        # Compute cumulative distributions by group (same logic as nested loops)
        LFL_dt <- as.data.table(LFL)
        data.table::setorder(LFL_dt, year, gear, fishery, start_length)

        db <- LFL_dt[, {
          cumFreq <- cumsum(value)
          .(
            start_length = start_length,
            value = value,
            ID = ID,
            cumFreq = cumFreq,
            relative = cumFreq / max(cumFreq)
          )
        }, by = .(year, gear, fishery)]
        db <- as.data.frame(db)

        suppressMessages(NUMBERb <- LFL %>% group_by(year, gear, fishery) %>% summarize(total_number = sum(value)))
        suppressMessages(MEANdb <- LFL %>% group_by(year, gear, fishery) %>% summarize(mean_size = (sum(start_length * value, na.rm = TRUE)) / sum(value, na.rm = TRUE)))
        suppressMessages(LFL_mutate <- inner_join(LFL, MEANdb))

        LFL_mutate$square <- (LFL_mutate$start_length - LFL_mutate$mean_size)^2
        LFL_mutate$fsquare <- LFL_mutate$square * LFL_mutate$value

        suppressMessages(
          SDdb <- LFL_mutate %>%
            group_by(year, gear, fishery) %>%
            summarize(
              sd_size = {
                n_eff <- sum(value, na.rm = TRUE)
                if (is.na(n_eff) || n_eff <= 1) NA_real_ else sqrt(sum(fsquare, na.rm = TRUE) / (n_eff - 1))
              }
            )
        )
        suppressMessages(MINdb <- LFL %>% group_by(year, gear, fishery) %>% filter(value > 0, na.rm = TRUE) %>% summarize(min_size = min(start_length, na.rm = TRUE)))
        suppressMessages(MAXdb <- LFL %>% group_by(year, gear, fishery) %>% filter(value > 0, na.rm = TRUE) %>% summarize(max_size = max(start_length, na.rm = TRUE)))

        suppressMessages(final_DB <- left_join(MINdb, MEANdb))
        suppressMessages(final_DB <- inner_join(final_DB, MAXdb))
        suppressMessages(final_DB <- left_join(final_DB, SDdb))
        suppressMessages(final_DB <- left_join(NUMBERb, final_DB))
        final_DB <- as.data.frame(final_DB)

        suppressMessages(db <- left_join(NUMBERb, db))
        dbs <- filter(db, total_number != 0)

        tmp1 <- list()
        c <- 1

        X <- seq(0, 100, 1)

        for (i in unique(dbs$year)) {
          tempyr <- dbs[dbs$year %in% i, ]
          for (j in unique(tempyr$gear)) {
            tempgear <- tempyr[tempyr$gear %in% j, ]
            for (z in unique(tempgear$fishery)) {
              tempfish <- tempgear[tempgear$fishery %in% z, ]
              for (q in unique(splines)) {
                smooth_vals <- loess(tempfish$relative ~ tempfish$start_length, span = q)
                P <- abs(predict(smooth_vals, X))
                M <- which.max(P)
                Inverse1 <- suppressWarnings(approxfun(X[1:M] ~ P[1:M]))

                db1 <- data.frame(
                  spline = q,
                  percentile = Xtresholds,
                  percentile_value = Inverse1(Xtresholds)
                )
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

        LFDiscardsDB[is.na(LFDiscardsDB$fishery), "fishery"] <- "NA"

        # ============================================================
        # SINGLE COMBINED PLOT (same checks, same data, only plotting differs)
        # Requested style: only different colours for series; same linetype;
        # points and lines share the same colour; facet by gear x fishery.
        # ============================================================

        base_ts <- LFDiscardsDB[LFDiscardsDB$total_number > 0, ]
        if (nrow(base_ts) == 0) {
          return(output)
        }

        comb <- unique(base_ts[, c("year", "gear", "fishery", "min_size", "mean_size", "max_size")])

        want_perc <- if (isTRUE(embedded)) c(0.5) else c(0.25, 0.5, 0.75)

        perc_df <- base_ts[
          base_ts$spline %in% 0.2 & base_ts$percentile %in% want_perc,
          c("year", "gear", "fishery", "percentile", "percentile_value")
        ]

        if (nrow(perc_df) > 0) {
          perc_wide <- suppressMessages(
            tidyr::pivot_wider(
              perc_df,
              names_from = percentile,
              values_from = percentile_value
            )
          )
          names(perc_wide) <- gsub("^0\\.25$", "p25", names(perc_wide))
          names(perc_wide) <- gsub("^0\\.5$",  "p50", names(perc_wide))
          names(perc_wide) <- gsub("^0\\.75$", "p75", names(perc_wide))

          comb <- suppressMessages(dplyr::left_join(comb, perc_wide, by = c("year", "gear", "fishery")))
        } else {
          comb$p50 <- NA_real_
          if (!isTRUE(embedded)) {
            comb$p25 <- NA_real_
            comb$p75 <- NA_real_
          }
        }

        if (isTRUE(embedded)) {
          stat_keep <- c("min_size", "p50", "max_size")
          stat_lab  <- c(min_size = "Min", p50 = "Median", max_size = "Max")
        } else {
          stat_keep <- c("min_size", "mean_size", "p25", "p50", "p75", "max_size")
          stat_lab  <- c(min_size = "Min", mean_size = "Mean", p25 = "P25", p50 = "Median", p75 = "P75", max_size = "Max")
        }

        plot_df <- comb %>%
          dplyr::select(year, gear, fishery, dplyr::all_of(stat_keep)) %>%
          tidyr::pivot_longer(
            cols = dplyr::all_of(stat_keep),
            names_to = "STAT",
            values_to = "VALUE"
          ) %>%
          dplyr::mutate(STAT = stat_lab[STAT]) %>%
          dplyr::filter(!is.na(VALUE))

        if (nrow(plot_df) == 0) {
          return(output)
        }

        stat_levels <- if (isTRUE(embedded)) {
          c("Min", "Median", "Max")
        } else {
          c("Min", "Mean", "P25", "Median", "P75", "Max")
        }
        plot_df$STAT <- factor(plot_df$STAT, levels = stat_levels)

        x_breaks <- if (dplyr::n_distinct(plot_df$year) <= 1) unique(plot_df$year) else seq(min(plot_df$year), max(plot_df$year), by = 2)

        plot <- ggplot(plot_df, aes(
          x = as.numeric(year),
          y = as.numeric(VALUE),
          colour = STAT,
          group = interaction(gear, fishery, STAT)
        )) +
          geom_line() +
          geom_point(size = 2) +
          facet_grid(gear ~ fishery, scales = "free") +
          scale_x_continuous(breaks = x_breaks) +
          theme(axis.text.x = element_text(angle = 45, size = 8)) +
          theme(strip.background = element_rect(fill = "white")) +
          theme(axis.text.y = element_text(angle = 90, size = 8)) +
          ggtitle(paste0(
            "Discard length indicators (",
            paste(stat_levels, collapse = ", "),
            ") ", SP, " ", MS, " ", GSA
          )) +
          xlab("") +
          ylab(paste0("Length (", unit, ")")) +
          theme(legend.position = "bottom") +
          guides(colour = guide_legend(nrow = 1))

        l <- length(output) + 1
        output[[l]] <- plot
        names(output)[[l]] <- paste("LengthIndicators_D", SP, MS, GSA, sep = " _ ")

      } else {
        print("No discards data available for this stock")
        output <- NULL
      }
    }
  }

  return(output)
}
