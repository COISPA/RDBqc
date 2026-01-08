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
#' @importFrom dplyr filter mutate select group_by summarise bind_rows distinct anti_join
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
    AGE_COL <- YEAR <- QUARTER <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- AGE <- NUMBER <- TYPE <- GROUP <- NULL
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

        age_levels <- c(as.character(0:19), "20+")

        # One single pivot: keep only numbers-at-age (landed and discard)
        lw_counts <- Data_call %>%
            pivot_longer(
                cols = matches("^AGE_\\d+_NO_LANDED$|^AGE_20_PLUS_NO_LANDED$|^AGE_20_NO_LANDED$|^AGE_\\d+_NO_DISCARD$|^AGE_20_PLUS_NO_DISCARD$|^AGE_20_NO_DISCARD$"),
                names_to  = "AGE_COL",
                values_to = "NUMBER"
            ) %>%
            mutate(
                TYPE = ifelse(grepl("_NO_LANDED$", AGE_COL), "Landing", "Discard"),
                AGE  = ifelse(grepl("20_PLUS", AGE_COL) | grepl("^AGE_20_", AGE_COL),
                              "20+",
                              stringr::str_extract(AGE_COL, "\\d+")),
                AGE   = factor(AGE, levels = age_levels),
                GROUP = paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")
            ) %>%
            group_by(GROUP, YEAR, AGE, TYPE) %>%
            summarise(NUMBER = sum(NUMBER, na.rm = TRUE), .groups = "drop") %>%
            filter(NUMBER > 0)

        # If, after cleaning, there are no positive numbers-at-age, do not try faceting
        if (nrow(lw_counts) == 0) {
            if (isTRUE(verbose)) {
                message(paste0("No numbers-at-age > 0 after cleaning for ", SP, " in ", MS, " - ", GSA))
            }
            return(NULL)
        }

        # Add one dummy observation for each missing GROUP x YEAR panel to avoid ggplot warnings
        obs_panels <- lw_counts %>%
            distinct(GROUP, YEAR)

        grid_panels <- expand.grid(
            GROUP = unique(lw_counts$GROUP),
            YEAR  = unique(lw_counts$YEAR),
            stringsAsFactors = FALSE
        )

        missing_panels <- anti_join(
            grid_panels,
            obs_panels,
            by = c("GROUP", "YEAR")
        )

        if (nrow(missing_panels) > 0) {
            dummy <- missing_panels %>%
                mutate(
                    AGE    = factor(age_levels[1], levels = age_levels),
                    TYPE   = "Landing",
                    NUMBER = 0
                )
            lw_counts <- bind_rows(lw_counts, dummy)
        }

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
