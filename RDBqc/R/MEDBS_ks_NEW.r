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
#' @importFrom methods is
#' @importFrom data.table setDT data.table rbindlist setnames copy melt
#' @importFrom utils combn read.table
#' @importFrom data.table uniqueN fifelse
#' @importFrom data.table :=
#' @importFrom utils globalVariables
#' @export MEDBS_ks
MEDBS_ks <- function(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE) {

    . <- ID <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
    len <- variable <- dbland <- NULL
    value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- NULL

    calc_KS_ID <- function(dt) {
        years   <- sort(unique(dt$year))
        combos  <- t(combn(years, 2))
        out_lst <- vector("list", nrow(combos))

        for (r in seq_len(nrow(combos))) {
            y1 <- combos[r, 1];  y2 <- combos[r, 2]

            f1 <- dt[year == y1, .(freq = sum(value)), by = start_length]
            f2 <- dt[year == y2, .(freq = sum(value)), by = start_length]

            # CONVERSIONI
            if (!is.numeric(f1$freq)) f1[, freq := as.numeric(freq)]
            if (!is.numeric(f2$freq)) f2[, freq := as.numeric(freq)]

            all_len <- sort(unique(c(f1$start_length, f2$start_length)))
            f1 <- merge(data.table(start_length = all_len), f1, all.x = TRUE)[
                , freq := fifelse(is.na(freq), 0, freq)]
            f2 <- merge(data.table(start_length = all_len), f2, all.x = TRUE)[
                , freq := fifelse(is.na(freq), 0, freq)]

            c1 <- cumsum(f1$freq) / sum(f1$freq)
            c2 <- cumsum(f2$freq) / sum(f2$freq)

            Dmax  <- max(abs(c1 - c2))
            N1    <- sum(f1$freq);  N2 <- sum(f2$freq)
            Dcalc <- 1.73 * sqrt((N1 + N2) / (N1 * N2))
            H0    <- if (Dmax >= Dcalc) "rejected" else "accepted"

            out_lst[[r]] <- data.table(
                Group     = paste(y1, "vs", y2),
                NTot_yr1  = N1,
                NTot_yr2  = N2,
                Dmax      = Dmax,
                Dcalc     = Dcalc,
                H0_p0.05  = H0,
                Comment   = ifelse(H0 == "rejected",
                                   "not belong to same population",
                                   "belong to same population"))
        }
        rbindlist(out_lst)
    }

    colnames(data) <- tolower(colnames(data))
    data <- as.data.table(data)

    setDT(data)
    len_cols <- grep("^lengthclass", names(data), value = TRUE)
    data[, (len_cols) := lapply(.SD, function(x) {
        y <- suppressWarnings(as.numeric(x))
        y[is.na(y)] <- 0
        y
    }), .SDcols = len_cols]

    if (type == "l") {
        landed <- data
        landed$upload_id <- NA
        id_landings <- NA
        landed <- cbind(id_landings, landed)
        landed$landings[landed$landings == -1] <- 0

        land <- landed[which(landed$area == GSA & landed$country == MS & landed$species == SP), ]

        if (nrow(land) == 0) {
            if (verbose) {
                message(paste0("No landing data available for the selected species (", SP, ")"))
            }
            return(NULL)
        } else {
            var_no_landed <- grep("lengthclass", names(land), value = TRUE)
            land <- as.data.table(land)
            max_no_landed <- land[, lapply(.SD, max), by = .(country, area, species, year, gear, mesh_size_range, fishery), .SDcols = var_no_landed]
            max_no_landed[max_no_landed == -1] <- 0
            max_no_landed2 <- max_no_landed[, -(1:7)]

            p <- as.data.frame(colSums(max_no_landed2, na.rm = TRUE))
            p$Length <- c(0:100)
            names(p) <- c("Sum", "Length")
            maxlength <- max(p[which(p$Sum > 0), "Length"])
            unit <- unique(land$unit)

            cols <- c(which(colnames(land) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(land)))
            dat <- land[, cols, with = FALSE]
            lccols <- grep("lengthclass", colnames(dat))
            colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])
            ldat <- suppressWarnings(data.table::melt(dat, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))

            # CONVERSIONI
            if (!is.integer(ldat$start_length)) ldat[, start_length := as.integer(start_length)]
            if (!is.numeric(ldat$value)) ldat[, value := as.numeric(value)]
            if (!is.integer(ldat$year)) ldat[, year := as.integer(year)]

            ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

            LFL <- ldat %>%
                group_by(year, gear, fishery, start_length) %>%
                summarise(value = sum(value, na.rm = TRUE))

            LFL$ID <- paste0(LFL$gear, "_", LFL$fishery, sep = "")
            LFL$start_length <- LFL$start_length - 1

            setDT(LFL)
            db <- LFL[order(year, gear, fishery, start_length),
                      .(start_length,
                        value,
                        cumFreq = cumsum(value)),
                      by = .(year, gear, fishery)][,
                                                   relative := cumFreq / max(cumFreq),
                                                   by = .(year, gear, fishery)]

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

            LFLandings <- LFL
            LFLandings$ID1 <- paste0(LFLandings$year, LFLandings$gear, LFLandings$fishery)
            LFLandings_tot <- LFLandings %>%
                group_by(year, gear, fishery) %>%
                summarize(tot = sum(value))
            LFLandings_tot$ID1 <- paste0(LFLandings_tot$year, LFLandings_tot$gear, LFLandings_tot$fishery)
            toremove <- LFLandings_tot[LFLandings_tot$tot %in% 0, ]
            LFLandingssub <- LFLandings[!LFLandings$ID1 %in% toremove$ID1, ]

            plots <- list()

            axel <- LFLandingssub %>% group_by(year,ID) %>% summarize(count_v=sum(value > 0))
            toremove_cumulativeL <- axel[axel$count_v<3,]
            LFLandingssub_tmp <- full_join(LFLandingssub,toremove_cumulativeL)
            LFLandingssub <- LFLandingssub_tmp[LFLandingssub_tmp$count_v %in% NA,]

            tmpdb <- list()
            tmpdb1 <- list()
            counter <- 1
            counter1 <- 1

            for (i in unique(LFLandingssub$ID)) {
                LFLandingsred <- LFLandingssub[LFLandingssub$ID %in% i, ]
                LFLandingsred$value <- LFLandingsred$value / Rt

                check_num_data <- LFLandingsred[LFLandingsred$value > 0, ]
                check_num_data <- suppressMessages(check_num_data %>% group_by(year, ID) %>% summarise(n = length(value)))

                if (length(unique(LFLandingsred$year)) == 1) {
                    tmpdb1[[counter1]] <- LFLandingsred
                    counter1 <- counter1 + 1
                } else {
                    cumu <- LFLandingsred[
                        order(start_length),
                        .(start_length,
                          cumFreq = cumsum(value)),
                        by = year][,
                                   relative := if (max(cumFreq) == 0) 0 else cumFreq / max(cumFreq),
                                   by = year]

                    p <- ggplot(cumu,
                                aes(start_length, relative, col = factor(year))) +
                        geom_line() +
                        labs(title = paste(i, SP, MS, GSA, "Landing"),
                             x = "Length", y = "Cumulative proportion",
                             col = "year") +
                        theme_bw()
                    plots[[i]] <- p

                    ks_tbl <- try(calc_KS_ID(LFLandingsred), silent = TRUE)
                    if (!inherits(ks_tbl, "try-error")) {
                        ks_tbl[, ID := i]
                        tmpdb[[counter]] <- ks_tbl
                        counter <- counter + 1
                    } else {
                        tmpdb1[[counter1]] <- LFLandingsred
                        counter1 <- counter1 + 1
                    }
                }
            }

            # n <- length(plots)
            # nsq <- round(sqrt(n), 0)
            # nCol <- floor(sqrt(n))
            # cols <- max(nsq, nCol)

            if (length(plots) > 0) {
                # plots <- do.call(grid.arrange, c(plots, ncol = cols))
                plots <- grid.arrange(
                    grobs = plots,
                    ncol = ceiling(sqrt(length(plots)))
                )
                KS_final_landings <- do.call(rbind, tmpdb)
                KS_noTest_landings <- do.call(rbind, tmpdb1)
            } else {
                plots <- NULL
                KS_final_landings <- NULL
                KS_noTest_landings <- do.call(rbind, tmpdb1)
            }
            results <- list(final_DB, KS_final_landings, KS_noTest_landings, plots)
            return(results)
        }
    }

    if (type == "d") {

        discarded <- copy(data)
        discarded$upload_id <- NA
        id_discards <- NA
        discarded <- cbind(id_discards, discarded)
        discarded$discards[discarded$discards == -1] <- 0

        disc <- discarded[country == MS & area == GSA & species == SP]

        if (nrow(disc) == 0) {
            if (verbose)
                message("No discard data available for the selected species (", SP, ")")
            return(NULL)
        }

        lc_cols <- grep("^lengthclass", names(disc), value = TRUE)
        setnames(disc, lc_cols, sub("[^0-9]", "", lc_cols))
        dlong <- melt(disc,
                      id.vars = c("year","area","species","unit","country","gear","fishery"),
                      variable.name = "start_length",
                      value.name = "value")

        # CONVERSIONI
        if (!is.integer(dlong$start_length)) dlong[, start_length := as.integer(start_length)]
        if (!is.numeric(dlong$value)) dlong[, value := as.numeric(value)]
        if (!is.integer(dlong$year)) dlong[, year := as.integer(year)]

        dlong[(value < 0) | is.na(value), value := 0]

        LFD <- dlong[, .(value = sum(value)),
                     by = .(year, gear, fishery, start_length)]
        LFD[, `:=`(ID = paste0(gear, "_", fishery),
                   start_length = start_length - 1L)]

        descr <- LFD[, {
            tot <- sum(value)
            ms <- if (tot) sum(start_length * value) / tot else NA_real_
            sdv <- if (tot > 1) sqrt(sum(((start_length - ms)^2) * value) / (tot - 1)) else NA_real_
            list(total_number = tot,
                 min_size = if (tot) min(start_length[value > 0]) else NA_integer_,
                 mean_size = ms,
                 max_size = if (tot) max(start_length[value > 0]) else NA_integer_,
                 sd_size = sdv)
        }, by = .(year, gear, fishery)]

        valid_ID <- LFD[, .(tot = sum(value)), by = .(year, ID)][tot > 0, unique(ID)]
        LFD <- LFD[ID %in% valid_ID]

        KS_list <- list()
        skipped_list <- list()
        plot_list <- list()
        k <- s <- 1

        for (cur_id in unique(LFD$ID)) {

            dt <- LFD[ID == cur_id]
            dt[, value := value / Rt]

            if (dt[, uniqueN(year)] == 1L) {
                skipped_list[[s]] <- dt
                s <- s + 1
            }

            cumu <- dt[order(start_length),
                       .(start_length,
                         cumFreq = cumsum(value)),
                       by = .(year)]
            cumu[, relative := if (max(cumFreq) == 0) 0 else cumFreq/max(cumFreq),
                 by = year]

            p <- ggplot(cumu,
                        aes(start_length, relative, colour = factor(year))) +
                geom_line() +
                labs(title = paste(cur_id, SP, MS, GSA, "Discard"),
                     x = "Length", y = "Cumulative proportion",
                     colour = "year") +
                theme_bw()
            plot_list[[cur_id]] <- p

            if (dt[, uniqueN(year)] > 1L) {
                ks_tab <- try(calc_KS_ID(dt), silent = TRUE)
                if (!inherits(ks_tab, "try-error")) {
                    ks_tab[, ID := cur_id]
                    KS_list[[k]] <- ks_tab
                    k <- k + 1
                } else {
                    skipped_list[[s]] <- dt
                    s <- s + 1
                }
            }
        }

        KS_final <- if (length(KS_list)) rbindlist(KS_list) else NULL
        KS_skipped <- if (length(skipped_list)) rbindlist(skipped_list) else NULL

        pg <- if (length(plot_list)) {
            grid.arrange(grobs = plot_list, ncol = ceiling(sqrt(length(plot_list))))
        } else NULL

        return(list(final_DB = as.data.frame(descr),
                    KS_final = KS_final,
                    KS_not_run = KS_skipped,
                    plots = pg))
    }
}

utils::globalVariables(c(
    "freq", "cumFreq", "relative", "ID", "start_length", "value"
))
