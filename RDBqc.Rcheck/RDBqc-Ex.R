pkgname <- "RDBqc"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
base::assign(".ExTimings", "RDBqc-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('RDBqc')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Discard_coverage")
### * Discard_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Discard_coverage
### Title: Discard_cov: function to check the coverage in Discard table
### Aliases: Discard_coverage

### ** Examples

Discard_coverage(Discard_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Discard_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GP_check")
### * GP_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GP_check
### Title: GP_tab (growth params) table check
### Aliases: GP_check

### ** Examples

GP_check(GP_tab_example,"MUT","ITA","SA 18")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GP_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("LW_check_MED_BS")
### * LW_check_MED_BS

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: LW_check_MED_BS
### Title: LW params in GP_tab (sex ratio at length) table check#'
### Aliases: LW_check_MED_BS

### ** Examples

LW_check_MED_BS(GP_tab_example,"MUT","ITA","SA 18")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("LW_check_MED_BS", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Landing_coverage")
### * Landing_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Landing_coverage
### Title: Landing_cov: function to check the coverage in Landing table
### Aliases: Landing_coverage

### ** Examples

Landing_coverage(Landing_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Landing_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MA_tab_check")
### * MA_tab_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MA_tab_check
### Title: MA_tab (maturity at age) table check
### Aliases: MA_tab_check

### ** Examples

MA_tab_check(MA_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MA_tab_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_Catch_coverage")
### * MEDBS_Catch_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_Catch_coverage
### Title: Catch_cov: function to check the coverage in Catch table
### Aliases: MEDBS_Catch_coverage

### ** Examples

MEDBS_Catch_coverage(Catch_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_Catch_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_check_duplicates")
### * MEDBS_check_duplicates

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_check_duplicates
### Title: Check for duplicated data rows
### Aliases: MEDBS_check_duplicates

### ** Examples

MEDBS_check_duplicates(data=landing,type="l",MS="ITA",GSA="18",SP="ARA",verbose=TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_check_duplicates", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_disc_YQ")
### * MEDBS_comp_disc_YQ

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_disc_YQ
### Title: Comparison between discards in weight by quarter and -1
### Aliases: MEDBS_comp_disc_YQ

### ** Examples

MEDBS_comp_disc_YQ(disc=discards,MS="ITA",GSA=18,SP="MUT")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_disc_YQ", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_disc_YQ_fishery")
### * MEDBS_comp_disc_YQ_fishery

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_disc_YQ_fishery
### Title: Comparison between discards in weight by quarter, quarter -1 and
###   by fishery
### Aliases: MEDBS_comp_disc_YQ_fishery

### ** Examples

MEDBS_comp_disc_YQ(disc=discards,MS="ITA",GSA=18,SP="MUT")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_disc_YQ_fishery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_Q_VL_fishery")
### * MEDBS_comp_land_Q_VL_fishery

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_Q_VL_fishery
### Title: Comparison between landings in weight by quarter and fishery
###   accounting for vessel length
### Aliases: MEDBS_comp_land_Q_VL_fishery

### ** Examples

MEDBS_comp_land_Q_VL_fishery(land=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_Q_VL_fishery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_YQ")
### * MEDBS_comp_land_YQ

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_YQ
### Title: Comparison between landings in weight by quarter and -1
### Aliases: MEDBS_comp_land_YQ

### ** Examples

MEDBS_comp_land_YQ(land=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_YQ", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_YQ_VL")
### * MEDBS_comp_land_YQ_VL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_YQ_VL
### Title: Comparison between landings in weight by quarter accounting for
###   vessel length
### Aliases: MEDBS_comp_land_YQ_VL

### ** Examples

MEDBS_comp_land_YQ_VL(land=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_YQ_VL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_YQ_fishery")
### * MEDBS_comp_land_YQ_fishery

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_YQ_fishery
### Title: Comparison between landings in weight by quarter, quarter -1 and
###   by fishery
### Aliases: MEDBS_comp_land_YQ_fishery

### ** Examples

MEDBS_comp_land_YQ(land=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_YQ_fishery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_disc_mean_weight")
### * MEDBS_disc_mean_weight

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_disc_mean_weight
### Title: Mean weight by year,gear and fishery aggregation
### Aliases: MEDBS_disc_mean_weight

### ** Examples

MEDBS_disc_mean_weight(disc=discards,MS="ITA",GSA=18,SP="MUT")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_disc_mean_weight", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_land_mean_weight")
### * MEDBS_land_mean_weight

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_land_mean_weight
### Title: Mean weight by year,gear and fishery aggregation
### Aliases: MEDBS_land_mean_weight

### ** Examples

MEDBS_land_mean_weight(land=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_land_mean_weight", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_length_ind")
### * MEDBS_length_ind

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_length_ind
### Title: Main length size indicators
### Aliases: MEDBS_length_ind

### ** Examples

MEDBS_length_ind(landing,type="l",out="mean",MS=c("ITA"),
GSA=c("18"),SP="NEP", splines=c(0.2,0.4,0.6,0.8),
Xtresholds = c(0.25,0.5,0.75))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_length_ind", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_lengthclass_0")
### * MEDBS_lengthclass_0

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_lengthclass_0
### Title: Length classes number 0 in landings and discards
### Aliases: MEDBS_lengthclass_0

### ** Examples

MEDBS_lengthclass_0(data=landing,type="l",MS="ITA",GSA=11,SP="ARA",verbose=TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_lengthclass_0", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_plot_disc_vol")
### * MEDBS_plot_disc_vol

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_plot_disc_vol
### Title: Plot of total discards by gear and fishery
### Aliases: MEDBS_plot_disc_vol

### ** Examples

MEDBS_plot_disc_vol(data=discards,MS="ITA",GSA=18,SP="MUT")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_disc_vol", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_plot_discard_ts")
### * MEDBS_plot_discard_ts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_plot_discard_ts
### Title: Plot of total discards
### Aliases: MEDBS_plot_discard_ts

### ** Examples

MEDBS_plot_discard_ts(disc=discards,MS="ITA",GSA=11,SP="ARA",by="quarter")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_discard_ts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_plot_land_vol")
### * MEDBS_plot_land_vol

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_plot_land_vol
### Title: Plot of total landing by gear and fishery
### Aliases: MEDBS_plot_land_vol

### ** Examples

MEDBS_plot_land_vol(data=landing,MS="ITA",GSA=11,SP="ARA")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_land_vol", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_plot_landing_ts")
### * MEDBS_plot_landing_ts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_plot_landing_ts
### Title: Plot of total landing
### Aliases: MEDBS_plot_landing_ts

### ** Examples

MEDBS_plot_landing_ts(land=landing,MS="ITA",GSA=18,SP="ARA",by="quarter")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_landing_ts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_weight_0")
### * MEDBS_weight_0

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_weight_0
### Title: weight 0 in landings and discards
### Aliases: MEDBS_weight_0

### ** Examples

MEDBS_weight_0(data=landing,type="l",MS="ITA",GSA=18,SP="HKE", verbose=TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_weight_0", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_weight_minus1")
### * MEDBS_weight_minus1

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_weight_minus1
### Title: weight -1 in landings
### Aliases: MEDBS_weight_minus1

### ** Examples

MEDBS_weight_minus1(data=landing,type="l",MS="ITA",GSA=18,SP="HKE",verbose=TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_weight_minus1", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_yr_missing_length")
### * MEDBS_yr_missing_length

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_yr_missing_length
### Title: Years with missing length distributions
### Aliases: MEDBS_yr_missing_length

### ** Examples

MEDBS_yr_missing_length(data=landing,type="l",MS=c("ITA"),GSA=c("18"),SP="NEP")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_yr_missing_length", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ML_tab_check")
### * ML_tab_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ML_tab_check
### Title: ML_tab (maturity at length) table check
### Aliases: ML_tab_check

### ** Examples

ML_tab_check(ML_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ML_tab_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("SA_tab_check")
### * SA_tab_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: SA_tab_check
### Title: SA_tab (sex ratio at age) table check
### Aliases: SA_tab_check

### ** Examples

SA_tab_check(SA_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("SA_tab_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("SL_tab_check")
### * SL_tab_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: SL_tab_check
### Title: SL_tab (sex ratio at length) table check
### Aliases: SL_tab_check

### ** Examples

SL_tab_check(SL_tab_example,"DPS","ITA","9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("SL_tab_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_AL")
### * check_AL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_AL
### Title: Check consistency of age-length relationship
### Aliases: check_AL

### ** Examples

check_AL(data_ex,species="Mullus barbatus",min_age=0,max_age=30)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_AL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_CL")
### * check_CL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_CL
### Title: Quality checks on CL RCG table
### Aliases: check_CL

### ** Examples

check_CL(data_exampleCL,species="Parapenaeus longirostris")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_CL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_FDI_G")
### * check_EF_FDI_G

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_FDI_G
### Title: Check empty fields in FDI G table
### Aliases: check_EF_FDI_G

### ** Examples

check_EF_FDI_G(fdi_g_effort)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_FDI_G", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_FDI_H")
### * check_EF_FDI_H

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_FDI_H
### Title: Check empty fields in FDI H table
### Aliases: check_EF_FDI_H

### ** Examples

check_EF_FDI_H(fdi_h_spatial_land)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_FDI_H", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_FDI_I")
### * check_EF_FDI_I

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_FDI_I
### Title: Check empty fields in FDI I table
### Aliases: check_EF_FDI_I

### ** Examples

check_EF_FDI_I(fdi_i_spatial_fe)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_FDI_I", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_FDI_J")
### * check_EF_FDI_J

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_FDI_J
### Title: Check empty fields in FDI J table
### Aliases: check_EF_FDI_J

### ** Examples

check_EF_FDI_J(fdi_j_capacity)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_FDI_J", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_TaskVII31")
### * check_EF_TaskVII31

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_TaskVII31
### Title: Check empty fields in GFCM Task VII.3.1 table
### Aliases: check_EF_TaskVII31

### ** Examples

check_EF_TaskVII31(task_vii31)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_TaskVII31", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_TaskVII32")
### * check_EF_TaskVII32

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_TaskVII32
### Title: Check empty fields in GFCM Task VII.3.2 table
### Aliases: check_EF_TaskVII32

### ** Examples

check_EF_TaskVII32(task_vii32)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_TaskVII32", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_taskII2")
### * check_EF_taskII2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_taskII2
### Title: Check empty fields in GFCM Task II.2 table
### Aliases: check_EF_taskII2

