
library(roxygen2)
roxygenise()
GP_tab_example=read.table("C:\\RDBqc\\GP_MUT18.csv",sep=";",header=T)
save(GP_tab_example,file="data/GP_tab_example.rda",compress="xz")
