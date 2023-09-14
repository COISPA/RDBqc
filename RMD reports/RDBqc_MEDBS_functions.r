SP <- "MUT" # change according to the selected species for the analysis
MS <- "ITA" # change according to the selected member state for the analysis
GSA <- "GSA 18" # change according to the selected GSA for the analysis
separator <- "," # define the value separator used in the csv data files used
local_save <- TRUE # TRUE value allows to save results of cross-checks on local working folder

#-------------
#    CATCH
#-------------
Catch <- read.table("./catch.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = Catch, type = "c", SP = SPs[s], MS = "ITA", GSA = GSAs[g], verbose = TRUE)
## Coverage of catch data
res <- suppressMessages(MEDBS_Catch_coverage(Catch, SP = SPs[s], MS = MS, GSA = GSAs[g]))
## Check of Sum of Products (SOP)
res <- suppressMessages(MEDBS_SOP(Catch, SP = SPs[s], MS = MS, GSA = GSAs[g], threshold = SOP_threshold, verbose = TRUE))


#-------------
#    LANDINGS
#-------------
Land <- read.table("./landings_gsa18.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = Land, type = "l", SP = SPs[s], MS = "ITA", GSA = GSAs[g], verbose = TRUE)
## Coverage of landings data
res <- suppressMessages(MEDBS_Landing_coverage(Land, SP = SPs[s], MS = MS, GSA = GSAs[g]))
## Comparison of landing volumes aggregated by quarter and fishery accounting for vessel length
res <- suppressMessages(MEDBS_comp_land_Q_VL_fishery(data = Land, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Comparison of landing volumes aggregated by fishery accounting for time frame
res <- suppressMessages(MEDBS_comp_land_YQ_fishery(data = Land, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Kolmogorov-Smirnov test
res <- suppressMessages(MEDBS_ks(data = Land, type = "l", SP = SPs[s], MS = MS, GSA = GSAs[g], Rt = Rt))
## Check the presence of length classes numbers with zeros in landings
res <- suppressMessages(MEDBS_lengthclass_0(data = Land, type = "l", MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Main length size indicators
res <- suppressMessages(MEDBS_length_ind(data = Land, type = "l", MS = MS, GSA = GSAs[g], SP = SPs[s], splines = c(0.2, 0.4, 0.6, 0.8), Xtresholds = c(0.25, 0.5, 0.75)))
## Check the presence of years with missing length distribution
res <- suppressMessages(MEDBS_yr_missing_length(data = Land, type = "l", MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Check the presence of landing weights with zeros in landings
res <- MEDBS_weight_0(data = Land, type = "l", MS = MS, GSA = GSAs[g], SP = SPs[s], verbose = TRUE)
## Check the presence of landing weights with -1 in landings
res <- MEDBS_weight_minus1(data = Land, type = "l", MS = MS, GSA = GSAs[g], SP = SPs[s], verbose = TRUE)
## Mean weight by year, gear and fishery aggregation
res <- suppressMessages(MEDBS_land_mean_weight(data = Land, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Total landing time series by quarter
res <- suppressMessages(MEDBS_plot_landing_ts(data = Land, MS = MS, GSA = GSAs[g], SP = SPs[s], by = "quarter"))
## Total landing time series by gear and fishery
res <- suppressMessages(MEDBS_plot_land_vol(data = Land, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Landing Length Frequency Distribution
res <- suppressMessages(MEDBS_LFD(data = Land, data2=NA, type="l", MS = MS, GSA = GSAs[g], SP = SPs[s], OUT=FALSE, verbose = TRUE))


#-------------
#    DISCARDS
#-------------
Disc <- read.table("./discards_gsa18.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = Disc, type = "d", SP = SPs[s], MS = "ITA", GSA = GSAs[g], verbose = TRUE)
## Coverage of discards data
res <- suppressMessages(MEDBS_discard_coverage(Disc, SP = SPs[s], MS = MS, GSA = GSAs[g]))
## Comparison between discards in weight by quarter and year
res <- suppressMessages(MEDBS_comp_disc_YQ(data = Disc, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Comparison between discards in weight by quarter and year, accounting for fishery
res <- suppressMessages(MEDBS_comp_disc_YQ_fishery(data = Disc, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Mean weight by year, gear and fishery aggregation
res <- suppressMessages(MEDBS_disc_mean_weight(data = Disc, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Kolmogorov-Smirnov test
res <- suppressMessages(MEDBS_ks(data = Disc, type = "d", SP = SPs[s], MS = MS, GSA = GSAs[g], Rt = Rt))
## Check the presence of length classes numbers with zeros in discards
res <- suppressMessages(MEDBS_lengthclass_0(data = Disc, type = "d", MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Main length size indicators
res <- suppressMessages(MEDBS_length_ind(data = Disc, type = "d", MS = MS, GSA = GSAs[g], SP = SPs[s], splines = c(0.2, 0.4, 0.6, 0.8), Xtresholds = c(0.25, 0.5, 0.75)))
## Check the presence of years with missing length distribution
res <- suppressMessages(MEDBS_yr_missing_length(data = Disc, type = "d", MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Check the presence of discard weights with zeros in discards
res <- MEDBS_weight_0(data = Disc, type = "d", MS = MS, GSA = GSAs[g], SP = SPs[s], verbose = TRUE)
## Check the presence of discard weights with -1 in discards
res <- MEDBS_weight_minus1(data = Disc, type = "d", MS = MS, GSA = GSAs[g], SP = SPs[s], verbose = TRUE)
## Total discard time series by quarter
res <- suppressMessages(MEDBS_plot_discard_ts(data = Disc, MS = MS, GSA = GSAs[g], SP = SPs[s], by = "quarter"))
## Total discard time series by gear and fishery
res <- suppressMessages(MEDBS_plot_disc_vol(data = Disc, MS = MS, GSA = GSAs[g], SP = SPs[s]))
## Discard Length Frequency Distribution
res <- suppressMessages(MEDBS_LFD(data = Disc, data2=NA, type="d", MS = MS, GSA = GSAs[g], SP = SPs[s], OUT=FALSE, verbose = TRUE))


#-------------
#      ML
#-------------
ML <- read.table("./ml.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = ML, type = "ml", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## Plots of Maturity at Length (ML) data
res <- suppressMessages(MEDBS_ML_check(ML, SP = SPs[s], MS = MS, GSA = GSAs[g]))


#-------------
#      MA
#-------------
MA <- read.table("./ma.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = MA, type = "ma", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## Plots of Maturity at Age (MA) data
res <- suppressMessages(MEDBS_MA_check(MA, SP = SPs[s], MS = MS, GSA = GSAs[g]))


#-------------
#     SRL
#-------------
SL <- read.table("./srl.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = SL, type = "srl", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## Plots of Sex Ratio at length (SRL) data
res <- suppressMessages(MEDBS_SL_check(SL, SP = SPs[s], MS = MS, GSA = GSAs[g]))


#-------------
#     SRA
#-------------
SA <- read.table("./sra.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = SA, type = "sra", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## Plots of Sex Ratio at age (SRA) data
res <- suppressMessages(MEDBS_SA_check(SA, SP = SPs[s], MS = MS, GSA = GSAs[g]))


#-------------
#      GP
#-------------
GP <- read.table("./gp.csv", sep = separator, header = TRUE)
## Presence of duplicated records
res <- MEDBS_check_duplicates(data = GP, type = "gp", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## plots of the growth parameter
res <- suppressMessages(MEDBS_GP_check(GP, SP = SPs[s], MS = MS, GSA = GSAs[g]))
## Plots of length-weight (LW) functions
res <- suppressMessages(MEDBS_LW_check(GP, SP = SPs[s], MS = MS, GSA = GSAs[g]))


#-------------
#     ALK
#-------------
ALK <- read.table("./alk.csv", sep = separator, header = TRUE)
# Presence of duplicated records
res <- MEDBS_check_duplicates(data = ALK, type = "alk", SP = SPs[s], MS = MS, GSA = GSAs[g], verbose = TRUE)
## Plots of Age-Length Keys (ALK) data
res <- suppressMessages(MEDBS_ALK(ALK, SP = SPs[s], MS = MS, GSA = GSAs[g]))

#------------------------------------------------------------------------------

#-------------------
#    Cross-Checks
#-------------------
# MEDBS discards and FDI Table A Catch
Disc <- read.table("./discards.csv", sep = separator, header = TRUE)
FDI_catch <- read.table("./FDI_Catch.csv", sep = separator, header = TRUE)

# Comparing total discards in weight between MEDBS and FDI EU Data Calls
res1 <- Check_Tot_Disc(data=Disc,data1=FDI_catch,MS,GSA,SP,MEDBSSP,verbose=TRUE,OUT=local_save)

# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
res2 <- Check_Tot_Disc_gear(data=Disc,data1=FDI_catch,MS,GSA,SP,MEDBSSP,verbose=TRUE,OUT=local_save)

# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
res3 <- Check_Tot_Disc_gear_Q(data=Disc,data1=FDI_catch,MS,GSA,SP,MEDBSSP,verbose=TRUE,OUT=local_save)

# Comparing total discards in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Metier
res4 <- Check_Tot_Disc_metier(data=Disc,data1=FDI_catch,MS,GSA,SP,MEDBSSP,verbose=TRUE,OUT=local_save)

#---------------
# MEDBS landings and FDI Table A Catch
Land <- read.table("./landings.csv", sep = separator, header = TRUE)
FDI_catch <- read.table("./FDI_Catch.csv", sep = separator, header = TRUE)

# Comparing total landings in weight between MEDBS and FDI EU Data Calls
res1 <- Check_Tot_Land(data=Land, data1=FDI_catch, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = local_save)

# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
res2 <- Check_Tot_Land_gear(data=Land, data1=FDI_catch, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = local_save)

# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Gear
res3 <- Check_Tot_Land_gear_Q(data=Land, data1=FDI_catch, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = local_save)

# Comparing total landings in weight between MEDBS and FDI EU Data Calls by Country, GSA, Species and Metier
res4 <- Check_Tot_Land_metier(data=Land, data1=FDI_catch, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = local_save)

#---------------
# MEDBS landings, FDI Table A Catch, AER landings
Land <- read.table("./discards.csv", sep = separator, header = TRUE)
FDI_catch <- read.table("./FDI_Catch.csv", sep = separator, header = TRUE)
AER_landings <- read.table("./AER_landings.csv", sep = separator, header = TRUE)
# Comparing total landings in weight between MEDBS, FDI and AER EU Data Calls
res1 <- Check_Tot_Land2(data=Land, data1=FDI_catch, data2=AER_landings, MS, GSA, SP, MEDBSSP, verbose = TRUE, OUT = local_save)


#---------------
# FDI catch data and AER catch data
FDI_catch <- read.table("./FDI_Catch.csv", sep = separator, header = TRUE)
AER_landings <- read.table("./AER_landings.csv", sep = separator, header = TRUE)

# Cross check of landings or landings' value between the FDI and AER databases
res <- FDI_AER_land_landvalue(FDI=FDI_catch, AER=AER_landings, var = "landings", MS, level = "METIER", YEAR = NA, GSA = NA, SP = NA, OUT = local_save, verbose = TRUE)

#---------------
# MED&BS ALK table and Annual Report data table 2.2
ALK <- read.table("./alk.csv", sep = separator, header = TRUE)
AR_2.2 <- read.table("./AR_2.2.csv", sep = separator, header = TRUE)
# Cross check of number of age measurements between MED&BS ALK table and AR Table 2.2
res <- check_age_MEDBS_AR(ALK=ALK, AR=AR_2.2, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=local_save, verbose = TRUE)

#---------------
# MED&BS catch table and Annual Report data table 2.1
Catch <- read.table("./catch.csv", sep = separator, header = TRUE)
AR_2.1 <- read.table("./AR_2.1.csv", sep = separator, header = TRUE)
# Cross check of number of lengths between MED&BS catch table and AR Table 2.1
res <- check_lengths_MEDBS_AR(MEDBS=Catch, AR=AR_2.1, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=local_save, verbose = TRUE)

#---------------
# MED&BS ML table and Annual Report data table 2.2
ML <- read.table("./ml.csv", sep = separator, header = TRUE)
AR_2.2 <- read.table("./AR_2.2.csv", sep = separator, header = TRUE)
# Cross check of number of maturity measurements between MED&BS ML table and AR Table 2.2
res <- check_maturity_MEDBS_AR(ML=ML, AR=AR_2.2, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=local_save, verbose = TRUE)

#---------------
# MED&BS GP table and Annual Report data table 2.2
GP <- read.table("./gp.csv", sep = separator, header = TRUE)
AR_2.2 <- read.table("./AR_2.2.csv", sep = separator, header = TRUE)
# Cross check of number of weight measurements between MED&BS GP table and AR Table 2.2
res <- check_weights_MEDBS_AR(GP=GP, AR=AR_2.2, MS, GSA, SP, year, species_list = RDBqc::SSPP, OUT=local_save, verbose = TRUE)

#---------------
# MED&BS catch table and Annual Report data table 2.5
Catch <- read.table("./catch.csv", sep = separator, header = TRUE)
AR_2.5 <- read.table("./AR_2.5.csv", sep = separator, header = TRUE)
# Cross check of number of trips between MED&BS catch table and AR Table 2.5
res <- check_n_trips_MEDBS_AR(MEDBS=Catch, AR=AR_2.5, MS, year, OUT=local_save, verbose = TRUE)
