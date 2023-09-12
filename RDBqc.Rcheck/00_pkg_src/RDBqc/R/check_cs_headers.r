#' Headers check for CS table
#'
#' @param cs RCG sampling table (CS)
#' @param verbose boolean. If TRUE messages are returned
#' @return The data frame of CS data is returned with the expected format used by the QC functions
#' @export
#' @examples check_cs_header(data_ex)
check_cs_header <- function(cs, verbose = FALSE) {
  if (FALSE) {
    cs <- data_ex
    cs <- read.csv("D:/Documents and Settings/Utente/Downloads/MED/sampling.csv")
  }

  tab <- structure(list(CS_RDBFIS = c(
    "sampling_type", "flag_country",
    "year", "trip_code", "harbour", "n_sets_hauls", "days_at_sea",
    "sampling_method", "aggregation_level", "station_number", "duration_fishing_operation",
    "initial_latitude", "initial_longitude", "final_latitude", "final_longitude",
    "depth_fishing_operation", "water_depth", "catch_registration",
    "species_registration", "date", "area", "fishing_activity_category_national",
    "fishing_activity_category_eu_l6", "species", "catch_category",
    "weight", "subsample_weight", "sex", "maturity_method", "maturity_scale",
    "maturity_stage", "ageing_method", "age", "length_code", "length_class",
    "number_at_length", "commercial_size_category_scale", "commercial_size_category",
    "fish_id", "individual_weight"
  ), CS_RDBqc = c(
    "Sampling_type",
    "Flag_country", "Year", "Trip_code", "Harbour", "Number_of_sets_hauls_on_trip",
    "Days_at_sea", "Sampling_method", "Aggregation_level", "Station_number",
    "Duration_of_fishing_operation", "Initial_latitude", "Initial_longitude",
    "Final_latitude", "Final_longitude", "Depth_of_fishing_operation",
    "Water_depth", "Catch_registration", "Species_registration",
    "Date", "Area", "Fishing_activity_category_National", "Fishing_activity_category_European_lvl_6",
    "Species", "Catch_category", "Weight", "Subsample_weight", "Sex",
    "Maturity_method", "Maturity_scale", "Maturity_Stage", "Ageing.method",
    "Age", "Length_code", "Length_class", "Number_at_length", "Commercial_size_category_scale",
    "Commercial_size_category", "fish_ID", "Individual_weight"
  )), class = "data.frame", row.names = c(
    NA,
    -40L
  ))

  names <- colnames(cs)
  if (all(names %in% tab$CS_RDBFIS) & length(names) == length(tab$CS_RDBFIS)) {
    colnames(cs) <- tab$CS_RDBqc
  } else if (all(names %in% tab$CS_RDBqc) & length(names) == length(tab$CS_RDBFIS)) {
    colnames(cs) <- tab$CS_RDBqc
  } else {
    if (verbose) {
      message("Error: Unexpected format for RCG CS sampling table")
    }
  }
  return(cs)
}
