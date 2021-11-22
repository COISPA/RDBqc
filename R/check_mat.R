#' Check consistency sex and maturity stage
#'
#' @param data_example table of detailed data in RCG format
#'
#' @return Plot and error/warning messages
#' @export
#'
#' @examples check_mat(data_example,immature_stages=c("0","1","2a"))
check_mat<-function(data_example,immature_stages=c("0","1","2a")){
ggplot(data=data_example, aes(x=Length.class,y=Maturity.Stage ,col=Sex)) + geom_point(stat="identity", fill = "darkorchid4", binwidth = 0.5) + facet_grid(Year~ Sex)


# summary table of number of individuals by length class by maturity stage
data_sex=data_example[!is.na(data_example$Sex),]

tab_sex=aggregate(data_sex$Number.at.length,by=list(data_sex$Year,data_sex$Length.class),FUN="length")
colnames(tab_sex)=c("Year","Length_class","nb_sex_measurements")
tab_sex


# summary table of number of individuals by length class by maturity stage
data_mat=data_example[!is.na(data_example$Maturity.Stage),]

tab_mat=aggregate(data_mat$Number.at.length,by=list(data_mat$Year,data_mat$Length.class),FUN="length")
colnames(tab_mat)=c("Year","Length_class","nb_maturity_stage_measurements")
tab_mat

# Maturity ogive
data_mat=data_mat[(as.character(data_mat$Sex)== "F" | as.character(data_mat$Sex)== "M") & (!is.na(data_mat$Maturity.Stage) & data_mat$Maturity.Stage!=0),]
data_mat$Mature[as.character(data_mat$Maturity.Stage) %in% immature_stages]= 0
data_mat$Mature[!(as.character(data_mat$Maturity.Stage) %in% immature_stages)]= 1

mat=data_mat[data_mat$Mature==1,colnames(data_mat) %in%c("Year","Sex","Length.class","Mature","Number.at.length")]
immat=data_mat[data_mat$Mature==0,colnames(data_mat) %in%c("Year","Sex","Length.class","Mature","Number.at.length")]

merge= merge(mat,immat,by=c("Length.class","Year","Sex"),all=TRUE)

colnames(merge)[4]="Mature"
colnames(merge)[6]="Immature"

merge=merge[,c(1,2,3,4,6)]

merge[is.na(merge$Mature),]$Mature=0
merge[is.na(merge$Immature),]$Immature=0
merge$Total=merge$Mature+merge$Immature

#females
merge_temp=merge[as.character(merge$Sex)!="M"& as.character(merge$Sex)!="N",]


years= paste("(",min(merge_temp$Year),"-",max(merge_temp$Year),")",sep="")

Mat=aggregate(merge_temp$Mature,by=list(merge_temp$Length.class),FUN="sum")
Immat=aggregate(merge_temp$Immature,by=list(merge_temp$Length.class),FUN="sum")

merge_temp=merge(Mat,Immat,by=c("Group.1"), all=T)
colnames(merge_temp)=c("Length.class","Mature","Immature")
merge_temp$Total=rowSums(data.frame(merge_temp$Mature,merge_temp$Immature))


mod <- glm(cbind(merge_temp$Mature,merge_temp$Immature) ~ merge_temp$Length.class, family=binomial("logit"))

coeff=coefficients(mod)
L50=-coeff[1]/coeff[2]
IFM=summary(mod)$cov.scaled
I11=IFM[1,1]
I12=IFM[1,2]
I22=IFM[2,2]
SE_L50=sqrt((I11+2*L50*I12+(L50^2)*I22)/(coeff[2]^2))
#inverse of Information Fisher's Matrix
L75=(log(0.75/0.25)-coeff[1])/coeff[2]
L25=(log(0.25/0.75)-coeff[1])/coeff[2]
MR=L75-L25
SE_MR= 2*log(3,exp(1))/((coeff[2])^2)*sqrt(I22)


plot(merge_temp$Length.class, merge_temp$Mature/merge_temp$Total,cex=1.5,xlab="length(mm)",ylab="proportion of matures",main=paste("Females",years,sep=""))

lines(merge_temp$Length.class,predict(mod,new.data=merge_temp$Length.class,type="response"),col="deeppink3",lty=1,lwd=3)
legend("bottomright",paste(c("L50= ","MR= "),c(round(L50,3),round(MR,3)),"+/-",c(round(SE_L50,3),round(SE_MR,3))))

#males
merge_temp=merge[as.character(merge$Sex)!="F" & as.character(merge$Sex)!="N",]
years= paste("(",min(merge_temp$Year),"-",max(merge_temp$Year),")",sep="")

Mat=aggregate(merge_temp$Mature,by=list(merge_temp$Length.class),FUN="sum")
Immat=aggregate(merge_temp$Immature,by=list(merge_temp$Length.class),FUN="sum")

merge_temp=merge(Mat,Immat,by=c("Group.1"))
colnames(merge_temp)=c("Length.class","Mature","Immature")
merge_temp$Total=rowSums(data.frame(merge_temp$Mature,merge_temp$Immature))

mod <- glm(cbind(merge_temp$Mature,merge_temp$Immature) ~ merge_temp$Length.class, family=binomial("logit"))

coeff=coefficients(mod)
L50=-coeff[1]/coeff[2]
IFM=summary(mod)$cov.scaled
I11=IFM[1,1]
I12=IFM[1,2]
I22=IFM[2,2]
SE_L50=sqrt((I11+2*L50*I12+(L50^2)*I22)/(coeff[2]^2))
#inverse of Information Fisher's Matrix
L75=(log(0.75/0.25)-coeff[1])/coeff[2]
L25=(log(0.25/0.75)-coeff[1])/coeff[2]
MR=L75-L25
SE_MR= 2*log(3,exp(1))/((coeff[2])^2)*sqrt(I22)

plot(merge_temp$Length.class, merge_temp$Mature/merge_temp$Total,cex=1.5,xlab="length(mm)",ylab="proportion of matures",main=paste("Males",years,sep=""))

lines(merge_temp$Length.class,predict(mod,new.data=merge_temp$Length.class,type="response"),col="deepskyblue3",lty=1,lwd=3)

legend("bottomright",paste(c("L50= ","MR= "),c(round(L50,3),round(MR,3)),"+/-",c(round(SE_L50,3),round(SE_MR,3))))
}
