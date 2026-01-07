#' Check the numbers-at-age in the Catch table
#'
#' @param data Catch table in MED&BS datacall format
#' @param SP species code
#' @param MS member state code
#' @param GSA GSA code (Geographical sub-area)
#' @param verbose boolean. If TRUE messages are returned
#' @return A ggplot object: multi-panel barplots of numbers-at-age (quarters summed),
#' by YEAR (columns) and by group GEAR - MESH_SIZE_RANGE - FISHERY (rows).
#'
#' @importFrom dplyr filter mutate select group_by summarise bind_rows
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_extract
#' @importFrom tidyselect matches
#' @importFrom ggplot2 ggplot aes geom_col scale_fill_manual facet_grid labs theme element_text position_dodge
#'
#' @export
#' @author Isabella Bitetto <bitetto@fondazionecoispa.org>
#' @examples MEDBS_Catch_CAA(data = Catch_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")
MEDBS_Catch_CAA <- function(data, SP, MS, GSA, verbose = TRUE) {

    # avoid "no visible binding for global variable" notes
    AGE_COL <- YEAR <- QUARTER <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- AGE <- NUMBER <- TYPE <- GROUP<-NULL
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

        # Landing_nb <- Data_call[, 1:12]
        # i <- 1
        # for (i in 1:20) {
        #     Landing_nb <- cbind(Landing_nb, Data_call[, which(colnames(Data_call) == paste("AGE_", i - 1, "_NO_LANDED", sep = ""))])
        #     colnames(Landing_nb)[ncol(Landing_nb)] <- paste("AGE_", i - 1, "_NO_LANDED", sep = "")
        # }
        # Landing_nb <- cbind(Landing_nb, Data_call[, (colnames(Data_call) == "AGE_20_PLUS_NO_LANDED" | colnames(Data_call) == "AGE_20_NO_LANDED")])
        #
        # colnames(Landing_nb) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_NO_LANDED", sep = ""), "AGE_20_PLUS_NO_LANDED")
        #
        # Landing_nb[, 13:ncol(Landing_nb)][Landing_nb[, 13:ncol(Landing_nb)] == -1] <- 0
        # Landing_nb$Sum <- rowSums(Landing_nb[, 13:ncol(Landing_nb)])
        # pos_indices <- which(Landing_nb$Sum > 0)
        Landing_nb <- Data_call[, 1:12]

        for (i in 1:20) {
            Landing_nb <- cbind(Landing_nb, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_NO_LANDED", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_NO_LANDED", sep = "")])
        }
        Landing_nb <- cbind(Landing_nb, Data_call[, colnames(Data_call) == "AGE_20_PLUS_NO_LANDED" | colnames(Data_call) == "AGE_20_NO_LANDED"])
        colnames(Landing_nb) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_NO_LANDED", sep = ""), "AGE_20_PLUS_NO_LANDED")

        Landing_nb[, 13:ncol(Landing_nb)][Landing_nb[, 13:ncol(Landing_nb)] == -1] <- 0


        Discard_nb <- Data_call[, 1:12]

        for (i in 1:20) {
            Discard_nb <- cbind(Discard_nb, Data_call[, colnames(Data_call) == paste("AGE_", i - 1, "_NO_DISCARD", sep = "") | colnames(Data_call) == paste("AGE_", i - 1, "_NO_DISCARD", sep = "")])
        }
        Discard_nb <- cbind(Discard_nb, Data_call[, colnames(Data_call) == "AGE_20_PLUS_NO_DISCARD" | colnames(Data_call) == "AGE_20_NO_DISCARD"])
        colnames(Discard_nb) <- c(colnames(Data_call[1:12]), paste("AGE_", c(0:19), "_NO_DISCARD", sep = ""), "AGE_20_PLUS_NO_DISCARD")

        Discard_nb[, 13:ncol(Discard_nb)][Discard_nb[, 13:ncol(Discard_nb)] == -1] <- 0



        age_levels <- c(as.character(0:19), "20+")

        # Landing: AGE_*_NO_LANDED -> long
        landing_long <- Landing_nb %>%
            pivot_longer(
                cols = matches("^AGE_\\d+_NO_LANDED$|^AGE_20_PLUS_NO_LANDED$"),
                names_to  = "AGE_COL",
                values_to = "NUMBER"
            ) %>%
            mutate(
                TYPE = "Landing",
                AGE  = ifelse(grepl("20_PLUS", AGE_COL),
                              "20+",
                              stringr::str_extract(AGE_COL, "\\d+"))
            ) %>%
            select(YEAR, QUARTER, GEAR, MESH_SIZE_RANGE, FISHERY, AGE, NUMBER, TYPE)

        # Discard: AGE_*_NO_DISCARD -> long
        discard_long <- Discard_nb %>%
            pivot_longer(
                cols = matches("^AGE_\\d+_NO_DISCARD$|^AGE_20_PLUS_NO_DISCARD$"),
                names_to  = "AGE_COL",
                values_to = "NUMBER"
            ) %>%
            mutate(
                TYPE = "Discard",
                AGE  = ifelse(grepl("20_PLUS", AGE_COL),
                              "20+",
                              stringr::str_extract(AGE_COL, "\\d+"))
            ) %>%
            select(YEAR, QUARTER, GEAR, MESH_SIZE_RANGE, FISHERY, AGE, NUMBER, TYPE)

        # Combine, sum over QUARTER, keep YEAR separate (columns in the facet)
        # lw_counts <- bind_rows(landing_long, discard_long) %>%
        #     mutate(
        #         AGE   = factor(AGE, levels = age_levels),
        #         GROUP = paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")
        #     ) %>%
        #     group_by(GROUP, YEAR, AGE, TYPE) %>%       # <- sums over QUARTER implicitly
        #     summarise(NUMBER = sum(NUMBER, na.rm = TRUE), .groups = "drop")
        #
        lw_counts <- bind_rows(landing_long, discard_long) %>%
            mutate(
                AGE   = factor(AGE, levels = c(as.character(0:19), "20+")),
                GROUP = paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")
            ) %>%
            group_by(GROUP, YEAR, AGE, TYPE) %>%
            summarise(NUMBER = sum(NUMBER, na.rm = TRUE), .groups = "drop") %>%
            filter(NUMBER > 0)

        # ---- Plot: one row per GROUP, columns = YEAR; blue=Landing, pink=Discard ----
        p <- ggplot(lw_counts, aes(x = AGE, y = NUMBER, fill = TYPE)) +
            geom_col(position = position_dodge(width = 0.8)) +
            scale_fill_manual(values = c(Landing = "#2C7FB8", Discard = "#F781BF")) +
            facet_grid(GROUP ~ YEAR, scales = "free_y") +
            labs(
                x = "Age class",
                y = "Number of individuals (thousands)",
                fill = NULL,
                title = paste0("Numbers by age (quarters summed) - ", SP, " in ", MS, " - ", GSA)
               ) +
            theme(
                legend.position = "top",
                strip.text.y = element_text(angle = 0)
            )

        return(p)

    }
}