### ** Examples

check_EF_taskII2(task_ii2)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_taskII2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_taskIII")
### * check_EF_taskIII

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_taskIII
### Title: Check empty fields in GFCM Task III table
### Aliases: check_EF_taskIII

### ** Examples

check_EF_taskIII(task_iii)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_taskIII", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_taskVII2")
### * check_EF_taskVII2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_taskVII2
### Title: Check empty fields in GFCM Task VII.2 table
### Aliases: check_EF_taskVII2

### ** Examples

check_EF_taskVII2(task_vii2)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_taskVII2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_LFD")
### * check_LFD

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_LFD
### Title: check LFD
### Aliases: check_LFD

### ** Examples

check_LFD(data_ex,species="Mullus barbatus",min_len=1,max_len=35)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_LFD", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_LFD_comm_cat")
### * check_LFD_comm_cat

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_LFD_comm_cat
### Title: Check consistency of LFD by year and commercial category
### Aliases: check_LFD_comm_cat

### ** Examples

check_LFD_comm_cat(data_ex, species="Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_LFD_comm_cat", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_FDI_G")
### * check_RD_FDI_G

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_FDI_G
### Title: Check duplicated records in FDI G table
### Aliases: check_RD_FDI_G

### ** Examples

check_RD_FDI_G(fdi_g_effort)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_FDI_G", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_FDI_H")
### * check_RD_FDI_H

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_FDI_H
### Title: Check duplicated records in FDI H table
### Aliases: check_RD_FDI_H

