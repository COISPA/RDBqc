#' Headers check for GFCM tables
#'
#' @param data GFCM table data frame
#' @param task character value reporting the specific GFCM table (task) of the data. Allowed values: "II.2", "III", "VII.2", "VII.3.1", "VII.3.2"
#' @param verbose boolean. If TRUE messages are returned
#' @return The data frame of the selected GFCM task is returned with the expected format used by the QC functions
#' @export
#' @examples check_gfcm_header(task_ii2, "TASK_II.2", verbose = FALSE)
check_gfcm_header <- function(data, task, verbose = FALSE) {
  if (FALSE) {
    data <- T_vii32
    data <- read.csv("~/GitHub/RDBqc/APPOGGIO/Ioannis/vii32.csv")
    task <- "VII.3.2"
    check_gfcm_header(data, "VII.3.2")
  }

  tab <- structure(list(n = 1:61, table = c(
    "II.2", "II.2", "II.2", "II.2",
    "II.2", "II.2", "II.2", "II.2", "II.2", "III", "III", "III",
    "III", "III", "III", "III", "III", "III", "III", "III", "III",
    "III", "III", "III", "III", "VII.2", "VII.2", "VII.2", "VII.2",
    "VII.2", "VII.2", "VII.2", "VII.2", "VII.2", "VII.2", "VII.2",
    "VII.2", "VII.2", "VII.3.1", "VII.3.1", "VII.3.1", "VII.3.1",
    "VII.3.1", "VII.3.1", "VII.3.1", "VII.3.1", "VII.3.2", "VII.3.2",
    "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2",
    "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2", "VII.3.2",
    "VII.3.2"
  ), RDBFIS = c(
    "year", "country", "gsa", "fleet_segment_cd",
    "species", "total_landing", "total_discard", "total_catch", "comments",
    "year", "country", "date_rec", "gsa", "source_data_cd", "fleet_segment_cd",
    "gear_cd", "species_group", "species_family", "species", "total_n_individ_caught",
    "total_w_individ_caught", "n_individ_released_alive", "n_dead_individuals",
    "n_individ_released_in_unknown_status", "comments", "year", "country",
    "gsa", "source_data_cd", "survey_name", "fleet_segment_cd", "species",
    "length_unit", "length", "n_individ_measured_per_lenclass", "w_individ_sampled_per_lenclass",
    "n_individ_expanded_per_lenclass", "comments", "year", "country",
    "gsa", "species", "sex", "l50", "reference", "comments", "year",
    "country", "gsa", "source_data_cd", "survey_name", "fleet_segment_cd",
    "species", "length_unit", "len", "sex", "maturity", "n_individ_measured_per_lenclass_sex_mstage",
    "w_individ_sampled_per_lenclass_sex_mstage", "n_individ_expanded_per_lenclass_sex_mstage",
    "comments"
  ), RDBqc = c(
    "Reference_Year", "CPC", "GSA", "Segment",
    "Species", "Landing", "Discards", "Catch", "Comments", "Reference_Year",
    "CPC", "Date", "GSA", "Source", "Segment", "Gear", "Group", "Family",
    "Species", "NumberCaught", "WeightCaught", "NumberAlive", "NumberDead",
    "NumberReleased", "Comments", "Reference_Year", "CPC", "GSA",
    "Source", "SurveyName", "Segment", "Species", "LengthUnit", "Length",
    "NumberIndividualsMeasured", "WeightIndividualsSampled", "NumberIndividualsExpanded",
    "Comments", "Reference_Year", "CPC", "GSA", "Species", "Sex",
    "L50", "Reference", "Comments", "Reference_Year", "CPC", "GSA",
    "Source", "SurveyName", "Segment", "Species", "LengthUnit", "Length",
    "Sex", "Maturity", "NumberIndividualsMeasured", "WeightIndividualsSampled",
    "NumberIndividualsExpanded", "Comments"
  )), class = "data.frame", row.names = c(
    NA,
    -61L
  ))

  if (task %in% c("II.2", "III", "VII.2", "VII.3.1", "VII.3.2")) {
    if (verbose) {
      message(paste0("Header conversion of task ", task, " table"))
    }
    tab <- tab[tab$table == task, ]
    names <- colnames(data)
    if (all(names %in% tab$RDBFIS) & length(names) == length(tab$RDBFIS)) {
      colnames(data) <- tab$RDBqc
    } else if (all(names %in% tab$CS_RDBqc) & length(names) == length(tab$CS_RDBFIS)) {
      colnames(data) <- tab$CS_RDBqc
    } else {
      if (verbose) {
        message("Error: Unexpected format for GFCM table")
      }
    }
  } else { # task in "II.2", "III", "VII.2", "VII.3.1", "VII.3.1"
    if (verbose) {
      message("Unexpected table provided")
    }
  }
  return(data)
}
