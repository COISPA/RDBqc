
#' Quality checks on CL RCG table
#'
#' @param data Landing table in RCG CL format
#' @param MS member state code as it is reported in the landing data
#' @param GSA string value of the GSA code
#' @param SP reference species for the analysis
#' @param verbose boolean. If it is TRUE messages are reported with the outputs
#' @description The output is a list of 6 data frames:
#' 1) Sum of Landings by year, quarter and month;
#' 2) Sum of Landing value by year, quarter and month;
#' 3) Sum of landings by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;
#' 4) Sum of landing value by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;
#' 5) Sum of landings by Year, Species, foCatEu5, foCatEu6;
#' 6) Sum of landing value by Year, Species, foCatEu5, foCatEu6.
#' @return Checks_CL list of tables for temporal, spatial, species and metier coverage
#' @export
#'
#' @examples check_CL(data_exampleCL,SP="Parapenaeus longirostris")
#' @importFrom utils globalVariables
#' @importFrom ggplot2 aes ggplot geom_line geom_point facet_grid
#' @importFrom stats aggregate
check_CL <- function(data,MS,GSA,SP, verbose=TRUE) {

    if (FALSE) {
        data <- data_exampleCL
        SP="Parapenaeus longirostris"
        MS = "COUNTRY1"
        GSA="GSA99"
        check_CL(data_exampleCL,MS,GSA,SP)
    }

    Year <- foCatEu6<- Sum_Landings<-Species<-NULL

    data <- data[as.character(data$taxon) %in% SP & data$vslFlgCtry %in% MS & data$area %in% GSA ,]

    if (nrow(data) == 0) {
        if(verbose){
            message(paste0("No data available for the selected species (",SP,")"))
        }
    } else if (nrow(data)>0) {

    if (any(is.na(data$landWt))) {
        if (verbose) {
            message("Na values included in the 'landWt' were removed")
        }
        data <- data[!is.na(data$landWt),]
    }
temp_covL=aggregate(data$landWt,by=list(data$year,data$quarter,data$month),FUN="sum")
colnames(temp_covL)=c("Year","Quarter","Month","Sum_Landings")
temp_covLV=aggregate(data$landValue,by=list(data$year,data$quarter,data$month),FUN="sum")
colnames(temp_covLV)=c("Year","Quarter","Month","Sum_LandingsValue")

if(length(which(is.na(data$landCtry)))>0) data[which(is.na(data$landCtry)),]$landCtry<-999
if(length(which(is.na(data$vslFlgCtry)))>0) data[which(is.na(data$vslFlgCtry)),]$vslFlgCtry<-999
if(length(which(is.na(data$rect)))>0) data[which(is.na(data$rect)),]$rect<-999
if(length(which(is.na(data$subRect)))>0) data[which(is.na(data$subRect)),]$subRect<-999

spat_covLV=aggregate(data$landValue,by=list(data$landCtry,data$vslFlgCtry,data$area,data$rect,data$subRect, data$harbour),FUN="sum")
colnames(spat_covLV)=c("LandCtry","VslFlgCtry","Area","Rect", "SubRect", "Harbour", "Sum_LandingsValue")

spat_covL=aggregate(data$landWt,by=list(data$landCtry,data$vslFlgCtry,data$area,data$rect,data$subRect, data$harbour),FUN="sum")
colnames(spat_covL)=c("LandCtry","VslFlgCtry","Area","Rect", "SubRect", "Harbour", "Sum_Landings")

if(length(which(is.na(data$foCatEu5)))>0) data[which(is.na(data$foCatEu5)),]$foCatEu5<-999
if(length(which(is.na(data$foCatEu6)))>0) data[which(is.na(data$foCatEu6)),]$foCatEu6<-999

spe_cov_L=aggregate(data$landWt,by=list(data$year,data$taxon, data$foCatEu5, data$foCatEu6),FUN="sum")
colnames(spe_cov_L)=c("Year","Species","foCatEu5","foCatEu6", "Sum_Landings")

spe_cov_LV=aggregate(data$landValue,by=list(data$year,data$taxon, data$foCatEu5, data$foCatEu6),FUN="sum")
colnames(spe_cov_LV)=c("Year","Species","foCatEu5","foCatEu6", "Sum_LandingsValue")

Checks_CL=list(temp_covL,temp_covLV,spat_covL,spat_covLV,spe_cov_L,spe_cov_LV)

p <- ggplot(data=spe_cov_L, aes(x=Year,y= Sum_Landings, color=foCatEu6)) +
    geom_line(stat="identity") +
    geom_point(stat="identity") +
    facet_grid(scales="free_y") +
    ggtitle(SP) +
    ylab("Sum Landings")
# print(p)


return(list(Checks_CL,p))
}
}
