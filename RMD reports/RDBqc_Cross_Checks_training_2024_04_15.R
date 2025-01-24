#-------------------
#    Cross-Checks
#-------------------

rm(list=ls())

library(RDBqc)
library(data.table)

# Once RDBqc package is loaded you can have access to all the functions stored in it
# just clicking on the package name on the right panel.
# Basically, the MEDBS functions begin with MEDBS_**** 

# As usual you can call directly the help using ??
# ??MEDBS_check_duplicates ## Calling the help guideline

## Highlighting the function (e.g. MEDBS_check_duplicates) and then starting send/enter will visualize the function code.
## This allows you to check what the function actually does.
# MEDBS_check_duplicates
# Finally, the RDBqc package has some dummy datasets stored to be used in testing the functions.


## Loading 2203 landings dataset ##
Land <- read.table("landings.csv", sep = ",", header = TRUE)
colnames(Land) <- toupper(colnames(Land))
head(Land)


## Loading 2203 discards dataset ##
Disc <- read.table("discards.csv", sep = ",", header = TRUE)
colnames(Disc) <- toupper(colnames(Disc))
head(Disc)

# Loading the file downloaded from the dissemination STECF FDI website (https://stecf.ec.europa.eu/data-dissemination/fdi_en)
# Data must be reshaped according to the FDI datacall templates
# Some records have been set as confidential. So, not all the data submitted are actually available
FDI_catch <- read.csv("TABLE_A_CATCH_FDI_2023.csv", sep = ",",header = TRUE)
head(FDI_catch)
unique(FDI_catch$year)

# Loading the file downloaded from the dissemination STECF AER website (https://stecf.jrc.ec.europa.eu/reports/economic)
AER_landings <- fread("AER_2307.csv", stringsAsFactors = F)


local_save <- FALSE # TRUE
# If set to FALSE, the results (plots and csv) will not be saved to local.
# On the other hand, if local_save is TRUE, a folder called "output" will be created in the WD where the main results will be saved.

# A useful dataframe has been embedded in the RDBqc package that lists the species code requested by the MEDBS data call.
MEDBSSP

##########################################################################
# Comparing total discards in weight between MEDBS and FDI EU Data Calls #
##########################################################################
(res1 <- Check_Tot_Disc(data=Disc,data1=FDI_catch,SP="MUT",MS="ITA",GSA="GSA 17",MEDBSSP,verbose=FALSE,OUT=FALSE))
class(res1)
length(res1)

??Check_Tot_Disc
#Check_Tot_Disc

# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
(res2 <- Check_Tot_Disc_gear(data=Disc,data1=FDI_catch,SP="MUT",MS="ITA",GSA="GSA 17",MEDBSSP,verbose=FALSE,OUT=local_save))
class(res2)
length(res2)
# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species, Gear and Quarter
(res3 <- Check_Tot_Disc_gear_Q(data=Disc,data1=FDI_catch,SP="MUT",MS="ITA",GSA="GSA 17",MEDBSSP,verbose=TRUE,OUT=local_save))
class(res3)
length(res3)
# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species, Gear and Fishery
(res4 <- Check_Tot_Disc_metier(data=Disc,data1=FDI_catch,SP="MUT",MS="ITA",GSA="GSA 17",MEDBSSP,verbose=FALSE,OUT=local_save))
class(res4)
length(res4)
##########################################################################
# Comparing total landings in weight between MEDBS and FDI EU Data Calls #
##########################################################################
(res1 <- Check_Tot_Land(data=Land, data1=FDI_catch, SP="ANE",MS="ROU",GSA="GSA 29", MEDBSSP, verbose = FALSE, OUT = local_save))
class(res1)
length(res1)
# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
(res2 <- Check_Tot_Land_gear(data=Land, data1=FDI_catch, SP="MUT",MS="ITA",GSA="GSA 17", MEDBSSP, verbose = TRUE, OUT = local_save))
class(res2)
length(res2)
# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species, Gear and Quarter
(res3 <- Check_Tot_Land_gear_Q(data=Land, data1=FDI_catch, SP="MUT",MS="BGR",GSA="GSA 29", MEDBSSP, verbose = TRUE, OUT = FALSE))
class(res3)
length(res3)
# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Fisheries
(res4 <- Check_Tot_Land_metier(data=Land, data1=FDI_catch, SP="HKE",MS="GRC",GSA="GSA 23", MEDBSSP, verbose = TRUE, OUT = FALSE))
class(res4)
length(res4)


###################################################
# MEDBS landings, FDI Table A Catch, AER landings #
###################################################
# Comparing total landings in weight between MEDBS, FDI and AER EU Data Calls
(res1 <- Check_Tot_Land2(data=Land, data1=FDI_catch, data2=AER_landings, SP="MUT",MS="ESP",GSA="GSA 6", MEDBSSP, verbose = TRUE, OUT = local_save))
Check_Tot_Land2(data=Land, data1=FDI_catch, data2=AER_landings, SP="MUT",MS="ITA",GSA="GSA 9", MEDBSSP, verbose = TRUE, OUT = local_save)
Check_Tot_Land2(data=Land, data1=FDI_catch, data2=AER_landings, SP="MUT",MS="FRA",GSA="GSA 7", MEDBSSP, verbose = TRUE, OUT = local_save)
Check_Tot_Land2(data=Land, data1=FDI_catch, data2=AER_landings, SP="MUT",MS="GRC",GSA="GSA 22", MEDBSSP, verbose = TRUE, OUT = local_save)


#####################################
# FDI catch data and AER catch data #
#####################################
# Cross check of landings or landings' value between the FDI and AER databases
??FDI_AER_land_landvalue
(res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "value", MS = "ITA", level = "GSA", YEAR = NA,GSA = "GSA9", SP = "MUT", OUT = local_save, verbose = FALSE))
(res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "landings", MS = "CYP", level = "GSA", YEAR = NA, SP = "MUT", OUT = local_save, verbose = FALSE))
(res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "value", MS = "ITA", level = "GSA", YEAR = 2020, SP = "MUT", OUT = local_save, verbose = FALSE))
(res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "value", MS = "ITA", level = "GEAR", YEAR = 2020, SP = "ARS", OUT = local_save, verbose = FALSE))
(res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "value", MS = "CYP", level = "GEAR", YEAR = NA, SP = "MUT", OUT = local_save, verbose = FALSE))

## END of SCRIPT ##