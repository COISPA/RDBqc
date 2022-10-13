

SOP_threshold <- 5
Rt <- 1

Catch = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\catch.csv", sep=";",header=TRUE) # Catch_tab_example


# Catch <- rbind(Catch,Catch[1,])
Land = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\landings.csv", sep=",",header=TRUE)
# Land <- rbind(Land,Land[199566,])
Disc = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\discards.csv", sep=",",header=TRUE) # Discard_tab_example
ML = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\ml.csv", sep=",",header=TRUE) # ML_tab_example
MA = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\ma.csv", sep=",",header=TRUE) # MA_tab_example
SL = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\srl.csv", sep=",",header=TRUE) # SL_tab_example
SA = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\sra.csv", sep=",",header=TRUE) # SA_tab_example
GP = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\gp.csv", sep=",",header=TRUE) # GP_tab_example
ALK = read.table("D:\\OneDrive - Coispa Tecnologia & Ricerca S.C.A.R.L\\RDB\\RDBqc\\testfiles\\alk.csv", sep=",",header=TRUE) # ALK_tab_example

SPs <- c("HKE")
MS <- "ITA"
GSAs <- c("GSA 18","GSA 19")

