setwd("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\script per tabella\\dataset")

task_ii2= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_dcrf_task_ii2_catch.csv",sep=";",header=T)
save(task_ii2, file="data/task_ii2.rda",compress="xz")

task_iii= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_dcrf_task_iii_incidental_catch.csv",sep=";",header=T)
save(task_iii, file="data/task_iii.rda",compress="xz")

task_vii2= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_dcrf_task_vii2_length_data.csv",sep=";",header=T)
save(task_vii2, file="data/task_vii2.rda",compress="xz")

task_vii31= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_dcrf_task_vii31_size_1st_matur.csv",sep=";",header=T)
save(task_vii31, file="data/task_vii31.rda",compress="xz")

task_vii32= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_dcrf_task_vii32_maturity_data.csv",sep=";",header=T)
save(task_vii32, file="data/task_vii32.rda",compress="xz")

fdi_g_effort= read.table("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\script per tabella\\dataset\\dc_fdi_g_effort.csv",sep=";",header=T)
save(fdi_g_effort, file="fdi_g_effort.rda",compress="xz")

fdi_j_capacity= read.table("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\script per tabella\\dataset\\dc_fdi_j_capacity.csv",sep=";",header=T)
save(fdi_j_capacity, file="fdi_j_capacity.rda",compress="xz")

fdi_h_spatial_land= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_fdi_h_spatial_land.csv",sep=";",header=T)
save(fdi_h_spatial_land, file="data/fdi_h_spatial_land.rda",compress="xz")

fdi_i_spatial_fe= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\dc_fdi_i_spatial_fe.csv",sep=";",header=T)
save(fdi_i_spatial_fe, file="data/fdi_i_spatial_fe.rda",compress="xz")


########## TABELLE AGGIUNTIVE PER CONTROLLI

combination_taskII2= read.table("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\script per tabella\\dataset\\combination_taskII.2.csv",sep=";",header=T)
save(combination_taskII2, file="combination_taskII2.rda",compress="xz")

catfau_check= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\catfau_check.csv",sep=";",header=T)
save(catfau_check, file="data/catfau_check.rda",compress="xz")

sex_mat= read.table("D:\\Documents and Settings\\Utente\\Documenti\\GitHub\\RDBqc\\script per tabella\\dataset\\sex_mat.csv",sep=";",header=T)
save(sex_mat, file="data/sex_mat.rda",compress="xz")

minmaxLtaskVII2= read.table("C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\script per tabella\\dataset\\minmax-L-taskVII.2.csv",sep=";",header=T)
save(minmaxLtaskVII2, file="minmax-L-taskVII2.rda",compress="xz")



