
library(roxygen2)
roxygenise()
SA_tab_example=read.table("C:\\Users\\Bitetto Isabella\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB Anneex 4a\\from STREAM\\scripts from github\\STREAM_MARE-2016-22-Task-6.1-A-posteriori-checks\\SRA_DPS9.csv",sep=",",header=T)
save(SA_tab_example,file="data/SA_tab_example.rda",compress="xz")
