
#' Quality checks on CL RCG table
#'
#' @param data_exampleCL Landing table in RCG CL format
#'
#' @return Checks_CL list of tables for temporal, spatial, species and metier coverage
#' @export
#'
#' @examples check_CL(data_exampleCL)
#' @importFrom utils globalVariables
#' @importFrom ggplot2 aes ggplot geom_line geom_point facet_grid
#' @importFrom stats aggregate
check_CL <- function(data_exampleCL) {

    Year <- Sum_Landings<-Species<-NULL
temp_covL=aggregate(data_exampleCL$landWt,by=list(data_exampleCL$year,data_exampleCL$quarter,data_exampleCL$month),FUN="sum")
colnames(temp_covL)=c("Year","Quarter","Month","Sum_Landings")
temp_covLV=aggregate(data_exampleCL$landValue,by=list(data_exampleCL$year,data_exampleCL$quarter,data_exampleCL$month),FUN="sum")
colnames(temp_covLV)=c("Year","Quarter","Month","Sum_LandingsValue")

if(length(which(is.na(data_exampleCL$landCtry)))>0) data_exampleCL[which(is.na(data_exampleCL$landCtry)),]$landCtry<-999
if(length(which(is.na(data_exampleCL$vslFlgCtry)))>0) data_exampleCL[which(is.na(data_exampleCL$vslFlgCtry)),]$vslFlgCtry<-999
if(length(which(is.na(data_exampleCL$rect)))>0) data_exampleCL[which(is.na(data_exampleCL$rect)),]$rect<-999
if(length(which(is.na(data_exampleCL$subRect)))>0) data_exampleCL[which(is.na(data_exampleCL$subRect)),]$subRect<-999

spat_covLV=aggregate(data_exampleCL$landValue,by=list(data_exampleCL$landCtry,data_exampleCL$vslFlgCtry,data_exampleCL$area,data_exampleCL$rect,data_exampleCL$subRect, data_exampleCL$harbour),FUN="sum")
colnames(spat_covLV)=c("LandCtry","VslFlgCtry","Area","Rect", "SubRect", "Harbour", "Sum_LandingsValue")

spat_covL=aggregate(data_exampleCL$landWt,by=list(data_exampleCL$landCtry,data_exampleCL$vslFlgCtry,data_exampleCL$area,data_exampleCL$rect,data_exampleCL$subRect, data_exampleCL$harbour),FUN="sum")
colnames(spat_covL)=c("LandCtry","VslFlgCtry","Area","Rect", "SubRect", "Harbour", "Sum_Landings")

if(length(which(is.na(data_exampleCL$foCatEu5)))>0) data_exampleCL[which(is.na(data_exampleCL$foCatEu5)),]$foCatEu5<-999
if(length(which(is.na(data_exampleCL$foCatEu6)))>0) data_exampleCL[which(is.na(data_exampleCL$foCatEu6)),]$foCatEu6<-999

spe_cov_L=aggregate(data_exampleCL$landWt,by=list(data_exampleCL$year,data_exampleCL$taxon, data_exampleCL$foCatEu5, data_exampleCL$foCatEu6),FUN="sum")
colnames(spe_cov_L)=c("Year","Species","foCatEu5","foCatEu6", "Sum_Landings")

spe_cov_LV=aggregate(data_exampleCL$landValue,by=list(data_exampleCL$year,data_exampleCL$taxon, data_exampleCL$foCatEu5, data_exampleCL$foCatEu6),FUN="sum")
colnames(spe_cov_LV)=c("Year","Species","foCatEu5","foCatEu6", "Sum_LandingsValue")

Checks_CL=list(temp_covL,temp_covLV,spat_covL,spat_covLV,spe_cov_L,spe_cov_LV)

ggplot(data=spe_cov_L, aes(x=Year,y= Sum_Landings,colour=Species)) + geom_line(stat="identity") + geom_point(stat="identity") + facet_grid(Year~foCatEu6)


return(Checks_CL)

}
