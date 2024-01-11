#' Check headers of GFCM tables
#' @param data data frame of data for the reference table
#' @param table character, vector specifying the reference table. Allowed values: "task2.2", "task3", "task7.2", "task7.3.1", "task7.3.2"
#'
#' @return In case the data frame reports has the headers in the format of the RDBFIS database, it is returned back with the headers in the GFCM format adopted also by RDBqc package
#' @export GFCM_check_headers

GFCM_check_headers <- function (data, table) {

if (FALSE) {
  data <- read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB2\\data_GFCM\\dcrf_task_vii32_maturity_data_2022CHARIS.csv",sep=",", header=TRUE)
}

# Task2.2
task2.2 <- data.frame(matrix(ncol = 2, nrow = 9))
colnames(task2.2) <- c("RDBFIS", "RDBqc")
task2.2$RDBFIS <- c(
    "reference_year",
    "country",
    "gsa",
    "fleet_segment_cd",
    "species",
    "total_landing",
    "total_discard",
    "total_catch",
    "comments"
)
task2.2$RDBqc <- c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Segment",
    "Species",
    "Landing",
    "Discards",
    "Catch",
    "Comments"
)

# Task3
task3 <- data.frame(matrix(ncol = 2, nrow = 16))
colnames(task3) <- c("RDBFIS", "RDBqc")
task3$RDBFIS <- c(
    "reference_year",
    "country",
    "date_rec",
    "gsa",
    "source_data_cd",
    "fleet_segment_cd",
    "gear_cd",
    "species_group",
    "species_family",
    "species",
    "total_n_individ_caught",
    "total_w_individ_caught",
    "n_individ_released_alive",
    "n_dead_individuals",
    "n_individ_released_in_unknown_status",
    "comments"
)
task3$RDBqc <- c(
    "Reference_Year",
    "CPC",
    "Date",
    "GSA",
    "Source",
    "Segment",
    "Gear",
    "Group",
    "Family",
    "Species",
    "NumberCaught",
    "WeightCaught",
    "NumberAlive",
    "NumberDead",
    "NumberReleased",
    "Comments"
)


# Task7.2
task7.2 <- data.frame(matrix(ncol = 2, nrow = 13))
colnames(task7.2) <- c("RDBFIS", "RDBqc")
task7.2$RDBFIS <- c(
    "reference_year",
    "country",
    "gsa",
    "source_data_cd",
    "survey_name",
    "fleet_segment_cd",
    "species",
    "length_unit",
    "length",
    "n_individ_measured_per_lenclass",
    "w_individ_sampled_per_lenclass",
    "n_individ_expanded_per_lenclass",
    "comments"
)

task7.2$RDBqc <- c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Source",
    "SurveyName",
    "Segment",
    "Species",
    "LengthUnit",
    "Length",
    "NumberIndividualsMeasured",
    "WeightIndividualsSampled",
    "NumberIndividualsExpanded",
    "Comments"
)


# Task7.3.1
task7.3.1 <- data.frame(matrix(ncol = 2, nrow = 8))
colnames(task7.3.1) <- c("RDBFIS", "RDBqc")
task7.3.1$RDBFIS <- c(
    "reference_year",
    "country",
    "gsa",
    "species",
    "sex",
    "l50",
    "reference",
    "comments"
)

task7.3.1$RDBqc <- c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Species",
    "Sex",
    "L50",
    "Reference",
    "Comments"
)

# Task7.3.2
task7.3.2 <- data.frame(matrix(ncol = 2, nrow = 15))
colnames(task7.3.2) <- c("RDBFIS", "RDBqc")
task7.3.2$RDBFIS <- c(
    "reference_year",
    "country",
    "gsa",
    "source_data_cd",
    "survey_name",
    "fleet_segment_cd",
    "species",
    "length_unit",
    "len",
    "sex",
    "maturity",
    "n_individ_measured_per_lenclass_sex_mstage",
    "w_individ_sampled_per_lenclass_sex_mstage",
    "n_individ_expanded_per_lenclass_sex_mstage",
    "comments"
)

task7.3.2$RDBqc <- c(
    "Reference_Year",
    "CPC",
    "GSA",
    "Source",
    "SurveyName",
    "Segment",
    "Species",
    "LengthUnit",
    "Length",
    "Sex",
    "Maturity",
    "NumberIndividualsMeasured",
    "WeightIndividualsSampled",
    "NumberIndividualsExpanded",
    "Comments"
)

if (table == "task2.2") {
  if (all(colnames(data) %in% task2.2$RDBFIS )) {
    colnames(data) <- task2.2$RDBqc
  }
  return(data)
}

if (table == "task3") {
  if (all(colnames(data) %in% task3$RDBFIS )) {
    colnames(data) <- task3$RDBqc
  }
  return(data)
}

if (table == "task7.2") {
  if (all(colnames(data) %in% task7.2$RDBFIS )) {
    colnames(data) <- task7.2$RDBqc
  }
  return(data)
}

if (table == "task7.3.1") {
  if (all(colnames(data) %in% task7.3.1$RDBFIS )) {
    colnames(data) <- task7.3.1$RDBqc
  }
  return(data)
}

if (table == "task7.3.2") {
  if (all(colnames(data) %in% task7.3.2$RDBFIS )) {
    colnames(data) <- task7.3.2$RDBqc
  }
  return(data)
}

}
