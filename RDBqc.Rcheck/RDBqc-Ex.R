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
nameEx("Check_Tot_Disc")
### * Check_Tot_Disc

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Disc
### Title: Comparing total discards in weight between MEDBS and FDI EU Data
###   Calls
### Aliases: Check_Tot_Disc

### ** Examples

## No test: 
 # Check_Tot_Disc(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Disc", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Disc_gear")
### * Check_Tot_Disc_gear

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Disc_gear
### Title: Comparing total discards in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Gear
### Aliases: Check_Tot_Disc_gear

### ** Examples

## No test: 
# Check_Tot_Disc_gear(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Disc_gear", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Disc_gear_Q")
### * Check_Tot_Disc_gear_Q

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Disc_gear_Q
### Title: Comparing total discards in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Gear
### Aliases: Check_Tot_Disc_gear_Q

### ** Examples

## No test: 
# Check_Tot_Disc_gear_Q (MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Disc_gear_Q", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Disc_metier")
### * Check_Tot_Disc_metier

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Disc_metier
### Title: Comparing total discards in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Metier
### Aliases: Check_Tot_Disc_metier

### ** Examples

## No test: 
# Check_Tot_Disc_metier(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Disc_metier", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land")
### * Check_Tot_Land

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land
### Title: Comparing total landings in weight between MEDBS and FDI EU Data
###   Calls
### Aliases: Check_Tot_Land

### ** Examples

## No test: 
# Check_Tot_Land(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subare or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land2")
### * Check_Tot_Land2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land2
### Title: Comparing total landings in weight between MEDBS, FDI and AER EU
###   Data Calls
### Aliases: Check_Tot_Land2

### ** Examples

## No test: 
# Check_Tot_Land2(MEDBS,FDI,AER,"ITA","GSA10","HKE",MEDBSSP,verbose=TRUE,OUT=FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land3")
### * Check_Tot_Land3

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land3
### Title: Comparing total landings in weight between MEDBS, FDI and AER EU
###   Data Calls
### Aliases: Check_Tot_Land3

### ** Examples

## No test: 
# Check_Tot_Land3(MEDBS, FDI, AER, "ITA", "GSA10", "HKE", MEDBSSP, verbose = TRUE, OUT = FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subare or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land3", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land_gear")
### * Check_Tot_Land_gear

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land_gear
### Title: Comparing total landings in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Gear
### Aliases: Check_Tot_Land_gear

### ** Examples

## No test: 
# Check_Tot_Land_gear(MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land_gear", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land_gear_Q")
### * Check_Tot_Land_gear_Q

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land_gear_Q
### Title: Comparing total landings in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Gear
### Aliases: Check_Tot_Land_gear_Q

### ** Examples

## No test: 
# Check_Tot_Land_gear_Q (MEDBS,FDI,"ITA","GSA10","HKE",MEDBSSP)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land_gear_Q", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("Check_Tot_Land_metier")
### * Check_Tot_Land_metier

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: Check_Tot_Land_metier
### Title: Comparing total landings in weight between MEDBS and FDI EU Data
###   Calls by Country, GSA, Species and Metier
### Aliases: Check_Tot_Land_metier

### ** Examples

## No test: 
# Check_Tot_Land_metier(MEDBS, FDI, "ITA", "GSA10", "HKE", MEDBSSP, verbose = TRUE, OUT = FALSE)
## End(No test)
# The function works by one country, subarea and species each.
# It is not possible assign more country, subarea or species.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("Check_Tot_Land_metier", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_AER_land_landvalue")
### * FDI_AER_land_landvalue

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_AER_land_landvalue
### Title: Cross check of landings or landings' value between the FDI and
###   AER databases
### Aliases: FDI_AER_land_landvalue

### ** Examples

FDI_AER_land_landvalue(FDI=fdi_a_catch, AER=aer_catch, var='landings',
level='GEAR', MS='PSP', YEAR=NA, GSA=c('GSA97', 'GSA98'), SP="HKE", OUT = TRUE, verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_AER_land_landvalue", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_check_coord")
### * FDI_check_coord

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_check_coord
### Title: Compatibility of the geographical coordinates with rectangle
###   type
### Aliases: FDI_check_coord

