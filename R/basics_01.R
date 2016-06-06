###### R SESSION - 2015 ########                                                  #(ctrl+l)

# Factors
var=factor(c("yes","no","no","yes","yes"),levels=c("yes","no"))
var
var[6]="may be"
class(var)

var=factor(c("yes","no","no","yes","yes"),levels=c("yes","no","may be"))
var
var[6]="may be"
class(var)

library(plyr)
var_2=revalue(var,c("yes"=1,"no"= 0,"may be"=3 ))
var_2
class(var_2)

# Subsetting
# Vectors
var=c(1,2,12,23,NA,45,50,67,100,102,NA,NA)

length(var)
var>10
which(var>10)
var[var>10]
var[var >10 & var<40]
var[var>1000]
var[which(var <0)]
var[var %in% c(45,50)]

is.na(var)
var[is.na(var)] = 0
var[!is.na(var)]
var

var=c(1,2,12,23,NA,45,50,67,100,102)
is.na(var)
var[is.na(var)] = 0
var

# Matrices

mat=matrix(c(1:10),nrow=2,ncol=5,byrow=T)
mat
mat=matrix(c(1:10),nrow=2,ncol=5,byrow=F)
mat
dimnames(mat)
dim(mat)

mat[1,4]
mat[1,]
mat[,4]
class(mat[1,])
class(mat[1,,drop=F])
typeof(mat[1,,drop=F])



# Lists

l=list(a="Hello",b=c(1,2,3,4,5,6,7,8,9),c=TRUE)

l$a
l[[1]]
l[1]
l["a"]

class(l$a)
class(l$b)
class(l$c)
attributes(l)

name="a"
l[[names]]
l[name]
l$names
l$a
l[c(1,2)]
l[[2]][[4]]
l[[3]][[1]]


# Removing NA
x=c(NA,1,22,14,56,NA,66,89,90)
y=c(11,NA,56,NA,NA,38,59,10,NA)
good=complete.cases(x,y)
good
x[good]
y[good]


# Data frames
data(airquality)
good=complete.cases(airquality)
nrow(airquality);ncol(airquality)
airquality[good,]
airquality[good,1:5]


names(airquality)
row.names(airquality)
colnames(airquality)
attributes(airquality)
mat=data.matrix(airquality)
dimnames(mat)


# Summarize
head(airquality)
str(airquality)
summary(airquality)

data(mtcars)
head(mtcars)
str(mtcars)
row.names(mtcars)
colnames(mtcars)
summary(mtcars)
quantile(mtcars$mpg);quantile(mtcars$mpg,probs = seq(0,1,by=0.1))
xtabs(mpg ~ cyl + carb, data=mtcars)
table(mtcars$carb > 2,useNA="ifany")
colSums(mtcars)
rowSums(mtcars)

# data(iris)
# table(iris$Species)
# table(var,useNA="ifany")


# Creating new variables
x=1:5
x=seq(1,100,by=2)
x=seq(1,100,length=7)

#binary variables
data_new=mtcars
data_new$cyl_cat=ifelse(data_new$cyl > 5,1,0)
table(data_new$cyl_cat)

#categorical variables
data_new$mpg_cat=cut(data_new$mpg,quantile(data_new$mpg))
data_new$mpg_cat=cut(data_new$mpg,quantile(data_new$mpg),include.lowest = T)
library(Hmisc)
data_new$mpg_cat=cut2(mtcars$mpg,g=5)
table(data_new$mpg_cat)

# Sorting
x=seq(1,100,length=7)
sort(x)
sort(x,decreasing =T)

mtcars[order(mtcars$mpg,decreasing = T),]
mtcars[order(mtcars$mpg),]
mtcars[order(mtcars$mpg,mtcars$cyl),]

# Binding
data_frame_1=mtcars[,1:3]
data_frame_2=mtcars[,4:ncol(mtcars)]
mtcars_v2=cbind(data_frame_1,data_frame_2)

data_frame_1=mtcars[1:20,]
data_frame_2=mtcars[21:nrow(mtcars),]
mtcars_v2=rbind(data_frame_1,data_frame_2)

