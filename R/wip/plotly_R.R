library(plotly)


# first we'll do scatter plots
data(mtcars)
head(mtcars)

plot_ly(data= mtcars, x= ~wt, y= ~mpg,
        type= 'scatter', mode= 'markers')

plot_ly(data= mtcars, x= ~wt, y= ~mpg, color= ~cyl,
        type= 'scatter', mode= 'markers')

plot_ly(data= mtcars, x= ~wt, y= ~mpg, color= ~as.factor(cyl),
        type= 'scatter', mode= 'markers')

plot_ly(data= mtcars, x= ~wt, y= ~mpg, color= ~disp,
        type= 'scatter', mode= 'markers')

plot_ly(data= mtcars, x= ~wt, y= ~mpg, color= ~as.factor(cyl), size= ~hp,
        type= 'scatter', mode= 'markers')


data(iris)
head(iris)

plot_ly(data= iris, x= ~Sepal.Length, y= ~Petal.Length, color= ~Species, 
        type= 'scatter', mode= 'markers')


# now some time series line plots 
data("airmiles")
airmiles
time(airmiles)

plot_ly(x= time(airmiles), y= airmiles)

plot_ly(x= time(airmiles), y= airmiles, 
        type= 'scatter', mode= 'lines')

plot_ly(x= time(airmiles), y= airmiles, 
        type= 'scatter', mode= 'lines+markers')

library(dplyr)
library(tidyr)

data("EuStockMarkets")
head(EuStockMarkets)

stocks= as.data.frame(EuStockMarkets) %>% gather(index, price)

head(stocks)
table(stocks$index)

stocks= as.data.frame(EuStockMarkets) %>% gather(index, price) %>% mutate(time= rep(time(EuStockMarkets),4))
head(stocks)

plot_ly(data= stocks, x= ~time, y= ~price, color= ~index, 
        type= 'scatter', mode= 'lines')

# histogram
precip

plot_ly(x= precip, type= 'histogram')

plot_ly(x= rnorm(10), type= 'histogram')
plot_ly(x= rnorm(100), type= 'histogram')
plot_ly(x= rnorm(1000), type= 'histogram')
plot_ly(x= rnorm(10000), type= 'histogram')
plot_ly(x= rnorm(100000), type= 'histogram')


# boxplots

plot_ly(data= iris, y= ~Petal.Length, x= ~ Species, type= 'box')
plot_ly(data= iris, y= ~Petal.Length, x= ~ Species, type= 'box', color= ~Species)


# heatmaps or raster images

terrain = matrix(rnorm(100*100), nrow= 100, ncol= 100)
plot_ly(z= terrain, type= 'heatmap')

# surface

terrain = matrix(sort(rnorm(100*100)), nrow= 100, ncol= 100)
plot_ly(z= terrain, type= 'surface')


# maps
data(state)
head(state)

state.pop= data.frame(State= state.abb, Pop= as.vector(state.x77[,1]))
head(state.pop)

state.pop$hover= with(state.pop, paste(State, '<br>', 'Population:', Pop))
head(state.pop)

borders= list(color= toRGB('red'))

map_options= list(scope= 'usa',
                  projection= list(type= 'albers usa'),
                  showlakes= T,
                  lakecolor= toRGB('blue'))

plot_ly(state.pop, z= ~Pop, locations= ~State,
        type= 'choropleth', 
        locationmode= 'USA-state',
        text= ~hover,
        color= ~Pop,
        colors= 'Greens',
        marker= list(line= borders)) %>%
  layout(title= 'US population in 1975',
         geo= map_options)
