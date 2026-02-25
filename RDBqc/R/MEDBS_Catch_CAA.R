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


# MEDBS_Catch_CAA <- function(data, SP, MS, GSA, verbose = TRUE) {
#
#     # avoid "no visible binding for global variable" notes
#     AGE_COL <- YEAR <- QUARTER <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- AGE <- NUMBER <- TYPE <- GROUP <- NULL
#
#     colnames(data) <- toupper(colnames(data))
#
#     # Replace missing meta fields (character columns) early
#     data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
#     data[is.na(data$GEAR), "GEAR"] <- "NA"
#     data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
#     data[is.na(data$FISHERY), "FISHERY"] <- "NA"
#
#     # Filter immediately to reduce data size as soon as possible
#     data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, , drop = FALSE]
#
#     if (nrow(data) == 0) {
#         if (isTRUE(verbose)) message(paste0("No data available for the selected species (", SP, ")"))
#         return(NULL)
#     }
#
#     # Replace -1 with 0 for main totals (kept as in your code)
#     data[data$LANDINGS == -1, "LANDINGS"] <- 0
#     data[data$DISCARDS == -1, "DISCARDS"] <- 0
#
#     # Define age columns once (only those really needed)
#     age_pattern <- "^AGE_\\d+_NO_LANDED$|^AGE_20_PLUS_NO_LANDED$|^AGE_20_NO_LANDED$|^AGE_\\d+_NO_DISCARD$|^AGE_20_PLUS_NO_DISCARD$|^AGE_20_NO_DISCARD$"
#     age_cols <- grep(age_pattern, names(data), value = TRUE)
#
#     if (length(age_cols) == 0) {
#         if (isTRUE(verbose)) message(paste0("No AGE_* numbers-at-age columns found for ", SP, " in ", MS, " - ", GSA))
#         return(NULL)
#     }
#
#     # Convert only AGE_* columns to numeric in a vectorised way, and clean NA/-1
#     # This replaces the slow for-loop over 25:ncol(Data_call)
#     suppressWarnings({
#         data <- dplyr::mutate(
#             data,
#             dplyr::across(
#                 dplyr::all_of(age_cols),
#                 ~ {
#                     v <- as.numeric(.x)
#                     v[is.na(v)] <- 0
#                     v[v == -1] <- 0
#                     v
#                 }
#             )
#         )
#     })
#
#     # Precompute GROUP in wide format (cheap), avoid paste() on the long table
#     data <- dplyr::mutate(
#         data,
#         GROUP = paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")
#     )
#
#     # Keep only the columns needed for pivoting and aggregation (reduces RAM)
#     data_min <- dplyr::select(data, YEAR, QUARTER, GROUP, dplyr::all_of(age_cols))
#
#     # Age factor levels
#     age_levels <- c(as.character(0:19), "20+")
#
#     # Pivot long on the reduced table
#     lw_counts <- tidyr::pivot_longer(
#         data_min,
#         cols = dplyr::all_of(age_cols),
#         names_to  = "AGE_COL",
#         values_to = "NUMBER"
#     ) %>%
#         dplyr::mutate(
#             TYPE = ifelse(grepl("_NO_LANDED$", AGE_COL), "Landing", "Discard"),
#             AGE  = ifelse(
#                 grepl("20_PLUS", AGE_COL) | grepl("^AGE_20_", AGE_COL),
#                 "20+",
#                 stringr::str_extract(AGE_COL, "\\d+")
#             ),
#             AGE = factor(AGE, levels = age_levels)
#         ) %>%
#         dplyr::group_by(GROUP, YEAR, AGE, TYPE) %>%
#         dplyr::summarise(NUMBER = sum(NUMBER, na.rm = TRUE), .groups = "drop") %>%
#         dplyr::filter(NUMBER > 0)
#
#     if (nrow(lw_counts) == 0) {
#         if (isTRUE(verbose)) {
#             message(paste0("No numbers-at-age > 0 after cleaning for ", SP, " in ", MS, " - ", GSA))
#         }
#         return(NULL)
#     }
#
#     # Add one dummy observation for each missing GROUP x YEAR panel (lightweight)
#     obs_panels <- dplyr::distinct(lw_counts, GROUP, YEAR)
#
#     grid_panels <- expand.grid(
#         GROUP = unique(lw_counts$GROUP),
#         YEAR  = unique(lw_counts$YEAR),
#         stringsAsFactors = FALSE
#     )
#
#     missing_panels <- dplyr::anti_join(grid_panels, obs_panels, by = c("GROUP", "YEAR"))
#
#     if (nrow(missing_panels) > 0) {
#         dummy <- dplyr::mutate(
#             missing_panels,
#             AGE    = factor(age_levels[1], levels = age_levels),
#             TYPE   = "Landing",
#             NUMBER = 0
#         )
#         lw_counts <- dplyr::bind_rows(lw_counts, dummy)
#     }
#
#     # Plot
#     p <- ggplot2::ggplot(lw_counts, ggplot2::aes(x = AGE, y = NUMBER, fill = TYPE)) +
#         ggplot2::geom_col(position = ggplot2::position_dodge(width = 0.8)) +
#         ggplot2::scale_fill_manual(values = c(Landing = "#2C7FB8", Discard = "#F781BF")) +
#         ggplot2::facet_grid(GROUP ~ YEAR, scales = "free_y") +
#         ggplot2::labs(
#             x = "Age class",
#             y = "Number of individuals (thousands)",
#             fill = NULL,
#             title = paste0("Numbers by age (quarters summed) - ", SP, " in ", MS, " - ", GSA)
#         ) +
#         ggplot2::theme(
#             legend.position = "top",
#             strip.text.y = ggplot2::element_text(angle = 0)
#         )
#
#     return(p)
# }



