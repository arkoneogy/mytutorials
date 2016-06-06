## useful commands

getwd()
setwd(dir = "C:\\Users\\mganguly\\Desktop\\Temp")  
rm()
rm(list=ls())
gc()

## Reading and writing data
data(iris)
write.csv(iris,"iris_data.csv")
write.csv(iris,"iris_data.csv",row.names=F)

data=read.csv("iris_data.csv")
nrow(data)
data$average=rowSums(data[-5])/4
save(data,file="iris_data_v2.Rda")
rm(data)
load("iris_data_v2.Rda")

data=read.csv("iris_data.csv",header=T,skip=10)
nrow(data)
data=read.csv("iris_data.csv",header=T,nrow=50)
nrow(data)
data=read.csv("iris_data.csv",header=T,skip=100,nrow=60)
nrow(data)


## Apply functions
str(<function>) - gives structure of the function

str(apply)
apply(airquality,1,sum)
apply(airquality,2,sum)

apply(mat,1,sum,na.rm=T)
apply(mat,2,sum,na.rm=T)


## lapply + sapply
l=list(a=1:5,b=rep(2,10))
lapply(l,mean);lapply(l,median)

x=as.list(1:10)
lapply(x,function(i) factorial(i))


indicator = function(z)
{
  out=ifelse(z>10,1,0)
  return (out)
}

vec=c(1,5,6,7,12,1,13,20)
sapply(vec, function(i) indicator(i))

## tapply - group mean 

data(iris)
tapply(iris$Sepal.Length,iris$Species,mean)
tapply(iris$Sepal.Length,iris$Species,max)
tapply(iris$Sepal.Length,iris$Species,summary)

## Split + lapply
s=split(airquality,airquality$Month)
lapply(s, function(x) colMeans(x[1:2],na.rm=T))





