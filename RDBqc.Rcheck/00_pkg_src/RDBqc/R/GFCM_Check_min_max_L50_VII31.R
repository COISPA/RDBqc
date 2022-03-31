#'  Comparison between min/max L50 observed for each species and sex with theoretical values
#'
#' @param data1 GFCM Task VII.3.1 table
#' @param data2 Theoretical values of min/max L50 for each species and sex
#'
#' @return Table for comparison between min/max L50 observed for each species and sex with theoretical values
#' @export
#'
#' @examples check_minmaxl50_TaskVII.3.1(task_vii31,minmaxLtaskVII31)


check_minmaxl50_TaskVII.3.1 <- function(data1,data2){

#Creation of Pivot for calculation of min/max depending of species
data1$SpeciesXSex=paste(data1$Species,data1$Sex)
pivot_min=with(data1,tapply(L50,SpeciesXSex,min))
#pivot_min #pivot min
pivot_max=with(data1,tapply(L50,SpeciesXSex,max))
#pivot_max #pivot max

#Creation of the final data frame
Check_species_min=as.data.frame(pivot_min)
Check_species_max=as.data.frame(pivot_max)
Check_species_final=Check_species_min
Check_species_final$pivot_max=Check_species_max$pivot_max
names(Check_species_final)=c("min","max")
Check_species_final$SpeciesXSex=as.factor(names(pivot_min))
#str(Check_species_final)
#Creation of colum for merging and merging
data2$SpeciesXSex=paste(data2$Species,data2$Sex)
data_merge=merge(Check_species_final, data2, by = "SpeciesXSex")
#str(data_merge)

#Creation of dataframe
dataframe_check=data.frame(data_merge$Species,data_merge$Sex,
                           data_merge$min,data_merge$max,data_merge$minL50,data_merge$maxL50)
names(dataframe_check)=c("Species","Sex","min_observed","max_observed","min_theoretical","max_theoretical")
#str(dataframe_check)

#Creation of warning for min
for (i in 1:length(dataframe_check$min_observed))
  if (dataframe_check$min_theoretical[i]>=dataframe_check$min_observed[i]){
    dataframe_check$check_min[i]="Warning"
  }else {

    dataframe_check$check_min[i]=""
  }

#Creation of warning for max
for (i in 1:length(dataframe_check$max_observed))
  if (dataframe_check$max_theoretical[i]<=dataframe_check$max_observed[i]){
    dataframe_check$check_max[i]="Warning"
  }else {

    dataframe_check$check_max[i]=""
  }

#Extraction of data in excell file
# write.table(dataframe_check, file="C:\\Users\\Loredana Casciaro\\Desktop\\controlli GFCM-FDI\\TEST SA\\checkminmaxL50.csv", quote=TRUE,
#             dec=".", row.names=FALSE, col.names=TRUE, sep =";")

return(dataframe_check)
}