### ** Examples

FDI_check_coord(data = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_check_coord", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_checks_spatial_HI")
### * FDI_checks_spatial_HI

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_checks_spatial_HI
### Title: check NA values in spatial columns of both table H and I
### Aliases: FDI_checks_spatial_HI

### ** Examples

FDI_checks_spatial_HI(data = fdi_h_spatial_landings, MS = "PSP", verbose = TRUE)
FDI_checks_spatial_HI(data = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_checks_spatial_HI", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cov_tableA")
### * FDI_cov_tableA

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cov_tableA
### Title: Check number of record in FDI A table
### Aliases: FDI_cov_tableA

### ** Examples

FDI_cov_tableA(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")
FDI_cov_tableA(
  data = fdi_a_catch, SP = "MUT", MS = "PSP",
  fishtech = unique(fdi_a_catch$fishing_tech), GSA = "GSA99"
)
FDI_cov_tableA(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cov_tableA", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cov_tableG")
### * FDI_cov_tableG

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cov_tableG
### Title: Check FDI G table coverage
### Aliases: FDI_cov_tableG

### ** Examples

FDI_cov_tableG(data = fdi_g_effort, MS = "PSP", GSA = "GSA99")
FDI_cov_tableG(fdi_g_effort, MS = "PSP", GSA = "GSA99", fishtech = "DTS", met = "OTB_MDD_>=40_0_0")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cov_tableG", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cov_tableJ")
### * FDI_cov_tableJ

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cov_tableJ
### Title: Check number of record in FDI J table
### Aliases: FDI_cov_tableJ

### ** Examples

FDI_cov_tableJ(data = fdi_j_capacity, MS = "PSP", GSA = "GSA99")
FDI_cov_tableJ(data = fdi_j_capacity, MS = "PSP", GSA = "GSA99", fishtech = c("DTS", "PGP"))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cov_tableJ", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_coverage")
### * FDI_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_coverage
### Title: Coverage of data by GSA and year (reporting the number of
###   records)
### Aliases: FDI_coverage

### ** Examples

FDI_coverage(data = fdi_a_catch, MS = "PSP", verbose = FALSE)
FDI_coverage(data = fdi_h_spatial_landings, MS = "PSP", verbose = FALSE)
FDI_coverage(data = fdi_g_effort, MS = "PSP", verbose = FALSE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cross_checks_AG")
### * FDI_cross_checks_AG

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cross_checks_AG
### Title: Cross check between FDI tables A and G
### Aliases: FDI_cross_checks_AG

### ** Examples

FDI_cross_checks_AG(data1 = fdi_a_catch, data2 = fdi_g_effort)
FDI_cross_checks_AG(fdi_a_catch, fdi_g_effort)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cross_checks_AG", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cross_checks_AH")
### * FDI_cross_checks_AH

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cross_checks_AH
### Title: Cross check between FDI tables A and H
### Aliases: FDI_cross_checks_AH

### ** Examples

FDI_cross_checks_AH(data1 = fdi_a_catch, data2 = fdi_h_spatial_landings)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cross_checks_AH", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cross_checks_IG")
### * FDI_cross_checks_IG

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cross_checks_IG
### Title: Cross check between FDI tables I and G
### Aliases: FDI_cross_checks_IG

### ** Examples

FDI_cross_checks_IG(data1 = fdi_i_spatial_effort, data2 = fdi_g_effort)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cross_checks_IG", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_cross_checks_JG")
### * FDI_cross_checks_JG

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_cross_checks_JG
### Title: Cross check between FDI tables J and G
### Aliases: FDI_cross_checks_JG

### ** Examples

