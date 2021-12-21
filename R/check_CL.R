
#' Title
#'
#' @param data_exampleCL
#'
#' @return
#' @export
#'
#' @examples
check_CL <- function(data_exampleCL) {

temp_covL=aggregate(data_exampleCL$landWt,by=list(data_exampleCL$year,data_exampleCL$quarter,data_exampleCL$month),FUN="sum")
colnames(temp_covL)=c("Year","Quarter","Month","Sum_Landings")
temp_covLV=aggregate(data_exampleCL$landValue,by=list(data_exampleCL$year,data_exampleCL$quarter,data_exampleCL$month),FUN="sum")
colnames(temp_covLV)=c("Year","Quarter","Month","Sum_LandingsValue")

if(length(which(is.na(data_exampleCL$landCtry)))>0) data_exampleCL[which(is.na(data_exampleCL$landCtry)),]$landCtry<-999
if(length(which(is.na(data_exampleCL$vslFlgCtry)))>0) data_exampleCL[which(is.na(data_exampleCL$vslFlgCtry)),]$vslFlgCtry<-999
if(length(which(is.na(data_exampleCL$rect)))>0) data_exampleCL[which(is.na(data_exampleCL$rect)),]$rect<-999
if(length(which(is.na(data_exampleCL$subRect)))>0) data_exampleCL[which(is.na(data_exampleCL$subRect)),]$subRect<-999

spat_covL=aggregate(data_exampleCL$landWt,by=list(data_exampleCL$landCtry,data_exampleCL$vslFlgCtry,data_exampleCL$area,data_exampleCL$rect,data_exampleCL$subRect, data_exampleCL$harbour),FUN="sum")
colnames(temp_covL)=c("Year","Quarter","Month","Sum_Landings")
}
