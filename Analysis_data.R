library(dplyr)
library(lattice)
setwd("~/Desktop/Units/HPC/ex2/HPC_ex2")

df1=read.csv("2_double_mkl_EPYC.csv", header = FALSE)
colnames(df1) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t1=c()
f1=c()
x= seq(from=2000, to= 20000, by=2000)
for (i in 1:N){ 
  auxdf<-dplyr::filter(df1, dimension==2000*i)
  t1[i]<-mean(auxdf$time)
  f1[i]<-mean(auxdf$GFlops)
}

df2=read.csv("2_double_oblas_EPYC.csv", header = FALSE)
colnames(df2) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t2=c()
f2=c()
x= seq(from=2000, to= 20000, by=2000)
for (i in 1:N){ 
  auxdf<-dplyr::filter(df2, dimension==2000*i)
  t2[i]<-mean(auxdf$time)
  f2[i]<-mean(auxdf$GFlops)
}

xyplot(t1+t2~x,main="Double, Epyc, Default policy" ,
       pch = 21 ,fill = c("blue", "pink"), cex = 1 ,
       xlab="Dimension square matrixes", ylab="Time (ms)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f1+f2~x,main="Double, Epyc, Default policy" ,pch = 21 ,
       fill = c("blue", "pink"), cex = 1 ,
       xlab="Dimension square matrixes", ylab="GFlops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