### ** Examples

check_RD_FDI_H(fdi_h_spatial_land)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_FDI_H", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_FDI_I")
### * check_RD_FDI_I

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_FDI_I
### Title: Check duplicated records in FDI I table
### Aliases: check_RD_FDI_I

### ** Examples

check_RD_FDI_I(fdi_i_spatial_fe)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_FDI_I", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_FDI_J")
### * check_RD_FDI_J

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_FDI_J
### Title: Check duplicated records in FDI J table
### Aliases: check_RD_FDI_J

### ** Examples

check_RD_FDI_J(fdi_j_capacity)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_FDI_J", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_TaskVII32")
### * check_RD_TaskVII32

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_TaskVII32
### Title: Check duplicated records in GFCM Task VII.3.2 table
### Aliases: check_RD_TaskVII32

### ** Examples

check_RD_TaskVII32(task_vii32)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_TaskVII32", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_taskII2")
### * check_RD_taskII2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_taskII2
### Title: Check duplicated records in GFCM Task II.2 table
### Aliases: check_RD_taskII2

### ** Examples

check_RD_taskII2(task_ii2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_taskII2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_taskIII")
### * check_RD_taskIII

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_taskIII
### Title: Check duplicated records in GFCM Task III table
### Aliases: check_RD_taskIII

### ** Examples

check_RD_taskIII(task_iii)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_taskIII", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_taskVII2")
### * check_RD_taskVII2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_taskVII2
### Title: Check duplicated records in GFCM Task VII.2 table
### Aliases: check_RD_taskVII2