FDI_cross_checks_JG(data1 = fdi_j_capacity, data2 = fdi_g_effort, verbose = TRUE)
FDI_cross_checks_JG(fdi_j_capacity, fdi_g_effort)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_cross_checks_JG", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_disc_coverage")
### * FDI_disc_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_disc_coverage
### Title: Coverage of FDI discard data
### Aliases: FDI_disc_coverage

### ** Examples

FDI_disc_coverage(fdi_a_catch, MS = "PSP", GSA = "GSA99", SP = "HKE", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_disc_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_fishdays_cov")
### * FDI_fishdays_cov

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_fishdays_cov
### Title: Coverage comparison of totfishdays between FDI tables G and I
### Aliases: FDI_fishdays_cov

### ** Examples

FDI_fishdays_cov(dataG = fdi_g_effort, dataI = fdi_i_spatial_effort, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_fishdays_cov", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_landweight_cov")
### * FDI_landweight_cov

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_landweight_cov
### Title: Coverage of weight of landings in FDI table A and H
### Aliases: FDI_landweight_cov

### ** Examples

FDI_landweight_cov(dataA = fdi_a_catch, dataH = fdi_h_spatial_landings, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_landweight_cov", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_prices_cov")
### * FDI_prices_cov

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_prices_cov
### Title: Check prices trend in FDI A table
### Aliases: FDI_prices_cov

### ** Examples

FDI_prices_cov(data = fdi_a_catch, SP = c("MUT", "HKE"), MS = "PSP", GSA = "GSA99")
FDI_prices_cov(data = fdi_a_catch, SP = "MUT", MS = "PSP", GSA = "GSA99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_prices_cov", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_prices_not_null")
### * FDI_prices_not_null

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_prices_not_null
### Title: Check of species value
### Aliases: FDI_prices_not_null

### ** Examples

FDI_prices_not_null(
  data = fdi_a_catch, MS = "PSP", GSA = "GSA99",
  SP = c("ARA", "BOG", "HKE"), verbose = TRUE
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_prices_not_null", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_vessel_lenth")
### * FDI_vessel_lenth

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_vessel_lenth
### Title: Check of vessel lenght in FDI table J
### Aliases: FDI_vessel_lenth

### ** Examples

FDI_vessel_lenth(data = fdi_j_capacity, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_vessel_lenth", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("FDI_vessel_numbers")
### * FDI_vessel_numbers

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: FDI_vessel_numbers
### Title: Check number of vessels in FDI table J and G
### Aliases: FDI_vessel_numbers

### ** Examples

FDI_vessel_numbers(dataJ = fdi_j_capacity, dataG = fdi_g_effort, MS = "PSP", verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("FDI_vessel_numbers", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GFCM_cov_II2")
### * GFCM_cov_II2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GFCM_cov_II2
### Title: Check coverage of GFCM task II.2 table
### Aliases: GFCM_cov_II2

### ** Examples

GFCM_cov_II2(data = task_ii2, MS = "ITA", GSA = "18", SP = "HKE", segment = "COMBINED")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GFCM_cov_II2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("GFCM_cov_task_iii")
### * GFCM_cov_task_iii

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: GFCM_cov_task_iii
### Title: Check number of individuals in GFCM Task III table
### Aliases: GFCM_cov_task_iii

### ** Examples

GFCM_cov_task_iii(
  data = task_iii, SP = "Dasyatis pastinaca",
  MS = "ITA", GSA = "18"
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("GFCM_cov_task_iii", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_ALK")
### * MEDBS_ALK

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_ALK
### Title: Plot of Age-Length Keys
### Aliases: MEDBS_ALK

### ** Examples

MEDBS_ALK(data = ALK_tab_example, SP = "MUT", MS = "ITA", GSA = "GSA 99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_ALK", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_Catch_coverage")
### * MEDBS_Catch_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_Catch_coverage
### Title: Check the coverage of Catch table
### Aliases: MEDBS_Catch_coverage

### ** Examples

MEDBS_Catch_coverage(Catch_tab_example, "DPS", "ITA", "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_Catch_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_GP_check")
### * MEDBS_GP_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_GP_check
### Title: Check of growth parameters table
### Aliases: MEDBS_GP_check

### ** Examples

MEDBS_GP_check(GP_tab_example, "MUT", "ITA", "GSA 18")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_GP_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_LFD")
### * MEDBS_LFD

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_LFD
### Title: LFD of MED & BS landing and discard data
### Aliases: MEDBS_LFD

### ** Examples

MEDBS_LFD(data=RDBqc::Landing_tab_example,
data2=RDBqc::Discard_tab_example, type="b",
SP="DPS", MS="ITA", GSA="GSA 9", OUT=TRUE, verbose = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_LFD", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_LW_check")
### * MEDBS_LW_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_LW_check
### Title: Check LW parameters in GP table
### Aliases: MEDBS_LW_check

### ** Examples

MEDBS_LW_check(GP_tab_example, "MUT", "ITA", "GSA 18")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_LW_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_Landing_coverage")
### * MEDBS_Landing_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_Landing_coverage
### Title: Check the coverage of Landing table
### Aliases: MEDBS_Landing_coverage

### ** Examples

MEDBS_Landing_coverage(Landing_tab_example, "DPS", "ITA", "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_Landing_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_MA_check")
### * MEDBS_MA_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_MA_check
### Title: Check of MA_tab (maturity at age) table
### Aliases: MEDBS_MA_check

### ** Examples

MEDBS_MA_check(MA_tab_example, "DPS", "ITA", "GSA 99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_MA_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_ML_check")
### * MEDBS_ML_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_ML_check
### Title: Check of ML_tab (maturity at length) table
### Aliases: MEDBS_ML_check

### ** Examples

MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "GSA 99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_ML_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_SA_check")
### * MEDBS_SA_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_SA_check
### Title: Check of SA_tab (sex ratio at age) table
### Aliases: MEDBS_SA_check

### ** Examples

MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "GSA 99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_SA_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_SL_check")
### * MEDBS_SL_check

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_SL_check
### Title: Check of SL_tab (sex ratio at length) table
### Aliases: MEDBS_SL_check

### ** Examples

MEDBS_SL_check(SL_tab_example, "DPS", "ITA", "GSA 99")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_SL_check", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_SOP")
### * MEDBS_SOP

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_SOP
### Title: check of the sum of products
### Aliases: MEDBS_SOP

### ** Examples

MEDBS_SOP(data = Catch_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9", threshold = 5)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_SOP", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_check_disaggregated")
### * MEDBS_check_disaggregated

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_check_disaggregated
### Title: Check for disaggregated data rows in landings, discards and
###   catch tables
### Aliases: MEDBS_check_disaggregated

### ** Examples

MEDBS_check_disaggregated(
  data = Discard_tab_example, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_check_disaggregated(
  data = Landing_tab_example, type = "l", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_check_disaggregated(
  data = Catch_tab_example, type = "c", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_check_disaggregated", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_check_duplicates")
### * MEDBS_check_duplicates

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_check_duplicates
### Title: Check for duplicated data rows in MED & BS tables
### Aliases: MEDBS_check_duplicates

### ** Examples

MEDBS_check_duplicates(
  data = Discard_tab_example, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_check_duplicates(
  data = Landing_tab_example, type = "l", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_check_duplicates(
  data = Catch_tab_example, type = "c", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_check_duplicates", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_check_missing_years")
### * MEDBS_check_missing_years

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_check_missing_years
### Title: Check for missing years in MED & BS tables
### Aliases: MEDBS_check_missing_years

### ** Examples

df <- Discard_tab_example[-which(Discard_tab_example$year==2011),]
MEDBS_check_missing_years(
  data = df, end_year=2002, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_check_missing_years", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_disc_YQ")
### * MEDBS_comp_disc_YQ

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_disc_YQ
### Title: Comparison between discards in weight by quarter and -1
### Aliases: MEDBS_comp_disc_YQ

### ** Examples

MEDBS_comp_disc_YQ(data = Discard_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")



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

MEDBS_comp_disc_YQ_fishery(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_disc_YQ_fishery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_Q_VL")
### * MEDBS_comp_land_Q_VL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_Q_VL
### Title: Comparison between landings in weight by quarter accounting for
###   vessel length
### Aliases: MEDBS_comp_land_Q_VL

### ** Examples

MEDBS_comp_land_Q_VL(data = Landing_tab_example, MS = "ITA", GSA = "GSA 9", SP = "DPS")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_Q_VL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_comp_land_Q_VL_fishery")
### * MEDBS_comp_land_Q_VL_fishery

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_comp_land_Q_VL_fishery
### Title: Comparison between landings in weight by quarter and fishery,
###   accounting for vessel length
### Aliases: MEDBS_comp_land_Q_VL_fishery

### ** Examples

MEDBS_comp_land_Q_VL_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



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

MEDBS_comp_land_YQ(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_YQ", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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

MEDBS_comp_land_YQ_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_comp_land_YQ_fishery", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_disc_mean_weight")
### * MEDBS_disc_mean_weight

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_disc_mean_weight
### Title: Check of mean discard weight aggregations by year, gear and
###   fishery
### Aliases: MEDBS_disc_mean_weight

### ** Examples

MEDBS_disc_mean_weight(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_disc_mean_weight", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_discard_coverage")
### * MEDBS_discard_coverage

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_discard_coverage
### Title: Check the coverage of discard data
### Aliases: MEDBS_discard_coverage

### ** Examples

MEDBS_discard_coverage(Discard_tab_example, "DPS", "ITA", "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_discard_coverage", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_ks")
### * MEDBS_ks

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_ks
### Title: Kolmogorov-Smirnov test
### Aliases: MEDBS_ks

### ** Examples

MEDBS_ks(data = Landing_tab_example, type = "l", SP = "DPS", MS = "ITA", GSA = "GSA 9", Rt = 1)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_ks", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_land_mean_weight")
### * MEDBS_land_mean_weight

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_land_mean_weight
### Title: Mean weight by year, gear and fishery aggregation
### Aliases: MEDBS_land_mean_weight

### ** Examples

MEDBS_land_mean_weight(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



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

MEDBS_length_ind(Landing_tab_example,
  type = "l", SP = "DPS", MS = c("ITA"),
  GSA = c("GSA 9"), splines = c(0.2, 0.4, 0.6, 0.8),
  Xtresholds = c(0.25, 0.5, 0.75)
)
MEDBS_length_ind(Discard_tab_example,
  type = "d", SP = "DPS", MS = c("ITA"),
  GSA = c("GSA 9"), splines = c(0.2, 0.4, 0.6, 0.8),
  Xtresholds = c(0.25, 0.5, 0.75)
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_length_ind", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_lengthclass_0")
### * MEDBS_lengthclass_0

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_lengthclass_0
### Title: Checks length classes numbers with zeros in landings and
###   discards
### Aliases: MEDBS_lengthclass_0

### ** Examples

MEDBS_lengthclass_0(
  data = Landing_tab_example, type = "l",
  SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_lengthclass_0(
  data = Discard_tab_example, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



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

MEDBS_plot_disc_vol(data = Discard_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



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

MEDBS_plot_discard_ts(
  data = Discard_tab_example, SP = "DPS",
  MS = "ITA", GSA = "GSA 9", by = "quarter"
)
MEDBS_plot_discard_ts(
  data = Discard_tab_example, SP = "DPS",
  MS = "ITA", GSA = "GSA 9", by = "year"
)



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

MEDBS_plot_land_vol(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_land_vol", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_plot_landing_ts")
### * MEDBS_plot_landing_ts

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_plot_landing_ts
### Title: Plot of total landing time series
### Aliases: MEDBS_plot_landing_ts

### ** Examples

MEDBS_plot_landing_ts(
  data = Landing_tab_example, SP = "DPS",
  MS = "ITA", GSA = "GSA 9", by = "quarter"
)
MEDBS_plot_landing_ts(
  data = Landing_tab_example, SP = "DPS", MS = "ITA",
  GSA = "GSA 9", by = "year"
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_plot_landing_ts", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_weight_0")
### * MEDBS_weight_0

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_weight_0
### Title: Check of weights 0 in landings and discards
### Aliases: MEDBS_weight_0

### ** Examples

MEDBS_weight_0(
  data = Landing_tab_example, type = "l",
  SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_weight_0(
  data = Discard_tab_example, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_weight_0", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("MEDBS_weight_minus1")
### * MEDBS_weight_minus1

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: MEDBS_weight_minus1
### Title: Check weights -1 in landings
### Aliases: MEDBS_weight_minus1

### ** Examples

MEDBS_weight_minus1(
  data = Landing_tab_example, type = "l",
  SP = "DPS", MS = "ITA", GSA = "GSA 9", verbose = TRUE
)
MEDBS_weight_minus1(
  data = Discard_tab_example, type = "d", SP = "DPS",
  MS = "ITA", GSA = "GSA 9", verbose = TRUE
)



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

MEDBS_yr_missing_length(
  data = Discard_tab_example, type = "d",
  SP = "DPS", MS = "ITA", GSA = "GSA 9"
)
MEDBS_yr_missing_length(
  data = Landing_tab_example, type = "l", SP = "DPS",
  MS = "ITA", GSA = "GSA 9"
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("MEDBS_yr_missing_length", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_AL")
### * RCG_check_AL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_AL
### Title: Check consistency of age-length relationship
### Aliases: RCG_check_AL

### ** Examples

RCG_check_AL(
  data = data_ex, MS = "ITA", GSA = "GSA99",
  SP = "Mullus barbatus", min_age = 0, max_age = 9
)
RCG_check_AL(data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_AL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_CL")
### * RCG_check_CL

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_CL
### Title: Quality checks on CL RCG table
### Aliases: RCG_check_CL

### ** Examples

RCG_check_CL(data_exampleCL, MS = "COUNTRY1", GSA = "GSA99", SP = "Parapenaeus longirostris")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_CL", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_LFD")
### * RCG_check_LFD

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_LFD
### Title: Consistency check of LFDs
### Aliases: RCG_check_LFD

### ** Examples

RCG_check_LFD(
  data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
  min_len = 30, max_len = 300
)
RCG_check_LFD(
  data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
  min_len = NA, max_len = NA
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_LFD", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_LFD_comm_cat")
### * RCG_check_LFD_comm_cat

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_LFD_comm_cat
### Title: Check consistency of LFD by year and commercial category
### Aliases: RCG_check_LFD_comm_cat

### ** Examples

RCG_check_LFD_comm_cat(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_LFD_comm_cat", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_loc")
### * RCG_check_loc

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_loc
### Title: Check trip location
### Aliases: RCG_check_loc

### ** Examples

RCG_check_loc(data_ex)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_loc", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_lw")
### * RCG_check_lw

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_lw
### Title: Consistency check of length-weight relationship
### Aliases: RCG_check_lw

### ** Examples

RCG_check_lw(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus", Min = 0, Max = 1000)
RCG_check_lw(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_lw", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_mat")
### * RCG_check_mat

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_mat
### Title: Check consistency sex and maturity stage
### Aliases: RCG_check_mat

### ** Examples

RCG_check_mat(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_mat", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_check_mat_ogive")
### * RCG_check_mat_ogive

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_check_mat_ogive
### Title: check_mat_ogive
### Aliases: RCG_check_mat_ogive

### ** Examples

RCG_check_mat_ogive(data_ex,
  MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus",
  sex = "F", immature_stages = c("0", "1", "2a")
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_check_mat_ogive", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_summarize_ind_meas")
### * RCG_summarize_ind_meas

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_summarize_ind_meas
### Title: Number of individual by trip for which biological data have been
###   collected (length, sex, maturity, weight and age)
### Aliases: RCG_summarize_ind_meas

### ** Examples

RCG_summarize_ind_meas(data = data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_summarize_ind_meas", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("RCG_summarize_trips")
### * RCG_summarize_trips

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: RCG_summarize_trips
### Title: summarizing the number of trips/hauls monitored by year by port,
###   metier, sampling method;
### Aliases: RCG_summarize_trips

### ** Examples

RCG_summarize_trips(data_ex, MS = "ITA", GSA = "GSA99", SP = "Mullus barbatus")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("RCG_summarize_trips", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_EF_FDI_A")
### * check_EF_FDI_A

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_EF_FDI_A
### Title: Check empty fields in FDI A table
### Aliases: check_EF_FDI_A

### ** Examples

check_EF_FDI_A(fdi_a_catch)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_EF_FDI_A", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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

check_EF_FDI_H(fdi_h_spatial_landings)



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

check_EF_FDI_I(fdi_i_spatial_effort)



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
nameEx("check_RD_FDI_A")
### * check_RD_FDI_A

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_RD_FDI_A
### Title: Check duplicated records in FDI A table
### Aliases: check_RD_FDI_A

### ** Examples

check_RD_FDI_A(fdi_a_catch)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_RD_FDI_A", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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

check_RD_FDI_H(fdi_h_spatial_landings)



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

check_RD_FDI_I(fdi_i_spatial_effort)



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
nameEx("check_cs_header")
### * check_cs_header

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_cs_header
### Title: Headers check for CS table
### Aliases: check_cs_header

### ** Examples

check_cs_header(data_ex)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_cs_header", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_gfcm_header")
### * check_gfcm_header

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_gfcm_header
### Title: Headers check for GFCM tables
### Aliases: check_gfcm_header

### ** Examples

check_gfcm_header(task_ii2, "TASK_II.2", verbose = FALSE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_gfcm_header", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_l50_TaskVII.3.1")
### * check_l50_TaskVII.3.1

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_l50_TaskVII.3.1
### Title: Consistency of L50 values in Task VII.3.1 table
### Aliases: check_l50_TaskVII.3.1

### ** Examples

check_l50_TaskVII.3.1(task_vii31, MS = "ITA", GSA = "19", SP = "HKE")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_l50_TaskVII.3.1", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_ldf_TaskVII.2")
### * check_ldf_TaskVII.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_ldf_TaskVII.2
### Title: Consistency of length frequency distributions
### Aliases: check_ldf_TaskVII.2

### ** Examples

check_ldf_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "HKE")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_ldf_TaskVII.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lmat_TaskVII.3.2")
### * check_lmat_TaskVII.3.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lmat_TaskVII.3.2
### Title: Plot of the maturity stages per length for each sex and species
### Aliases: check_lmat_TaskVII.3.2

### ** Examples

check_lmat_TaskVII.3.2(task_vii32, MS = "ITA", GSA = "18", SP = "CTC")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lmat_TaskVII.3.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lw_TaskVII.2")
### * check_lw_TaskVII.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lw_TaskVII.2
### Title: Plot of the length-weight relationship
### Aliases: check_lw_TaskVII.2

### ** Examples

check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lw_TaskVII.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("check_lw_TaskVII.3.2")
### * check_lw_TaskVII.3.2

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: check_lw_TaskVII.3.2
### Title: Plot of the length-weight relationship by sex
### Aliases: check_lw_TaskVII.3.2

### ** Examples

check_lw_TaskVII.3.2(task_vii32, MS = "ITA", GSA = "18", SP = "CTC")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_lw_TaskVII.3.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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

check_minmaxl50_TaskVII.3.1(task_vii31, minmaxLtaskVII31, MS = "ITA", GSA = "19")



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

check_minmaxl_TaskVII.2(task_vii2, minmaxLtaskVII2, MS = "ITA", GSA = "18")



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

check_presence_taskII2(task_ii2, combination_taskII2, MS = "ITA", GSA = "18")



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

check_species_catfau_TaskVII.3.2(task_vii32, catfau_check, sex_mat,
  MS = "ITA", GSA = "18", SP = "HKE"
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("check_species_catfau_TaskVII.3.2", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
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
