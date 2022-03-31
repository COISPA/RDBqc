#' Check mismatching species/Catfau and Sex per maturity stages for Task VII.3.2 table
#'
#' @param data GFCM Task VII.3.2 table
#' @param species Combination of SPECIES X CATFAU for Task VII.3.2 table
#' @param matsex Combination of Sex X maturity stages for Task VII.3.2 table
#'
#' @return List of mismatching combination Specie/CATFAU
#' @return List of mismatching combination Sex/maturity
#' @export
#'
#' @examples check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat)
#'
#' #Clean the global environment of R




check_species_catfau_TaskVII.3.2 <- function(data,species,matsex){

#Control 1 - Scientific name X CATFAU
data$CATFAU_REV=substr(data$Maturity, 1, 3)
#Dataframe 1 - Concatenation species/CATFAU_rev
data$ID=paste(data$Species,data$CATFAU_REV)
data$ID=as.character(data$ID)

#Dataframe 2 - Concatenation species/CATFAU_rev
species$ID=paste(species$Species,species$CATFAU_REV)
species$ID=as.character(species$ID)

#Creation of data frame mixing the information from the two dataframes
level_fac_dat1=data.frame(ID=unique(data$ID),observed=unique(data$ID))
level_fac_dat2=data.frame(ID=unique(species$ID),expected=unique(species$ID))
m <- merge(level_fac_dat2,level_fac_dat1,all=TRUE)
# data_merge1=data.frame(level_fac_dat1,level_fac_dat2)
  unexpected_codes_Species_catfau <- m$ID[which(is.na(m$expected))]

#Control 2 - Maturity X Sex
  #Dataframe 1 - Concatenation species/CATFAU_rev
  data$ID2=paste(data$Maturity,data$Sex)
  data$ID2=as.character(data$ID2)

  #Dataframe 2 - Concatenation species/CATFAU_rev
  #Creation of ID for dataframe 2
  df <- data.frame(matrix(ncol=1,nrow=0))
  colnames(df)="codes"
  for (i in 1:length(matsex$maturity)) {

    for (n in 2:ncol(matsex)) {
         if (matsex[i,n]=="Yes"){
           if(n==2) {sex="F"}
           if(n==3) {sex="M"}
           if(n==4) {sex="U"}
           if(n==5) {sex="ND"}
             combine=paste(matsex$maturity[i],sex)
             df <- rbind(df,combine)
          }
    }

  }
  colnames(df)="ID2"

  #Creation of data frame mixing the information from the two dataframes
  level_fac_dat1_2=data.frame(ID=unique(data$ID2),observed=unique(data$ID2))
  level_fac_dat2_2=data.frame(ID=unique(df$ID2),expected=unique(df$ID2))

  m2 <- merge(level_fac_dat2_2,level_fac_dat1_2,all=TRUE)

  # data_merge1=data.frame(level_fac_dat1,level_fac_dat2)
  unexpected_codes_matsex <- m2$ID[which(is.na(m2$expected))]


  return(list(unexpected_codes_Species_catfau,unexpected_codes_matsex))
}


