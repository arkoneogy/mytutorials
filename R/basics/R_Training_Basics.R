############################################################################
#	Program:	R_Training_Basics.R
#	Date:		June, 2016
#	Author:	Deloitte
#	Contents:		Code to get introduce R Basics 
############################################################################

# Cutomary Hello World
print("Hello World")

# Basic Operations
2+3
2*3
5/2
5**3
5^3
5%*%4
132%%11
127%%5
sqrt(12)

# Assigning values
x<-46
x
(x <- 30);
y = 49; 35 -> z;assign("x",91)
x;y;z;

# Sequences
c(1,2,3,4,5)
1:5
seq(from=1,to=5,by=1);

# Using Help
help.start()
?seq
example(seq)
??seq
help.search("seq")

# Objects in R
objects()
ls()
rm(x)
ls()
rm(list=ls())
ls()

# Strings
(x <- "Who are the pioneers behind customer segmentation? ")
(y <- "Astrologers ?!")
random_thought_1 <- paste(x,y,sep="\n")
random_thought_1

q <- "What if like Oscars we have ML Awards?"
a <- "We will have awards like 'Best Gradient Direction' & 'Best Supporting Vector'"
random_thought_2 <- cat("Qn : ",q,"\n","Ans: ",a, sep="")
random_thought_2

# Vectors
a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three","two","two","one") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
d <- c(1,"two",3)
print("What type of vector is d ?")
# Vector Operations
(e <- a * 2 + 3);

var=c(1,2,12,23,NA,45,50,67,100,102,NA,NA)
length(var)
var>10
which(var>10)
which(var %in% c(45,50))

print('Different ways of subsetting Vectors')
var[var>10]
var[1:3]
var[which(var >10)]
var[c(-3,-1)]

var[var >10 & var<40]
var[var>1000]

is.na(var)
var[is.na(var)]
var[!is.na(var)]
var[is.na(var)] <- 0
var

# Types of Missing values
(missings <- c(NA,(0/0),(1/0),(-1/0),Inf,-Inf,Inf-Inf,NaN))
missings == NA
missings == Inf
missings[is.na(missings)]
missings[is.nan(missings)]
missings[is.infinite(missings)]

(char.missing <- c(NA,"","NA"))
which(is.na(char.missing))

## Factors
b
c <- as.factor(b)
c
class(c)
as.numeric(c)
levels(c)
d <- factor(b,levels=c("one","two","three"),ordered = T)
d
class(d)
as.numeric(d)
levels(d)

levels(d)
levels(d) <- c("First","Second","Third")
d
d[5] <- "Fourth"
d
levels(d) <- c("First","Second","Third","Fourth")
d[5] <- "Fourth"
d
print("You could also use 'revalue' function in 'plyr' package.")

# Arrays
ar <- array(1:8,dim = c(2,2,2))
ar
ar[2,1,2]
dim(ar) <- c(4,2)
ar
# Matrices - 2-dimensional arrays
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

mat+mat #Simple matrix addition
mat * 2 #Scalar Multiplication
mat * mat #Element by element Multiplication
mat2 <- t(mat) #Transpose
(mat3 <- mat %*% mat2) #Matrix multiplication
det(mat3) #Determinant of Matrix
Mat3_Inv <- solve(mat3)  #Matrix product: Inverse x Original
Mat3_Inv * mat3

eigen(mat3)
Mat3_Inv %*% mat3

a <- 1:10
b <- 100:91
c <- cbind(a,b)
dim(c)
c
d <- paste("Row",1:10)
c <- cbind(c,d)
c

# Lists
l=list(a="Hello",b=c(1,2,3,4,5,6,7,8,9),c=TRUE)
l
l$a
l[[1]]
l[1]
l["a"]

class(l)
class(l$a)
class(l$b)
class(l$c)
attributes(l)

name="a"
l[[name]]
l[name]
l[c(1,2)]
l[[2]][[4]]
l[[3]][[1]]

# Data frames
a;b;d;
(c <- data.frame(a,b,d))
dim(c);
nrow(c);ncol(c)
str(c)
names(c)
row.names(c)
attributes(c)
head(c)
summary(c)
c[1:3,1:3]

# Available Data Sources
data()

data(mtcars)
head(mtcars)
str(mtcars)
row.names(mtcars)
colnames(mtcars)
summary(mtcars)
quantile(mtcars$mpg);
quantile(mtcars$mpg,probs = seq(0,1,by=0.1))
xtabs(mpg ~ cyl + carb, data=mtcars)
table(mtcars$carb > 2,useNA="ifany")
colSums(mtcars)
rowSums(mtcars)

# Creating new variables

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
order(x,decreasing =T)
x[order(x,decreasing =T)]

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




