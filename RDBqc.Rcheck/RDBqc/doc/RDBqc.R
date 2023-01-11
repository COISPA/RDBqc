## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(RDBqc)

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(RDBqc)

## ----input1-------------------------------------------------------------------
head(data_ex)

## ----input2-------------------------------------------------------------------
head(data_exampleCL)

## ----RCG_check_LFD------------------------------------------------------------
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[1]]

## ----RCG_check_LFD2,fig.height=6,fig.width=9----------------------------------
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[2]]

## ----RCG_check_LFD_comm_cat---------------------------------------------------
RCG_check_LFD_comm_cat(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus")[[1]]

## ----RCG_check_LFD_comm_cat2,fig.height=6,fig.width=9-------------------------
RCG_check_LFD_comm_cat(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus")[[2]]

## ----RCG_check_AL-------------------------------------------------------------
results <- RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[1]]
head(results)

## ----RCG_check_AL2------------------------------------------------------------
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[2]]

## ----RCG_check_AL3,fig.height=6,fig.width=9-----------------------------------
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[3]]

## ----RCG_check_lw2,fig.height=6,fig.width=9-----------------------------------
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=200)[[2]]

## ----RCG_check_lw1------------------------------------------------------------
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=200)[[1]]

## ----RCG_check_mat, results='hide', message=FALSE, warning=FALSE,fig.height=6,fig.width=9----
RCG_check_mat(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")

## ----RCG_check_mat_ogive,fig.height=6,fig.width=9-----------------------------
RCG_check_mat_ogive(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus", sex="F",immature_stages=c("0","1","2a"))

## ----RCG_summarize_ind_meas---------------------------------------------------
results <- RCG_summarize_ind_meas(data=data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)

## ----RCG_summarize_trips------------------------------------------------------
results <- RCG_summarize_trips(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)

## ----RCG_check_loc,fig.height=8,fig.width=10----------------------------------
RCG_check_loc(data_ex)

## ----RCG_check_CL1------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[1]]

## ----RCG_check_CL2------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[2]]

## ----RCG_check_CL3------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[3]]

## ----RCG_check_CL4------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[4]]

## ----RCG_check_CL5------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[5]]

## ----RCG_check_CL6------------------------------------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[6]]

## ----RCG_check_CL7,fig.height=6,fig.width=9-----------------------------------
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[7]]

## ----Catch_tab_example--------------------------------------------------------
head(Catch_tab_example)

## ----Landing_tab_example------------------------------------------------------
head(Landing_tab_example)

## ----Discard_tab_example------------------------------------------------------
head(Discard_tab_example)

## ----MEDBS_check_duplicates_catches-------------------------------------------
catch_with_diplicate <- rbind(Catch_tab_example,Catch_tab_example[1,])
MEDBS_check_duplicates(data=catch_with_diplicate,type="c",MS="ITA",GSA="GSA 9",SP="DPS",verbose=TRUE)

## ----MEDBS_Catch_coverage1----------------------------------------------------
results <- suppressMessages(MEDBS_Catch_coverage(Catch_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])

## ----MEDBS_Catch_coverage2----------------------------------------------------
head(results[[2]])

## ----MEDBS_Catch_coverage3,fig.height=6,fig.width=9---------------------------
results[[3]]

## ----MEDBS_Catch_coverage4,fig.height=6,fig.width=9---------------------------
results[[4]]

## -----------------------------------------------------------------------------
MEDBS_SOP(data=Catch_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",threshold = 5)

## -----------------------------------------------------------------------------
MEDBS_SOP(data=Catch_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",threshold = 2)

## ----MEDBS_check_duplicates_landings------------------------------------------
Landing_tab_example <- rbind(Landing_tab_example,Landing_tab_example[1,])
MEDBS_check_duplicates(data=Landing_tab_example,type="l",MS="ITA",GSA="GSA 9",SP="DPS",verbose=TRUE)

## ----MEDBS_check_duplicates_discards------------------------------------------
Discard_tab_example <- rbind(Discard_tab_example,Discard_tab_example[1,])
MEDBS_check_duplicates(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)

## ----MEDBS_ks_landing1,fig.height=10,fig.width=10-----------------------------
ks <- MEDBS_ks(data=Landing_tab_example, type="l", SP="DPS",MS="ITA",GSA="GSA 9",Rt=1)
results <- ks[[1]]
head(results)

## ----MEDBS_ks_landing2,fig.height=10,fig.width=10-----------------------------
# plot(ks[[3]])

## ----MEDBS_length_ind_tab-----------------------------------------------------
results <- MEDBS_length_ind(Discard_tab_example,type="d",SP="DPS",MS=c("ITA"),GSA=c("GSA 9"), splines=c(0.2,0.4,0.6,0.8),Xtresholds = c(0.25,0.5,0.75))
head(results[[1]])

## ----MEDBS_length_ind_plot1,fig.height=6,fig.width=9--------------------------
results[[2]]

## ----MEDBS_length_ind_plot2,fig.height=6,fig.width=9--------------------------
results[[3]]

## ----MEDBS_lengthclass_0------------------------------------------------------
results <- MEDBS_lengthclass_0(data=Landing_tab_example,type="l",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
head(results)

## ----MEDBS_weight_0-----------------------------------------------------------
MEDBS_weight_0(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9", verbose=TRUE)

## ----MEDBS_weight_minus1------------------------------------------------------
MEDBS_weight_minus1(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)

## ----MEDBS_yr_missing_length--------------------------------------------------
results <- MEDBS_yr_missing_length(data=Landing_tab_example,type="l",SP="DPS",MS="ITA",GSA="GSA 9")
head(results)

## ----MEDBS_comp_land_Q_VL-----------------------------------------------------
results <- suppressMessages(MEDBS_comp_land_Q_VL(data = Landing_tab_example, 
           SP = "DPS", MS = "ITA", GSA = "GSA 9"))
head(results)

## ----MEDBS_comp_land_Q_VL_fishery---------------------------------------------
results <- suppressMessages(MEDBS_comp_land_Q_VL_fishery(data = Landing_tab_example, 
        MS = "ITA", GSA = "GSA 9", SP = "DPS"))
head(results)

## ----MEDBS_comp_land_YQ-------------------------------------------------------
MEDBS_comp_land_YQ(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")

## ----MEDBS_comp_land_YQ_fishery-----------------------------------------------
results <- suppressMessages(MEDBS_comp_land_YQ_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9"))
head(results)

## ----MEDBS_land_mean_weight---------------------------------------------------
results <- MEDBS_land_mean_weight(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")[[1]]
head(results)

## ----MEDBS_land_mean_weight2,fig.height=6,fig.width=9-------------------------
MEDBS_land_mean_weight(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")[[2]]

## ----MEDBS_plot_land_vol,fig.height=6,fig.width=9-----------------------------
MEDBS_plot_land_vol(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")

## ----MEDBS_plot_landing_ts,fig.height=6,fig.width=9---------------------------
suppressMessages(MEDBS_plot_landing_ts(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",by="quarter"))

## ----MEDBS_Landing_coverage---------------------------------------------------
results <- suppressMessages(MEDBS_Landing_coverage(Landing_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])

## ----MEDBS_Landing_coverage2,fig.height=6,fig.width=9-------------------------
results[[2]]

## ----MEDBS_discard_coverage1--------------------------------------------------
results <- suppressMessages(MEDBS_discard_coverage(Discard_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])

## ----MEDBS_discard_coverage2,fig.height=6,fig.width=9-------------------------
results[[2]]

## ----MEDBS_comp_disc_YQ-------------------------------------------------------
MEDBS_comp_disc_YQ(data=Discard_tab_example,MS="ITA",GSA="GSA 9",SP="DPS")

## ----MEDBS_comp_disc_YQ_fishery-----------------------------------------------
results <- MEDBS_comp_disc_YQ_fishery(data=Discard_tab_example,MS="ITA",GSA="GSA 9",SP="DPS")
head(results)

## ----MEDBS_disc_mean_weight1--------------------------------------------------
results <- MEDBS_disc_mean_weight(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
head(results[[1]])

## ----MEDBS_disc_mean_weight2,fig.height=8,fig.width=10------------------------
results[[2]]

## ----MEDBS_plot_disc_vol,fig.height=6,fig.width=8-----------------------------
MEDBS_plot_disc_vol(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")

## ----MEDBS_plot_discard_ts,fig.height=6,fig.width=9---------------------------
MEDBS_plot_discard_ts(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",by="quarter")

## ----GP_check1----------------------------------------------------------------
results <- MEDBS_GP_check(GP_tab_example,"MUT","ITA","GSA 18")
results[[1]]
print(names(results)[1])

## ----GP_check2,fig.height=6,fig.width=9---------------------------------------
print(names(results)[2])
results[[2]]

## ----GP_check3,fig.height=6,fig.width=9---------------------------------------
print(names(results)[3])
results[[3]]

## ----GP_check4,fig.height=6,fig.width=9---------------------------------------
print(names(results)[4])
results[[4]]

## ----GP_check,fig.height=6,fig.width=9----------------------------------------
print(names(results)[5])
results[[5]]

## ----GP_check6,fig.height=6,fig.width=9---------------------------------------
print(names(results)[6])
results[[6]]

## ----GP_check7,fig.height=6,fig.width=9---------------------------------------
print(names(results)[7])
results[[7]]

## ----GP_check8,fig.height=6,fig.width=9---------------------------------------
print(names(results)[8])
results[[8]]

## ----MEDBS_LW_check1----------------------------------------------------------
results <- MEDBS_LW_check(GP_tab_example,"MUT","ITA","GSA 18")
results[[1]]

## ----MEDBS_LW_check2,fig.height=6,fig.width=9---------------------------------
results[[2]]
results[[3]]
results[[4]]
results[[5]]
results[[6]]
results[[7]]
results[[8]]

## ----MEDBS_MA_check1----------------------------------------------------------
results <- MEDBS_MA_check(MA_tab_example,"DPS","ITA","GSA 99")
results[[1]]

## ----MEDBS_MA_check2,fig.height=6,fig.width=9---------------------------------
results[[2]]
results[[3]]

## ----MEDBS_ML_check1,fig.height=6,fig.width=9---------------------------------
results <- MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "GSA 99")
results[[1]]

## ----MEDBS_ML_check2,fig.height=6,fig.width=9---------------------------------
results[[2]]

## ----MEDBS_SA_check1----------------------------------------------------------
results <- MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "GSA 99")
results[[1]]

## ----MEDBS_SA_check2,fig.height=6,fig.width=9---------------------------------
results[[2]]
results[[3]]

## ----MEDBS_SL_check1----------------------------------------------------------
results <- MEDBS_SL_check(SL_tab_example,"DPS","ITA","GSA 99")
results[[1]]

## ----MEDBS_SL_check2,fig.height=6,fig.width=9---------------------------------
results[[2]]
results[[3]]

## ----check_EF_FDI_A1----------------------------------------------------------
check_EF_FDI_A(fdi_a_catch, verbose=FALSE)[[1]]

## ----check_EF_FDI_A2----------------------------------------------------------
check_EF_FDI_A(fdi_a_catch, verbose=FALSE)[[2]]

## ----check_RD_FDI_A-----------------------------------------------------------
check_RD_FDI_A(fdi_a_catch)

## ----FDI_coverage_table_A-----------------------------------------------------
FDI_coverage(data=fdi_a_catch, MS="PSP", verbose = FALSE)

## ----FDI_disc_coverage_table_A------------------------------------------------
FDI_disc_coverage(fdi_a_catch, MS="PSP",GSA="GSA99",SP="HKE", verbose=TRUE)

## ----FDI_cov_tableA_1---------------------------------------------------------
head(FDI_cov_tableA(data=fdi_a_catch, SP="MUT", MS="PSP",fishtech=unique(fdi_a_catch$fishing_tech), GSA="GSA99")[[1]])

## ----FDI_cov_tableA_2---------------------------------------------------------
head(FDI_cov_tableA(data=fdi_a_catch, SP="MUT", MS="PSP",fishtech=unique(fdi_a_catch$fishing_tech), GSA="GSA99")[[2]])

## ----FDI_cov_tableA_3---------------------------------------------------------
FDI_cov_tableA(data=fdi_a_catch, SP="MUT", MS="PSP",fishtech=unique(fdi_a_catch$fishing_tech), GSA="GSA99")[[3]]
FDI_cov_tableA(data=fdi_a_catch, SP="MUT", MS="PSP",fishtech=unique(fdi_a_catch$fishing_tech), GSA="GSA99")[[4]]
FDI_cov_tableA(data=fdi_a_catch, SP="MUT", MS="PSP",fishtech=unique(fdi_a_catch$fishing_tech), GSA="GSA99")[[5]]

## ----FDI_prices_not_null_1----------------------------------------------------
FDI_prices_not_null(data = fdi_a_catch, MS = "PSP", GSA = "GSA99",SP = c("HKE"), verbose = FALSE)[[1]]

## ----FDI_prices_not_null_2----------------------------------------------------
FDI_prices_not_null(data = fdi_a_catch, MS = "PSP", GSA = "GSA99",SP = c("HKE"), verbose = TRUE)[[2]]

## ----FDI_prices_cov_1---------------------------------------------------------
FDI_prices_cov(data = fdi_a_catch, SP = c("HKE"), MS = "PSP", GSA = "GSA99",verbose=FALSE)[[1]]

## ----FDI_prices_cov_2---------------------------------------------------------
FDI_prices_cov(data = fdi_a_catch, SP = c("HKE"), MS = "PSP", GSA = "GSA99",verbose=FALSE)[[2]]

## ----check_EF_FDI_G1----------------------------------------------------------
check_EF_FDI_G(fdi_g_effort, verbose=FALSE)[[1]]

## ----check_EF_FDI_G2----------------------------------------------------------
check_EF_FDI_G(fdi_g_effort, verbose=FALSE)[[2]]

## ----check_RD_FDI_G-----------------------------------------------------------
head(check_RD_FDI_G(fdi_g_effort))

## ----FDI_coverage_table_G-----------------------------------------------------
FDI_coverage(data=fdi_g_effort,MS="PSP", verbose = FALSE)

## ----FDI_cov_tableG_1---------------------------------------------------------
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[1]]

## ----FDI_cov_tableG_2---------------------------------------------------------
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[2]]

## ----FDI_cov_tableG_3---------------------------------------------------------
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[3]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[4]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[5]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[6]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[7]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[8]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[9]]
FDI_cov_tableG(data=fdi_g_effort, MS="PSP", GSA="GSA99")[[10]]

## ----check_EF_FDI_H1----------------------------------------------------------
check_EF_FDI_H(fdi_h_spatial_landings, verbose=FALSE)[[1]]

## ----check_EF_FDI_H2----------------------------------------------------------
check_EF_FDI_H(fdi_h_spatial_landings, verbose=FALSE)[[2]]

## ----check_RD_FDI_H-----------------------------------------------------------
h_spatial_land <- rbind(fdi_h_spatial_landings,fdi_h_spatial_landings[1,])
check_RD_FDI_H(h_spatial_land)

## ----FDI_coverage_table_H-----------------------------------------------------
FDI_coverage(data=fdi_h_spatial_landings ,MS="PSP", verbose = FALSE)

## ----FDI_checks_spatial_HI_1--------------------------------------------------
head(FDI_checks_spatial_HI(data=fdi_h_spatial_landings,MS="PSP", verbose=TRUE)[[1]])

## ----FDI_checks_spatial_HI_2--------------------------------------------------
FDI_checks_spatial_HI(data=fdi_h_spatial_landings,MS="PSP", verbose=FALSE)[[2]]

## ----FDI_check_coord_1--------------------------------------------------------
FDI_check_coord(data=fdi_i_spatial_effort, MS="PSP",verbose=TRUE)

## ----check_EF_FDI_I1----------------------------------------------------------
check_EF_FDI_I(fdi_i_spatial_effort,verbose=FALSE)[[1]]

## ----check_EF_FDI_I2----------------------------------------------------------
check_EF_FDI_I(fdi_i_spatial_effort,verbose=FALSE)[[2]]

## ----check_RD_FDI_I-----------------------------------------------------------
i_spatial_fe <- rbind(fdi_i_spatial_effort,fdi_i_spatial_effort[1,])
head(check_RD_FDI_I(i_spatial_fe))

## ----FDI_coverage_table_I-----------------------------------------------------
FDI_coverage(data=fdi_i_spatial_effort ,MS="PSP", verbose = FALSE)

## ----FDI_checks_spatial_HI_3--------------------------------------------------
head(FDI_checks_spatial_HI(data=fdi_i_spatial_effort,MS="PSP", verbose=TRUE)[[1]])

## ----FDI_checks_spatial_HI_4--------------------------------------------------
FDI_checks_spatial_HI(data=fdi_i_spatial_effort,MS="PSP", verbose=FALSE)[[2]]

## ----FDI_check_coord_2--------------------------------------------------------
FDI_check_coord(data=fdi_i_spatial_effort, MS="PSP",verbose=TRUE)

## ----check_EF_FDI_J1----------------------------------------------------------
check_EF_FDI_J(fdi_j_capacity, verbose=FALSE)[[1]]

## ----check_EF_FDI_J2----------------------------------------------------------
check_EF_FDI_J(fdi_j_capacity, verbose=FALSE)[[2]]

## ----check_RD_FDI_J-----------------------------------------------------------
j_capacity <- rbind(fdi_j_capacity,fdi_j_capacity[1,])
head(check_RD_FDI_J(j_capacity))

## ----FDI_coverage_table_J-----------------------------------------------------
FDI_coverage(data=fdi_j_capacity ,MS="PSP", verbose = FALSE)

## ----FDI_vessel_lenth_1-------------------------------------------------------
head(FDI_vessel_lenth(data=fdi_j_capacity, MS="PSP", verbose = TRUE)[[1]])

## ----FDI_vessel_lenth_2-------------------------------------------------------
head(FDI_vessel_lenth(data=fdi_j_capacity, MS="PSP", verbose = TRUE)[[2]])

## ----FDI_cov_tableJ_1---------------------------------------------------------
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=TRUE)[[1]]

## ----FDI_cov_tableJ_2---------------------------------------------------------
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=FALSE)[[2]]

## ----FDI_cov_tableJ_3---------------------------------------------------------
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=FALSE)[[3]]
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=FALSE)[[4]]
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=FALSE)[[5]]
FDI_cov_tableJ(data=fdi_j_capacity, MS="PSP", GSA="GSA99", verbose=FALSE)[[6]]

## ----FDI_fishdays_cov---------------------------------------------------------
FDI_fishdays_cov (dataG=fdi_g_effort, dataI=fdi_i_spatial_effort, MS="PSP", verbose = TRUE)

## ----FDI_landweight_cov-------------------------------------------------------
FDI_landweight_cov(dataA=fdi_a_catch, dataH=fdi_h_spatial_landings, MS="PSP", verbose = TRUE)

## -----------------------------------------------------------------------------
FDI_vessel_numbers(dataJ=fdi_j_capacity, dataG=fdi_g_effort, MS="PSP", verbose = TRUE)

## ----FDI_cross_checks_AG------------------------------------------------------
head(FDI_cross_checks_AG(data1=fdi_a_catch, data2=fdi_g_effort))

## ----FDI_cross_checks_AH_1----------------------------------------------------
FDI_cross_checks_AH(data1 = fdi_a_catch, data2 = fdi_h_spatial_landings,verbose=TRUE)[[1]]

## ----FDI_cross_checks_AH_2----------------------------------------------------
FDI_cross_checks_AH(data1 = fdi_a_catch, data2 = fdi_h_spatial_landings)[[2]]

## ----FDI_cross_checks_IG_1----------------------------------------------------
FDI_cross_checks_IG(data1=fdi_i_spatial_effort, data2=fdi_g_effort)[[1]]

## ----FDI_cross_checks_IG_2----------------------------------------------------
FDI_cross_checks_IG(data1=fdi_i_spatial_effort, data2=fdi_g_effort)[[2]]

## ----FDI_cross_checks_JG------------------------------------------------------
FDI_cross_checks_JG(data1=fdi_j_capacity, data2=fdi_g_effort,verbose=TRUE)

## ----check_EF_taskII2_1-------------------------------------------------------
check_EF_taskII2(task_ii2, verbose=FALSE)[[1]]

## ----check_EF_taskII2_2-------------------------------------------------------
check_EF_taskII2(task_ii2, verbose=FALSE)[[2]]

## ----check_presence_taskII2---------------------------------------------------
check_presence_taskII2(task_ii2,combination_taskII2,MS="ITA",GSA="18")

## ----check_RD_taskII2---------------------------------------------------------
ii2 <- rbind(task_ii2,task_ii2[1,])
check_RD_taskII2(ii2)

## ----check_EF_taskIII1--------------------------------------------------------
check_EF_taskIII(task_iii,verbose=FALSE)[[1]]

## ----check_EF_taskIII2--------------------------------------------------------
check_EF_taskIII(task_iii,verbose=FALSE)[[2]]

## ----check_RD_taskIII---------------------------------------------------------
check_RD_taskIII(task_iii)

## ----check_EF_taskVII2_1------------------------------------------------------
check_EF_taskVII2(task_vii2, verbose=FALSE)[[1]]

## ----check_EF_taskVII2_2------------------------------------------------------
check_EF_taskVII2(task_vii2, verbose=FALSE)[[2]]

## ----check_RD_taskVII2--------------------------------------------------------
check_RD_taskVII2(task_vii2)

## ----check_minmaxl_TaskVII.2--------------------------------------------------
check_minmaxl_TaskVII.2(task_vii2,minmaxLtaskVII2,MS="ITA",GSA="18")

## ----check_lw_TaskVII.2,fig.height=6,fig.width=9------------------------------
check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")

## ----check_EF_TaskVII31_1-----------------------------------------------------
check_EF_TaskVII31(task_vii31, verbose=FALSE)[[1]]

## ----check_EF_TaskVII31_2-----------------------------------------------------
check_EF_TaskVII31(task_vii31, verbose=FALSE)[[2]]

## ----check_minmaxl50_TaskVII.3.1----------------------------------------------
check_minmaxl50_TaskVII.3.1(task_vii31,minmaxLtaskVII31,MS="ITA",GSA="19")

## ----check_RD_taskVII31-------------------------------------------------------
check_RD_taskVII31(task_vii31)

## ----check_EF_TaskVII32_1-----------------------------------------------------
check_EF_TaskVII32(task_vii32, verbose=FALSE)[[1]]

## ----check_EF_TaskVII32_2-----------------------------------------------------
check_EF_TaskVII32(task_vii32, verbose=FALSE)[[2]]

## -----------------------------------------------------------------------------
check_RD_TaskVII32(task_vii32)

## ----check_species_catfau_TaskVII.3.2_1---------------------------------------
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18",SP="CTC")[[1]]

## ----check_species_catfau_TaskVII.3.2_2---------------------------------------
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18",SP="CTC")[[2]]

## ----check_lmat_TaskVII.3.2,fig.height=6,fig.width=9--------------------------
check_lmat_TaskVII.3.2(task_vii32, MS="ITA",GSA="18",SP="CTC")

