## Plotting

# Basic explanatory graphs - base plotting system 
# Boxplot

data(iris)
boxplot(iris)
boxplot(iris$Sepal.Length ~ iris$Species, col="red")

# Histogram
library("ggplot2")
data(economics)
hist(economics$pce,col = "green")
rug(economics$pce)
hist(economics$pce, col = "green", breaks=50,xaxs="i", yaxs="i",)
abline(v=mean(economics$pce),lwd=2,col="blue")
abline(v=median(economics$pce),lwd=2,col="black")
text(2300,40,"Median",col="black",lwd=2)
text(4090,40,"Mean",col="blue",lwd=2)

# Plotting parameters
library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
title("Ozone levels across year")

library(datasets)
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue",pch=19))


#seting plotting area
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",  type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue",pch=19))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red",pch=19))
legend("topright", pch = 19, col = c("blue", "red"), legend = c("May", "Other Months"))

#Multiple plots in same graph
par(mfcol = c(2,1))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind",col="green",pch=19)
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation",col="red",pch=19)
})


#par("oma"),par("mar") ... to see defaults values of plotting parameters

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE)
})

x=rep(1:10,2)
y=rep(1:10,2)+30
z=(1:20)^2
plot(x,y,type="l")
points(z)


# Create Line Chart

# convert factor to numeric for convenience 
Orange$Tree <- as.numeric(Orange$Tree) 
ntrees <- max(Orange$Tree)

# get the range for the x and y axis 
xrange <- range(Orange$age) 
yrange <- range(Orange$circumference) 

# set up the plot 
plot(xrange, yrange, type="n", xlab="Age (days)",
     ylab="Circumference (mm)" ) 
colors <- rainbow(ntrees) 
linetype <- c(1:ntrees) 
plotchar <- seq(18,18+ntrees,1)

# add lines 
for (i in 1:ntrees) { 
  tree <- subset(Orange, Tree==i) 
  lines(tree$age, tree$circumference, type="b", lwd=1.5,
        lty=linetype[i], col=colors[i], pch=plotchar[i]) 
} 
# add a title and subtitle 
title("Tree Growth", "example of line plot")

# add a legend 
legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
       pch=plotchar, lty=linetype, title="Tree")
