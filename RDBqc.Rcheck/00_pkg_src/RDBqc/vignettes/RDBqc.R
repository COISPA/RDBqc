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