### ** Examples

check_RD_taskVII2(task_vii2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_taskVII2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_RD_taskVII31")
### * check_RD_taskVII31

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_taskVII31
### Title: Check duplicated records in GFCM Task VII.3.1 table
### Aliases: check_RD_taskVII31

### ** Examples

check_RD_taskVII31(task_vii31)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_taskVII31", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lmat_TaskVII.3.2")
### * check_lmat_TaskVII.3.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lmat_TaskVII.3.2
### Title: Plot of the maturity stages per length for each sex and species
### Aliases: check_lmat_TaskVII.3.2

### ** Examples

check_lmat_TaskVII.3.2(task_vii32)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lmat_TaskVII.3.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_loc")
### * check_loc

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_loc
### Title: Check trip location
### Aliases: check_loc

### ** Examples

check_loc(data_ex)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_loc", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lw")
### * check_lw

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lw
### Title: Consistency of length-weight relationship and consistency with
###   allowed ranges
### Aliases: check_lw

### ** Examples

check_lw(data_ex,species="Mullus barbatus",Min=0,Max=1000)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lw", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lw_TaskVII.2")
### * check_lw_TaskVII.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lw_TaskVII.2
### Title: Plot of the relationship length weight for each species
### Aliases: check_lw_TaskVII.2

### ** Examples

check_lw_TaskVII.2(task_vii2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lw_TaskVII.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_mat")
### * check_mat

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_mat
### Title: Check consistency sex and maturity stage
### Aliases: check_mat

### ** Examples

check_mat(data_ex,species="Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_mat", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_mat_ogive")
### * check_mat_ogive

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_mat_ogive
### Title: Maturity ogives by sex
### Aliases: check_mat_ogive

### ** Examples

check_mat_ogive(data_ex,species="Mullus barbatus",
sex="F",immature_stages=c("0","1","2a"))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_mat_ogive", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_minmaxl50_TaskVII.3.1")
### * check_minmaxl50_TaskVII.3.1

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_minmaxl50_TaskVII.3.1
### Title: Comparison between min/max L50 observed for each species and sex
###   with theoretical values
### Aliases: check_minmaxl50_TaskVII.3.1

### ** Examples

check_minmaxl50_TaskVII.3.1(task_vii31,minmaxLtaskVII31)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_minmaxl50_TaskVII.3.1", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_minmaxl_TaskVII.2")
### * check_minmaxl_TaskVII.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_minmaxl_TaskVII.2
### Title: Comparison between min/max observed for each species with
###   theoretical values
### Aliases: check_minmaxl_TaskVII.2

### ** Examples

check_minmaxl_TaskVII.2(task_vii2,minmaxLtaskVII2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_minmaxl_TaskVII.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_presence_taskII2")
### * check_presence_taskII2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_presence_taskII2
### Title: Check of missing combination GSA/Fleet segment per year
### Aliases: check_presence_taskII2

### ** Examples

check_presence_taskII2(task_ii2,combination_taskII2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_presence_taskII2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_species_catfau_TaskVII.3.2")
### * check_species_catfau_TaskVII.3.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_species_catfau_TaskVII.3.2
### Title: Check mismatching species/Catfau and Sex per maturity stages for
###   Task VII.3.2 table
### Aliases: check_species_catfau_TaskVII.3.2

### ** Examples

check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_species_catfau_TaskVII.3.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summarize_ind_meas")
### * summarize_ind_meas

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summarize_ind_meas
### Title: Number of individual by trip for which biological data have been
###   collected (length, sex, maturity, weight and age)
### Aliases: summarize_ind_meas

### ** Examples

summarize_ind_meas(data_ex)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summarize_ind_meas", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("summarize_trips")
### * summarize_trips

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: summarize_trips
### Title: summarizing the number of trips/hauls monitored by year by port,
###   metier, sampling method;
### Aliases: summarize_trips

### ** Examples

summarize_trips(data_ex)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("summarize_trips", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
