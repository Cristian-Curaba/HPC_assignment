library(dplyr)
library(lattice)
setwd("~/Desktop/Units/HPC/ex2/HPC_ex2")

#OMP_NUM_THREADS set to number of processor you choose when you submit the the job
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

for (i in 1:N){ 
  auxdf<-dplyr::filter(df2, dimension==2000*i)
  t2[i]<-mean(auxdf$time)
  f2[i]<-mean(auxdf$GFlops)
}

df3=read.csv("2_float_mkl_EPYC.csv", header = FALSE)
colnames(df3) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t3=c()
f3=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df3, dimension==2000*i)
  t3[i]<-mean(auxdf$time)
  f3[i]<-mean(auxdf$GFlops)
}

df4=read.csv("2_float_oblas_EPYC.csv", header = FALSE)
colnames(df4) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t4=c()
f4=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df4, dimension==2000*i)
  t4[i]<-mean(auxdf$time)
  f4[i]<-mean(auxdf$GFlops)
}

df5=read.csv("2_double_mkl_thin.csv", header = FALSE)
colnames(df5) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t5=c()
f5=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df5, dimension==2000*i)
  t5[i]<-mean(auxdf$time)
  f5[i]<-mean(auxdf$GFlops)
}

df6=read.csv("2_double_oblas_thin.csv", header = FALSE)
colnames(df6) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t6=c()
f6=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df6, dimension==2000*i)
  t6[i]<-mean(auxdf$time)
  f6[i]<-mean(auxdf$GFlops)
}

df7=read.csv("2_float_mkl_thin.csv", header = FALSE)
colnames(df7) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t7=c()
f7=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df7, dimension==2000*i)
  t7[i]<-mean(auxdf$time)
  f7[i]<-mean(auxdf$GFlops)
}

df8=read.csv("2_float_oblas_thin.csv", header = FALSE)
colnames(df8) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-10
t8=c()
f8=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df8, dimension==2000*i)
  t8[i]<-mean(auxdf$time)
  f8[i]<-mean(auxdf$GFlops)
}

x1=seq(2000, 10000, 2000)
df9=read.csv("2_double_mkl_EPYC_cores_false.csv", header = FALSE)
colnames(df9) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-5
t9=c()
f9=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df9, dimension==2000*i)
  t9[i]<-mean(auxdf$time)
  f9[i]<-mean(auxdf$GFlops)
}

df10=read.csv("2_double_mkl_EPYC_cores_master.csv", header = FALSE)
colnames(df10) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-5
t10=c()
f10=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df10, dimension==2000*i)
  t10[i]<-mean(auxdf$time)
  f10[i]<-mean(auxdf$GFlops)
}

df11=read.csv("2_double_mkl_EPYC_sockets_false.csv", header = FALSE)
colnames(df11) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-5
t11=c()
f11=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df11, dimension==2000*i)
  t11[i]<-mean(auxdf$time)
  f11[i]<-mean(auxdf$GFlops)
}
xyplot(t1+t2~x,main="Double, Epyc, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f1+f2~x,main="Double, Epyc, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="GFlops/s",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(t3+t4~x,main="Float, Epyc, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f3+f4~x,main="Float, Epyc, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="GFlops/s",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(t5+t6~x,main="Double, Thin, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f5+f6~x,main="Double, Thin, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="GFlops/s",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(t7+t8~x,main="Float, Thin, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f7+f8~x,main="Float, Thin, Default policy" ,
        
       xlab="Dimension square matrixes", ylab="GFlops/s",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(t9+t10+t11~x1,main="Float, Epyc, Mkl" ,
       fill = c("blue", "pink", "green"), 
       xlab="Dimension square matrixes", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("cores-false","cores-master", "sockets-false"),
                     points=TRUE, col=c(1,2)))
xyplot(f9+f10+f11~x1, main="Float, Epyc, Mkl" ,
       fill = c("blue", "pink", "green"),
       xlab="Dimension square matrixes", ylab="GFlops/s",
       auto.key=list(x=0.05,y=0.95, text=c("cores-false","cores-master", "sockets-false"),
                     points=TRUE, col=c(1,2)))
