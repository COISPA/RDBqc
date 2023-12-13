# RBDqc 0.0.17.15
 * addressing new table format in FDI data call (new field "metier_7" and new colnames for rectangle_lat and rectangle_lon fields)
# RBDqc 0.0.17.14
 * Bug correction in check_age_MEDBS_AR
# RDBqc 0.0.17.12
 * Improvement of outputs of check_ldf_TaskVII.2 function
 * Improvement of outputs of RCG_check_loc
 * Improvement of outputs of RCG_summarize_ind_meas
 * RCG_check_mat_ogive
# RDBqc 0.0.17.10
 * Improvement of outputs of MEDBS_check_missing_years function
 * Improvement of outputs of FDI_AER_land_landvalue function
# RDBqc 0.0.17.09
 * Improvement of outputs of MEDBS_ks function 
 * Improvement of plots in MEDBS_LW_check function
# RDBqc 0.0.17.08
 * 5% threshold value introduced in the FDI_AER_land_landvalue function output
 * MEDBS cross-checks modified to allow GSA filter with and without space (e.g. "GSA18","GSA 18")
# RDBqc 0.0.17.07
 * updated version of FDI_AER_land_landvalue function
# RDBqc 0.0.17.06
 * Improving output saving in the cross-data call checks
# RDBqc 0.0.17.05
 * Inclusion of a new function to detect the presence of disaggregated data: MEDBS_check_disaggregated
 * Inclusion of a new function to detect the presence of missing years in data: MEDBS_check_missing_years

# RDBqc 0.0.17.04
 * Improved checks for missing data in landing for MEDBS_length_ind function
 * modification of table output in MEDBS_LFD function

# RDBqc 0.0.17.03
 * Modification of SOP table output
 * inclusion of check on "sex_ratio" header in SA and SL tables

# RDBqc 0.0.17.02
 * improving results of MEDBS functions (SOP, Discard_coverage, plot_discard_ts, plot_disc_vol) 
 * expansion of MEDBS_check_duplicates function to all MED&BS tables of biological parameters (GP, ALK, MA, ML, SRA, SRL)

# RDBqc 0.0.17
 * improving results of MEDBS functions (ALK, LFD, yr_missing_length) 
 * expansion of MEDBS_check_duplicates function to all MED&BS tables of biological parameters (GP, ALK, MA, ML, SRA, SRL)

# RDBqc 0.0.16
 * update compatibility with R version 4.3

# RDBqc v0.0.15
  * included new functions for cross-checks between data calls' tables (developed in the frame of QualiTrain project)
  
# RDBqc v0.0.11
  * included new FDI functions
  
# RDBqc v0.0.10
  * update of MEDBS functions
  * new functions to check SOP and ALK
  * implemented the treatment of NA values for VESSEL_LENGTH, GEAR, FISHERY and MESH_SIZE_RANGE in MEDBS functions 
  * Included new FDI functions
  
# RDBqc v0.0.9
  * toupper in colnames of MEDBS checks 
  
# RDBqc v0.0.8
  * Vignette included in the library
  * some bugs solved

# RDBqc v0.0.7
  * README completed with examples
  * some bugs solved

# RDBqc v0.0.6
  * Lots of scripts' modifications

# RDBqc v0.0.5
  * Lots of scripts' modifications

# RDBqc v0.0.4
  * MEDBS checks implemented

# RDBqc v0.0.3
  * GFCM checks implemented 

# RDBqc v0.0.2
  * FDI checks implemented 

# RDBqc v0.0.1
  * MED&BS - RCG functions implemented
