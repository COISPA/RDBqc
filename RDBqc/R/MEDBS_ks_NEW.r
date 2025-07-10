#' Kolmogorov–Smirnov test on length frequencies
#'
#' @param data    Data frame (or data.table) containing either landings or discards.
#' @param type    Character: `"l"` for landings, `"d"` for discards.
#' @param SP      Species code.
#' @param MS      Member-state code.
#' @param GSA     Geographical Sub-Area code.
#' @param Rt      Numeric ratio applied to subsample data to reduce the risk of rejecting the H0 hypothesis.
#' @param verbose Logical; if `TRUE`, progress messages are printed.
#'
#' @description
#' Computes the two-sample Kolmogorov–Smirnov statistic on length–frequency data
#' for each pair of years within every gear/fishery, and produces cumulative
#' length-distribution plots by fishery and year.
#' The statistic is calculated analytically from vectorised cumulative curves;
#' results are returned as a table with one row per year pair together with
#' descriptive statistics and the corresponding plots.
#'
#' @return A list with four elements:
#' \describe{
#'   \item{final_DB}{Descriptive statistics by year × gear × fishery.}
#'   \item{KS_final}{Table of KS results for all year pairs.}
#'   \item{KS_not_run}{Data sets skipped because only one year was available.}
#'   \item{plots}{Grid of cumulative-distribution plots (ggplot grobs).}
#' }
#'
#' @author Alessandro Mannini <alessandro.mannini@@ec.europa.eu>
#' @author Walter Zupa <zupa@@coispa.it>
#'
#' @examples
#' MEDBS_ks(data = Landing_tab_example,
#'          type = "l", SP = "DPS", MS = "ITA", GSA = "GSA 9", Rt = 1)
#'
#' @import tidyverse
#' @importFrom dplyr full_join group_by inner_join left_join summarize mutate filter
#' @importFrom magrittr %>%
#' @importFrom utils  globalVariables
#' @importFrom tidyr pivot_longer
#' @importFrom data.table as.data.table
#' @importFrom gridExtra grid.arrange
#' @importFrom methods is
#' @export MEDBS_ks


