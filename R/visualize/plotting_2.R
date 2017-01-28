## Plotting

# GGPLOT2
# has 2 core plotting functions - qplot() and ggplot()
library("ggplot2")

#qplot examples
data(mpg)
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,color=drv)
qplot(displ,hwy,data=mpg,geom=c("point","smooth"))
qplot(hwy,data=mpg,fill=drv)
qplot(displ,hwy,data=mpg,facets=.~drv)
qplot(hwy,data=mpg,facets=drv~.,binwidth=2)

#ggplot
g <- ggplot(mpg, aes(displ, hwy))
print(g)
p=g+geom_point();print(p)
p=g+geom_point()+geom_smooth();print(p)
p=g+geom_point()+ facet_grid(.~drv)+geom_smooth(method="lm");print(p)
p=g + geom_point(aes(color = drv)) + labs(title = "MPG data") + 
  labs(x ="displacement", y = "Highway");print(p)


savehistory("Rsession")
loadhistory("Rsession")