MEDBS_Catch_CAA <- function(data, SP, MS, GSA, verbose = TRUE) {

    AGE_COL <- YEAR <- QUARTER <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- AGE <- NUMBER <- TYPE <- GROUP <- NULL

    if (!requireNamespace("data.table", quietly = TRUE)) stop("Package 'data.table' is required.")
    if (!requireNamespace("stringr", quietly = TRUE)) stop("Package 'stringr' is required.")
    if (!requireNamespace("lattice", quietly = TRUE)) stop("Package 'lattice' is required.")

    colnames(data) <- toupper(colnames(data))

    data[is.na(data$VESSEL_LENGTH), "VESSEL_LENGTH"] <- "NA"
    data[is.na(data$GEAR), "GEAR"] <- "NA"
    data[is.na(data$MESH_SIZE_RANGE), "MESH_SIZE_RANGE"] <- "NA"
    data[is.na(data$FISHERY), "FISHERY"] <- "NA"

    data <- data[data$AREA == as.character(GSA) & data$COUNTRY == MS & data$SPECIES == SP, , drop = FALSE]
    if (nrow(data) == 0) {
        if (isTRUE(verbose)) message(paste0("No data available for the selected species (", SP, ")"))
        return(NULL)
    }

    data[data$LANDINGS == -1, "LANDINGS"] <- 0
    data[data$DISCARDS == -1, "DISCARDS"] <- 0

    age_pattern <- "^AGE_\\d+_NO_LANDED$|^AGE_20_PLUS_NO_LANDED$|^AGE_20_NO_LANDED$|^AGE_\\d+_NO_DISCARD$|^AGE_20_PLUS_NO_DISCARD$|^AGE_20_NO_DISCARD$"
    age_cols <- grep(age_pattern, names(data), value = TRUE)

    if (length(age_cols) == 0) {
        if (isTRUE(verbose)) message(paste0("No numbers-at-age columns found for ", SP, " in ", MS, " - ", GSA))
        return(NULL)
    }

    DT <- data.table::as.data.table(data)
    DT[, GROUP := paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")]

    for (j in age_cols) {
        suppressWarnings(data.table::set(DT, j = j, value = as.numeric(DT[[j]])))
        DT[is.na(DT[[j]]) | DT[[j]] == -1, (j) := 0]
    }

    DT <- DT[, c("YEAR", "QUARTER", "GROUP", age_cols), with = FALSE]

    long <- data.table::melt(
        DT,
        id.vars = c("YEAR", "QUARTER", "GROUP"),
        measure.vars = age_cols,
        variable.name = "AGE_COL",
        value.name = "NUMBER"
    )[NUMBER > 0]

    if (nrow(long) == 0) {
        if (isTRUE(verbose)) message(paste0("No numbers-at-age > 0 after cleaning for ", SP, " in ", MS, " - ", GSA))
        return(NULL)
    }

    long[, TYPE := ifelse(grepl("_NO_LANDED$", AGE_COL), "Landing", "Discard")]
    long[, AGE := ifelse(
        grepl("20_PLUS", AGE_COL) | grepl("^AGE_20_", AGE_COL),
        "20+",
        stringr::str_extract(as.character(AGE_COL), "\\d+")
    )]

    age_levels <- c(as.character(0:19), "20+")
    long[, AGE := factor(AGE, levels = age_levels)]
    long[, TYPE := factor(TYPE, levels = c("Landing", "Discard"))]

    lw_counts <- long[, .(NUMBER = sum(NUMBER, na.rm = TRUE)), by = .(GROUP, YEAR, AGE, TYPE)][NUMBER > 0]
    if (nrow(lw_counts) == 0) return(NULL)

    lw_counts <- as.data.frame(lw_counts)

    years_sorted <- sort(unique(lw_counts$YEAR))
    groups_sorted <- sort(unique(lw_counts$GROUP))

    # Optional: wrap long GROUP labels (helps readability on the Y side)
    wrap_width <- 14
    lw_counts$GROUP <- vapply(
        as.character(lw_counts$GROUP),
        function(z) paste(strwrap(z, width = wrap_width), collapse = "\n"),
        FUN.VALUE = character(1)
    )

    lw_counts$YEAR  <- factor(lw_counts$YEAR, levels = years_sorted)
    lw_counts$GROUP <- factor(lw_counts$GROUP, levels = unique(lw_counts$GROUP[match(groups_sorted, gsub("\n", "", lw_counts$GROUP))], nomatch = 0))

    cols <- c(Landing = "#2C7FB8", Discard = "#F781BF")

    p <- lattice::barchart(
        NUMBER ~ AGE | YEAR * GROUP,
        data = lw_counts,
        groups = TYPE,
        origin = 0,
        horizontal = FALSE,
        stack = FALSE,
        auto.key = list(space = "top", columns = 2, rectangles = TRUE, points = FALSE, cex = 0.9),
        par.settings = list(superpose.polygon = list(col = cols, border = NA)),
        scales = list(
            x = list(cex = 0.75),
            y = list(cex = 0.65, relation = "free")   # <-- FREE Y per panel
        ),
        par.strip.text = list(cex = 0.55),          # <-- smaller strip labels (GROUP on rows)
        between = list(x = 0.15, y = 0.15),
        strip = lattice::strip.custom(bg = "grey90"),
        strip.left = TRUE,                          # <-- put GROUP labels on the left
        xlab = "Age class",
        ylab = "Number of individuals (thousands)",
        main = paste0("Numbers by age (quarters summed) - ", SP, " in ", MS, " - ", GSA)
    )

    if (requireNamespace("latticeExtra", quietly = TRUE)) {
        p <- latticeExtra::useOuterStrips(p, strip = lattice::strip.custom(bg = "grey90"))
    } else {
        p <- lattice::update(p, par.strip.text = list(cex = 0.5))
    }

    return(p)
}
