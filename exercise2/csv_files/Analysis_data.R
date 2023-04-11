library(dplyr)
library(lattice)
setwd("~/Desktop/Units/HPC/My_assignment/Assignment_HPC/exercise2/csv_files")

#OMP_NUM_THREADS set to number of processor you choose when you submit the the job
df1=read.csv("1_double_mkl_EPYC.csv", header = FALSE)
colnames(df1) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df1[,1])/3
t1=c()
f1=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df1, dimension==2000*i)
  t1[i]<-mean(auxdf$time)
  f1[i]<-mean(auxdf$GFlops)
}



df2=read.csv("1_double_oblas_EPYC.csv", header = FALSE)
colnames(df2) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df2[,1])/3
t2=c()
f2=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df2, dimension==2000*i)
  t2[i]<-mean(auxdf$time)
  f2[i]<-mean(auxdf$GFlops)
}

df3=read.csv("1_float_mkl_EPYC.csv", header = FALSE)
colnames(df3) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df3[,1])/3
t3=c()
f3=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df3, dimension==2000*i)
  t3[i]<-mean(auxdf$time)
  f3[i]<-mean(auxdf$GFlops)
}

df3s=read.csv("8_float_mkl_EPYC_serial.csv", header = FALSE)
colnames(df3s) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df3s[,1])/3
t3s=c()
f3s=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df3s, dimension==2000*i)
  t3s[i]<-mean(auxdf$time)
  f3s[i]<-mean(auxdf$GFlops)
}

sp3=t3s/t3[1:length(t3s)]

df4=read.csv("1_float_oblas_EPYC.csv", header = FALSE)
colnames(df4) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df4[,1])/3
t4=c()
f4=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df4, dimension==2000*i)
  t4[i]<-mean(auxdf$time)
  f4[i]<-mean(auxdf$GFlops)
}

df4s=read.csv("8_float_oblas_EPYC_serial.csv", header = FALSE)
colnames(df4s) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df4s[,1])/3
t4s=c()
f4s=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df4s, dimension==2000*i)
  t4s[i]<-mean(auxdf$time)
  f4s[i]<-mean(auxdf$GFlops)
}

sp4=t4s/t4[1:length(t4s)]

df5=read.csv("1_double_mkl_thin.csv", header = FALSE)
colnames(df5) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df5[,1])/3
t5=c()
f5=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df5, dimension==2000*i)
  t5[i]<-mean(auxdf$time)
  f5[i]<-mean(auxdf$GFlops)
}

df6=read.csv("1_double_oblas_thin.csv", header = FALSE)
colnames(df6) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df6[,1])/3
t6=c()
f6=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df6, dimension==2000*i)
  t6[i]<-mean(auxdf$time)
  f6[i]<-mean(auxdf$GFlops)
}

df7=read.csv("1_float_mkl_thin.csv", header = FALSE)
colnames(df7) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df7[,1])/3
t7=c()
f7=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df7, dimension==2000*i)
  t7[i]<-mean(auxdf$time)
  f7[i]<-mean(auxdf$GFlops)
}

df8=read.csv("1_float_oblas_thin.csv", header = FALSE)
colnames(df8) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df8[,1])/3
t8=c()
f8=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df8, dimension==2000*i)
  t8[i]<-mean(auxdf$time)
  f8[i]<-mean(auxdf$GFlops)
}


df9=read.csv("5_double_mkl_EPYC_cores_spread.csv", header = FALSE)
colnames(df9) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df9[,1])/3
t9=c()
f9=c()
for (i in 1:N){ 
  auxdf<-dplyr::filter(df9, dimension==2000*i)
  t9[i]<-mean(auxdf$time)
  f9[i]<-mean(auxdf$GFlops)
}

df10=read.csv("5_double_mkl_EPYC_cores_true.csv", header = FALSE)
colnames(df10) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df10[,1])/3
t10=c()
f10=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df10, dimension==2000*i)
  t10[i]<-mean(auxdf$time)
  f10[i]<-mean(auxdf$GFlops)
}

df11=read.csv("5_double_mkl_EPYC_sockets_master.csv", header = FALSE)
colnames(df11) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df11[,1])/3
t11=c()
f11=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df11, dimension==2000*i)
  t11[i]<-mean(auxdf$time)
  f11[i]<-mean(auxdf$GFlops)
}

df12=read.csv("5_double_mkl_EPYC_sockets_spread.csv", header = FALSE)
colnames(df12) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df12[,1])/3
t12=c()
f12=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df12, dimension==2000*i)
  t12[i]<-mean(auxdf$time)
  f12[i]<-mean(auxdf$GFlops)
}

df9o=read.csv("5_double_oblas_EPYC_cores_spread.csv", header = FALSE)
colnames(df9o) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df9o[,1])/3
t9o=c()
f9o=c()
for (i in 1:N){ 
  auxdf<-dplyr::filter(df9o, dimension==2000*i)
  t9o[i]<-mean(auxdf$time)
  f9o[i]<-mean(auxdf$GFlops)
}

df10o=read.csv("5_double_oblas_EPYC_cores_true.csv", header = FALSE)
colnames(df10o) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df10o[,1])/3
t10o=c()
f10o=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df10o, dimension==2000*i)
  t10o[i]<-mean(auxdf$time)
  f10o[i]<-mean(auxdf$GFlops)
}

