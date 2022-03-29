pkgname <- "RDBqc"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('RDBqc')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("Catch_coverage")
### * Catch_coverage

flush(stderr()); flush(stdout())

### Name: Catch_coverage
### Title: Catch_cov: function to check the coverage in Catch table
### Aliases: Catch_coverage

### ** Examples

Catch_coverage(Catch_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("Discard_coverage")
### * Discard_coverage

flush(stderr()); flush(stdout())

### Name: Discard_coverage
### Title: Discard_cov: function to check the coverage in Discard table
### Aliases: Discard_coverage

### ** Examples

Discard_coverage(Discard_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("Duplicated_GFCM_II2")
### * Duplicated_GFCM_II2

flush(stderr()); flush(stdout())

### Name: Duplicated_GFCM_II2
### Title: Check duplicated records in GFCM Task II.2 table
### Aliases: Duplicated_GFCM_II2

### ** Examples

Duplicated_GFCM_II2(task_ii2)



cleanEx()
nameEx("GP_check")
### * GP_check

flush(stderr()); flush(stdout())

### Name: GP_check
### Title: GP_tab (growth params) table check
### Aliases: GP_check

### ** Examples

GP_check(GP_tab_example,"MUT","ITA","SA 18")



cleanEx()
nameEx("LW_check_MED_BS")
### * LW_check_MED_BS

flush(stderr()); flush(stdout())

### Name: LW_check_MED_BS
### Title: LW params in GP_tab (sex ratio at length) table check#'
### Aliases: LW_check_MED_BS

### ** Examples

LW_check_MED_BS(GP_tab_example,"MUT","ITA","SA 18")



cleanEx()
nameEx("Landing_coverage")
### * Landing_coverage

flush(stderr()); flush(stdout())

### Name: Landing_coverage
### Title: Landing_cov: function to check the coverage in Landing table
### Aliases: Landing_coverage

### ** Examples

Landing_coverage(Landing_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("MA_tab_check")
### * MA_tab_check

flush(stderr()); flush(stdout())

### Name: MA_tab_check
### Title: MA_tab (maturity at age) table check
### Aliases: MA_tab_check

### ** Examples

MA_tab_check(MA_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("ML_tab_check")
### * ML_tab_check

flush(stderr()); flush(stdout())

### Name: ML_tab_check
### Title: ML_tab (maturity at length) table check
### Aliases: ML_tab_check

### ** Examples

ML_tab_check(ML_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("SA_tab_check")
### * SA_tab_check

flush(stderr()); flush(stdout())

### Name: SA_tab_check
### Title: SA_tab (sex ratio at age) table check
### Aliases: SA_tab_check

### ** Examples

SA_tab_check(SA_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("SL_tab_check")
### * SL_tab_check

flush(stderr()); flush(stdout())

### Name: SL_tab_check
### Title: SL_tab (sex ratio at length) table check
### Aliases: SL_tab_check

### ** Examples

SL_tab_check(SL_tab_example,"DPS","ITA","9")



cleanEx()
nameEx("check_AL")
### * check_AL

flush(stderr()); flush(stdout())

### Name: check_AL
### Title: Check consistency of age-length relationship
### Aliases: check_AL

### ** Examples

check_AL(data_ex,min_age=0,max_age=30)



cleanEx()
nameEx("check_CL")
### * check_CL

flush(stderr()); flush(stdout())

### Name: check_CL
### Title: Quality checks on CL RCG table
### Aliases: check_CL

### ** Examples

check_CL(data_exampleCL)



cleanEx()
nameEx("check_LFD")
### * check_LFD

flush(stderr()); flush(stdout())

### Name: check_LFD
### Title: check LFD
### Aliases: check_LFD

### ** Examples

check_LFD(data_ex,min_len=1,max_len=35)



cleanEx()
nameEx("check_LFD_comm_cat")
### * check_LFD_comm_cat

flush(stderr()); flush(stdout())

### Name: check_LFD_comm_cat
### Title: Check consistency of LFD by year and commercial category
### Aliases: check_LFD_comm_cat

### ** Examples

check_LFD_comm_cat(data_ex)



cleanEx()
nameEx("check_loc")
### * check_loc

flush(stderr()); flush(stdout())

### Name: check_loc
### Title: Check trip location
### Aliases: check_loc

### ** Examples

check_loc(data_ex)



cleanEx()
nameEx("check_lw")
### * check_lw

flush(stderr()); flush(stdout())

### Name: check_lw
### Title: Consistency of length-weight relationship and consistency with
###   allowed ranges
### Aliases: check_lw

### ** Examples

check_lw(data_ex,Min=0,Max=1000)



cleanEx()
nameEx("check_mat")
### * check_mat

flush(stderr()); flush(stdout())

### Name: check_mat
### Title: Check consistency sex and maturity stage
### Aliases: check_mat

### ** Examples

check_mat(data_ex,immature_stages=c("0","1","2a"))



cleanEx()
nameEx("summarize_ind_meas")
### * summarize_ind_meas

flush(stderr()); flush(stdout())

### Name: summarize_ind_meas
### Title: Number of individual by trip for which biological data have been
###   collected (length, sex, maturity, weight and age)
### Aliases: summarize_ind_meas

### ** Examples

summarize_ind_meas(data_ex)



cleanEx()
nameEx("summarize_trips")
### * summarize_trips

flush(stderr()); flush(stdout())

### Name: summarize_trips
### Title: summarizing the number of trips/hauls monitored by year by port,
###   metier, sampling method;
### Aliases: summarize_trips

### ** Examples

summarize_trips(data_ex)



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
