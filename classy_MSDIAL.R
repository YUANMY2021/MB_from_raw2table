library(classyfireR)
library(plyr)
INCHIKEY<-read.table("./inchi_ah",sep=",",check.names=T,stringsAsFactors = F)
aa<-read.csv("./Book4.csv")
dd<-read.csv("./Book5.csv")
aa<-data.frame(aa)
dd<-data.frame(dd)
INCHIKEY<-data.frame(INCHIKEY$V3)
colnames(INCHIKEY)="V1"
for (i in 1:nrow(INCHIKEY)){
  bb<-(get_classification(INCHIKEY$V1[i]))
  ifelse(is.null(bb),{
    cc<-dd
    aa<-rbind.fill(aa,cc)},{
      ifelse(length(bb@classification)==0,{
        cc<-dd
        aa<-rbind.fill(aa,cc)},
        {cc<-data.frame(t(bb@classification$Classification))
        aa<-rbind.fill(aa,cc)})
    })
}

aa<-aa[-1,]
ee<-cbind(INCHIKEY,aa)
colnames(ee)[1]<-c("Inchikey")
ee$INCHIKEY=NULL
ee<-ee[,-2:-10]
write.csv(ee,"./classy_ah.csv")

#!/bin/bash

#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 8-12:30
#SBATCH --mem=5GB
#SBATCH -p cpu
#SBATCH -J cla8
#SBATCH -o cla8.o
#SBATCH -e cla8.e

Rscript 8.R