df11o=read.csv("5_double_oblas_EPYC_sockets_master.csv", header = FALSE)
colnames(df11o) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df11o[,1])/3
t11o=c()
f11o=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df11o, dimension==2000*i)
  t11o[i]<-mean(auxdf$time)
  f11o[i]<-mean(auxdf$GFlops)
}

df12o=read.csv("5_double_oblas_EPYC_sockets_spread.csv", header = FALSE)
colnames(df12o) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df12o[,1])/3
t12o=c()
f12o=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df12o, dimension==2000*i)
  t12o[i]<-mean(auxdf$time)
  f12o[i]<-mean(auxdf$GFlops)
}

df13=read.csv("1_float_mkl_thin_new_all.csv", header = FALSE)
colnames(df13) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df13[,1])/3
t13=c()
f13=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df13, dimension==2000*i)
  t13[i]<-mean(auxdf$time)
  f13[i]<-mean(auxdf$GFlops)
}

df14=read.csv("1_float_oblas_thin_new_all.csv", header = FALSE)
colnames(df14) <-c('type_data', 'time', 'dimension', 'GFlops')
N<-length(df14[,1])/3
t14=c()
f14=c()

for (i in 1:N){ 
  auxdf<-dplyr::filter(df14, dimension==2000*i)
  t14[i]<-mean(auxdf$time)
  f14[i]<-mean(auxdf$GFlops)
}

df15=read.csv("7_float_mkl_EPYC_cpus.csv", header = FALSE)
colnames(df15) <-c('type_data', 'time', 'dimension', 'GFlops')
L<-length(df15[,1])
x15=seq(1,65,8)
t15=c()
f15=c()
k=1
for (i in seq(1,L-1,2)){ 
  auxdf=df15[c(i,i+1),]
  t15[k]<-mean(auxdf$time)
  f15[k]<-mean(auxdf$GFlops)
  k=k+1
}


df16=read.csv("7_float_oblas_EPYC_cpus.csv", header = FALSE)
colnames(df16) <-c('type_data', 'time', 'dimension', 'GFlops')
L<-length(df16[,1])
x15=seq(1,65,8)
t16=c()
f16=c()
k=1
for (i in seq(1,L-1,2)){ 
  auxdf=df16[c(i,i+1),]
  t16[k]<-mean(auxdf$time)
  f16[k]<-mean(auxdf$GFlops)
  k=k+1
}

##Scalability##
x3s=seq(from=2000, to=16000, by=2000)
#sp3 is mkl, sp4 is oblas
plot(x3s, cbind(sp3,sp4), xlab="matrices dimension", ylab="speed up", main="")

##########
x1= seq(from=2000, to= 42000, by=2000)

xyplot(t1+t2~x1,main="Double, Epyc, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f1+f2~x1,main="Double, Epyc, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
x2=seq(2000, 32000, 2000)
xyplot(t3+t4~x2,main="Float, Epyc, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f3+f4~x2,main="Float, Epyc, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
x3=seq(2000, 36000, 2000)
xyplot(t5+t6~x3,main="Double, Thin, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f5+f6~x3,main="Double, Thin, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
x4=seq(2000, 22000, 2000)
xyplot(t7+t8~x4,main="Float, Thin, Default policy" ,
        
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
xyplot(f7+f8~x4,main="Float, Thin, Default policy" ,
      
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))
#Changing affinity threads doesn't provide better results


x5=seq(2000, 42000, 2000)
xyplot(t9+t10+t11+t12~x5,main="Double, Epyc, Mkl" ,
       fill = c("blue", "pink", "green", "orange"), 
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("cores-spread","cores-true", "sockets-master", "sockets-spread"),
                     points=TRUE, col=c(1,2)))
xyplot(f9+f10+f11+f12~x5, main="Double, Epyc, Mkl" ,
       fill = c("blue", "pink", "green", "orange"),
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("cores-spread","cores-true", "sockets-master", "sockets-spread"),
                     points=TRUE, col=c(1,2)))

x5o=seq(2000, 42000, 2000)
xyplot(t9o+t10o+t11o+t12o~x5o,main="Double, Epyc, Oblas" ,
       fill = c("blue", "pink", "green", "orange"), 
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05, y=0.95, text=c("cores-spread","cores-true", "sockets-master", "sockets-spread"),
                     points=TRUE, col=c(1,2)))
xyplot(f9o+f10o+f11o+f12o~x5o, main="Double, Epyc, Oblas" ,
       fill = c("blue", "pink", "green", "orange"),
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("cores-spread","cores-true", "sockets-master", "sockets-spread"),
                     points=TRUE, col=c(1,2)))
x7<-seq(2000,20000,2000)
xyplot(f13+f14~x7,main="Float, Thin, all 24 nodes" ,
       
       xlab="Dimension square matrices", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))

xyplot(t13+t14~x7,main="Float, Thin, all 24 nodes" ,
       
       xlab="Dimension square matrices", ylab="Time (s)",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))


xyplot(t15+t16~x15,main="Float, EPYC, dimension=10000",
       
       xlab="Number of cpus", ylab="Time (s)",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))

xyplot(f15+f16~x15,main="Float, EPYC, dimension=10000",
       
       xlab="Number of cpus", ylab="Gflops",
       auto.key=list(x=0.05,y=0.95, text=c("mkl","oblas"),
                     points=TRUE, col=c(1,2)))