MEDBS_ks <- function(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE) {



    if (FALSE) {
        setwd("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/RDB3/test RDBqc")
        data <- read.csv2("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/RDB2/Second Training RDBFIS II/Data/1_MEDBS with and without errors/punto e virgola/Lnd_GSA_18.csv")

        type="l"
        SP="HKE"
        MS="ITA"
        GSA="GSA 18"
        Rt = 1
        verbose = TRUE

        library(data.table)
        library(dplyr)

        library(profvis)

        profvis({
            res <- MEDBS_ks(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE)
            Rprof(NULL)   })


        Rprof("prof.out", interval = 0.01)
        MEDBS_ks(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE)
        Rprof(NULL)
        pr <- summaryRprof("prof.out")$by.self
        head(pr[order(-pr$self.time), ], 10)


        #-----------

        data <- read.csv2("D:/OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L/RDB2/Second Training RDBFIS II/Data/1_MEDBS with and without errors/punto e virgola/Disc_GSA_18.csv")

        type="d"
        SP="HKE"
        MS="ITA"
        GSA="GSA 18"
        Rt = 1
        verbose = TRUE

        library(data.table)
        library(dplyr)

        library(profvis)

        profvis({
            res <- MEDBS_ks(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE)
            Rprof(NULL)   })


        Rprof("prof.out", interval = 0.01)
        MEDBS_ks(data, type, SP, MS, GSA, Rt = 1, verbose = TRUE)
        Rprof(NULL)
        pr <- summaryRprof("prof.out")$by.self
        head(pr[order(-pr$self.time), ], 10)

    }



    . <- ID <- country <- area <- species <- year <- gear <- mesh_size_range <- fishery <- NULL
    len <- variable <- dbland <- NULL
    value <- start_length <- fsquare <- total_number <- mean_size <- percentile_value <- NULL


    calc_KS_ID <- function(dt) {
        # dt: sotto-tabella di un singolo ID con colonne
        #     year, start_length, value

        years   <- sort(unique(dt$year))
        combos  <- t(combn(years, 2))           # tutte le coppie di anni
        out_lst <- vector("list", nrow(combos))

        for (r in seq_len(nrow(combos))) {
            y1 <- combos[r, 1];  y2 <- combos[r, 2]

            # frequenze per lunghezza nei due anni
            f1 <- dt[year == y1, .(freq = sum(value)), by = start_length]
            f2 <- dt[year == y2, .(freq = sum(value)), by = start_length]

            # allinea le classi di lunghezza
            all_len <- sort(unique(c(f1$start_length, f2$start_length)))
            f1 <- merge(data.table(start_length = all_len), f1, all.x = TRUE)[
                , freq := fifelse(is.na(freq), 0, freq)]
            f2 <- merge(data.table(start_length = all_len), f2, all.x = TRUE)[
                , freq := fifelse(is.na(freq), 0, freq)]

            # curve cumulate
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

    #-----------------------------
    library(data.table)          # in cima alla funzione c’è già data.table? se no, aggiungilo una sola volta

    setDT(data)                  # converte in-place
    len_cols <- grep("^lengthclass", names(data), value = TRUE)

    data[, (len_cols) := lapply(.SD, function(x) {
        y <- suppressWarnings(as.numeric(x))
        y[is.na(y)] <- 0
        y
    }), .SDcols = len_cols]
    #-----------------------------

    # ---------------------------------------------------------------------
    #  ── LANDING BRANCH ──────────────────────────────────────────────────
    # ---------------------------------------------------------------------

    if (type == "l") {
        landed <- data
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

            ###### LANDINGS #######
            cols <- c(which(colnames(land) %in% c("year", "area", "species", "unit", "gear", "fishery", "country")), grep("lengthclass", colnames(land)))
            dat <- land[, cols, with = FALSE]
            lccols <- grep("lengthclass", colnames(dat))
            colnames(dat)[lccols] <- gsub("[^0-9]", "", colnames(dat)[lccols])
            ldat <- suppressWarnings(data.table::melt(dat, id.vars = c("year", "area", "species", "unit", "country", "gear", "fishery"), variable.name = "start_length", value.name = "value"))
            ldat$start_length <- as.integer(ldat$start_length)
            ldat[(ldat$value < 0) | is.na(ldat$value), "value"] <- 0

            LFL <- ldat %>%
                group_by(year, gear, fishery, start_length) %>%
                summarise(value = sum(value, na.rm = TRUE))

            LFL$ID <- paste0(LFL$gear, "_", LFL$fishery, sep = "")
            LFL$start_length <- LFL$start_length - 1

            # --- PATCH 2: cumulata veloce -----------------------
            setDT(LFL)  # se non lo era già
            db <- LFL[order(year, gear, fishery, start_length),
                      .(start_length,
                        value,
                        cumFreq = cumsum(value)),
                      by = .(year, gear, fishery)][
                          , relative := cumFreq / max(cumFreq),
                          by = .(year, gear, fishery)]
            #-----------------------------------------------------

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
            tmpdb <- list()
            tmpdb1 <- list()
            counter <- 1
            counter1 <- 1
            counter2 <- 1
            i <- "OTB_DEF"
            plots <- list()

            axel <- LFLandingssub %>% group_by(year,ID) %>% summarize(count_v=sum(value > 0))
            toremove_cumulativeL <- axel[axel$count_v<3,]
            LFLandingssub_tmp <- full_join(LFLandingssub,toremove_cumulativeL)
            LFLandingssub <- LFLandingssub_tmp[LFLandingssub_tmp$count_v%in%NA,]

            for (i in unique(LFLandingssub$ID)) {
                LFLandingsred <- LFLandingssub[LFLandingssub$ID %in% i, ]
                LFLandingsred$value <- LFLandingsred$value / Rt
                check_num_data <- LFLandingsred[LFLandingsred$value > 0, ]
                check_num_data <- suppressMessages(check_num_data %>% group_by(year, ID) %>% summarise(n = length(value)))

                if (length(unique(LFLandingsred$year)) == 1) {
                    tmpdb1[[counter1]] <- LFLandingsred
                    counter1 <- counter1 + 1

                } else {

                    ## 1. grafico cumulativo (sempre mostrato) ----------------------------
                    cumu <- LFLandingsred[
                        order(start_length),
                        .(start_length,
                          cumFreq = cumsum(value)),    # cumsum continua
                        by = year                      # ← solo per anno!
                    ][,
                      relative := if (max(cumFreq) == 0)
                          0 else cumFreq / max(cumFreq),
                      by = year                      # normalizza per anno
                    ]

                    plot <- ggplot(cumu,
                                   aes(start_length, relative, col = factor(year))) +
                        geom_line() +
                        labs(title = paste(i, SP, MS, GSA, "Landing"),
                             x = "Length", y = "Cumulative proportion",
                             col = "year") +
                        theme_bw()
                    plots[[i]] <- plot

                    ## 2. calcolo KS senza bootstrap -------------------------------------
                    ks_tbl <- try(calc_KS_ID(LFLandingsred), silent = TRUE)

                    if (!inherits(ks_tbl, "try-error")) {
                        ks_tbl[, ID := i]
                        tmpdb[[counter]] <- ks_tbl
                        counter <- counter + 1
                    } else {
                        tmpdb1[[counter1]] <- LFLandingsred   # stesso fallback
                        counter1 <- counter1 + 1
                    }
                }
            }

            n <- length(plots)
            nsq <- round(sqrt(n), 0)
            nCol <- floor(sqrt(n))
            cols <- max(nsq, nCol)
            if (length(plots) > 0) {
                plots <- do.call(grid.arrange, c(plots, ncol = cols))
                KS_final_landings <- do.call(rbind, tmpdb)
                KS_noTest_landings <- do.call(rbind, tmpdb1)
            } else {
                plots <- NULL
                KS_final_landings <- NULL
                KS_noTest_landings <- do.call(rbind, tmpdb1)
            }
            results <- list(final_DB, KS_final_landings, KS_noTest_landings, plots)
            return(results)
        } # nrow(land) > 0
    }

    ############################################################



    # ---------------------------------------------------------------------
    #  ── DISCARD BRANCH ───────────────────────────────────────────────────
    # ---------------------------------------------------------------------
    if (type == "d") {

        discarded           <- copy(data)
        discarded$upload_id <- NA
        id_discards         <- NA
        discarded           <- cbind(id_discards, discarded)
        discarded$discards[discarded$discards == -1] <- 0

        disc <- discarded[country == MS & area == GSA & species == SP]

        if (nrow(disc) == 0) {
            if (verbose)
                message("No discard data available for the selected species (", SP, ")")
            return(NULL)
        }

        ## --- melt length–class columns ----------------------------------
        lc_cols   <- grep("^lengthclass", names(disc), value = TRUE)
        setnames(disc, lc_cols, sub("[^0-9]", "", lc_cols))            # keep digits only
        dlong <- melt(disc,
                      id.vars      = c("year","area","species","unit",
                                       "country","gear","fishery"),
                      variable.name = "start_length",
                      value.name    = "value")
        dlong[, start_length := as.integer(start_length)]
        dlong[(value < 0) | is.na(value), value := 0]

        ## length-frequency table -----------------------------------------
        LFD <- dlong[, .(value = sum(value)),             # sum over hauls
                     by = .(year, gear, fishery, start_length)]
        LFD[, `:=`(ID = paste0(gear, "_", fishery),
                   start_length = start_length - 1L)]

        ## descriptive stats (re-used later) ------------------------------
        descr <- LFD[, {
            tot <- sum(value)
            ms  <- if (tot) sum(start_length * value) / tot else NA_real_
            sdv <- if (tot > 1) sqrt(sum(((start_length - ms)^2) * value) / (tot - 1)) else NA_real_
            list(total_number = tot,
                 min_size     = if (tot) min(start_length[value > 0]) else NA_integer_,
                 mean_size    = ms,
                 max_size     = if (tot) max(start_length[value > 0]) else NA_integer_,
                 sd_size      = sdv)
        }, by = .(year, gear, fishery)]

        ## filter away ID/year combos with zero total ---------------------
        valid_ID <- LFD[, .(tot = sum(value)), by = .(year, ID)][tot > 0, unique(ID)]
        LFD      <- LFD[ID %in% valid_ID]

        ## container objects ---------------------------------------------
        KS_list        <- list()
        skipped_list   <- list()
        plot_list      <- list()
        k <- s <- 1

        for (cur_id in unique(LFD$ID)) {

            dt <- LFD[ID == cur_id]
            dt[, value := value / Rt]

            if (dt[, uniqueN(year)] == 1L) {
                skipped_list[[s]] <- dt
                s <- s + 1
            }

            ## cumulative plot (always) -----------------------------------
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

            ## KS only when ≥2 years --------------------------------------
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

        ## assemble outputs ----------------------------------------------
        KS_final  <- if (length(KS_list))      rbindlist(KS_list)      else NULL
        KS_skipped<- if (length(skipped_list)) rbindlist(skipped_list) else NULL

        pg <- if (length(plot_list)) {
            gridExtra::grid.arrange(grobs = plot_list, ncol = ceiling(sqrt(length(plot_list))))
        } else NULL

        return(list(final_DB       = as.data.frame(descr),
                    KS_final       = KS_final,
                    KS_not_run     = KS_skipped,
                    plots          = pg))
    }

}
