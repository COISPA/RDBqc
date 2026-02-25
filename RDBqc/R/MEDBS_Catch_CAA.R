#' Numbers-at-age plot from Catch table (Landings vs Discards)
#'
#' @description
#' Builds a multi-panel numbers-at-age plot from the MED&BS Catch table.
#' Age-specific counts are extracted from AGE_* columns (landed and discard),
#' quarters are summed, and results are displayed as grouped barplots
#' (Landing vs Discard) by \strong{YEAR} (columns) and \strong{GEAR-MESH-FISHERY group}
#' (rows). Strip labels are displayed only on the outer margins using \pkg{HH}.
#'
#' @param data A data.frame in MED&BS Catch datacall format.
#' @param SP Species code (character).
#' @param MS Member State code (character).
#' @param GSA GSA code (character), e.g. "GSA 20".
#' @param verbose Logical; if TRUE prints informative messages.
#'
#' @return A \code{trellis} object (lattice) or \code{NULL} if no data are available
#' after filtering/cleaning.
#'
#' @details
#' The function:
#' \enumerate{
#'   \item filters by AREA/COUNTRY/SPECIES;
#'   \item cleans AGE_* columns (NA and -1 set to 0);
#'   \item reshapes to long format and aggregates (quarters summed);
#'   \item plots numbers-at-age as grouped bars (Landing vs Discard);
#'   \item applies outer strips/scales through \code{HH::useOuterScales()}.
#' }
#'
#' @examples
#' \dontrun{
#' p <- MEDBS_Catch_CAA(data = Catch_tab_example, SP = "ANE", MS = "GRC", GSA = "GSA 20")
#' print(p)
#' }
#'
#' @author Walter Zupa
#'
#' @export
#'
#' @importFrom data.table as.data.table set melt
#' @importFrom stringr str_extract
#' @importFrom lattice barchart strip.custom
#' @importFrom HH useOuterScales

MEDBS_Catch_CAA <- function(data, SP, MS, GSA, verbose = TRUE, embedded = TRUE) {

    AGE_COL <- YEAR <- QUARTER <- GEAR <- MESH_SIZE_RANGE <- FISHERY <- AGE <- NUMBER <- TYPE <- GROUP <- NULL

    if (!requireNamespace("data.table", quietly = TRUE)) stop("Package 'data.table' is required.")
    if (!requireNamespace("stringr", quietly = TRUE)) stop("Package 'stringr' is required.")
    if (!requireNamespace("lattice", quietly = TRUE)) stop("Package 'lattice' is required.")
    if (!requireNamespace("latticeExtra", quietly = TRUE)) stop("Package 'latticeExtra' is required.")

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

    # GROUP label (remove spaces around hyphens)
    DT[, GROUP := paste(GEAR, MESH_SIZE_RANGE, FISHERY, sep = " - ")]
    DT[, GROUP := gsub("\\s*-\\s*", "-", GROUP)]     # "GNS - NA - DEF" -> "GNS-NA-DEF"

    # Clean AGE_* columns: numeric + NA/-1 -> 0
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
    if (nrow(lw_counts) == 0) {
        if (isTRUE(verbose)) message(paste0("No numbers-at-age > 0 after aggregation for ", SP, " in ", MS, " - ", GSA))
        return(NULL)
    }

    lw_counts <- as.data.frame(lw_counts)

    years_sorted  <- sort(unique(lw_counts$YEAR))
    groups_sorted <- sort(unique(lw_counts$GROUP))

    # Wrap GROUP labels (critical for readability)
    wrap_width <- 12
    wrap_fun <- function(z) paste(strwrap(z, width = wrap_width), collapse = "\n")
    group_map <- setNames(vapply(groups_sorted, wrap_fun, FUN.VALUE = character(1)), groups_sorted)

    lw_counts$YEAR  <- factor(lw_counts$YEAR, levels = years_sorted)
    lw_counts$GROUP0 <- as.character(lw_counts$GROUP)
    lw_counts$GROUP  <- factor(group_map[lw_counts$GROUP0], levels = unname(group_map))

    # Guard
    if (nrow(lw_counts) == 0 || nlevels(lw_counts$YEAR) == 0 || nlevels(lw_counts$GROUP) == 0) {
        if (isTRUE(verbose)) message(paste0("No panels available for ", SP, " in ", MS, " - ", GSA))
        return(NULL)
    }

    cols <- c(Landing = "#2C7FB8", Discard = "#F781BF")

    n_year  <- nlevels(lw_counts$YEAR)
    n_group <- nlevels(lw_counts$GROUP)



    if (embedded){
    p <- lattice::barchart(
        NUMBER ~ AGE | YEAR * GROUP,
        data = lw_counts,
        groups = TYPE,
        origin = 0,
        box.ratio = 0.85,
        horizontal = FALSE,
        stack = FALSE,
        layout = c(n_year, n_group),
        as.table = TRUE,

        auto.key = list(
            space = "top",
            columns = 2,
            rectangles = TRUE,
            points = FALSE,
            cex = 0.65,
            size = 0.75
        ),

        par.settings = list(
            superpose.polygon = list(col = cols, border = NA),

            # Mantieni il tuo setup "buono" a sinistra
            layout.widths = list(
                left.padding      = 2,
                ylab.left         = 6,
                axis.left         = 4,
                ylab.axis.padding = 1.6,

                # spazio a destra per ylab.right
                right.padding     = 4
            ),

            par.xlab.text  = list(cex = 0.7),
            par.ylab.text  = list(cex = 0.7),
            par.main.text  = list(cex = 0.9)
        ),

        # numeri degli assi più piccoli (tick labels)
        scales = list(
            x = list(cex = 0.45),
            y = list(cex = 0.45, relation = "same")
        ),

        par.strip.text = list(cex = 0.45),
        between = list(x = 0.15, y = 0.15),
        strip = lattice::strip.custom(bg = "grey90"),
        strip.left = TRUE,

        xlab = "Age class",

        # TITOLO Y A DESTRA
        ylab = NULL,
        ylab.right = "Number of individuals (thousands)",

        main = paste0("Numbers by age (quarters summed) - ", SP, " in ", MS, " - ", GSA)
    )

    if (!requireNamespace("HH", quietly = TRUE)) stop("Package 'HH' is required.")

    strip_top  <- HH:::strip.useOuterStrips.first
    strip_left <- HH:::strip.left.useOuterStrips

    p <- HH::useOuterScales(
        p,
        strip      = strip_top,
        strip.left = strip_left,
        inner      = FALSE,

        # ====== QUESTA È LA CHIAVE ======
        # più grande = più spazio ai numeri dell'asse Y (evita "0000"/sparizione)
        y.ticks = 1
    )


    } else {
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
}
    return(p)
}
