library(data.table)
library(ggplot2)

attach(diamonds)
is.data.table(diamonds)
dd= data.table(diamonds)

dd
str(dd)
sapply(dd, class)
dim(dd)
nrow(dd)
ncol(dd)
names(dd)



head(dd$carat)
head(dd)
dd[1:10]
dd[, c('carat', 'price'), with=F]
dd[carat>1,,,,,,]
dd[cut=='Ideal']
dd[color %in% c('D','E','H','J')]

dd[, vol:= x*y*z]
dd[, test:= 2*z/(x+y)]
dd





dd[, really:= round(depth/test, 0)]
summary(dd$really)
table(dd$really)

mean(dd$price)
median(dd$carat)
sum(dd$table)

dd[, list(mean(price), median(carat), sum(table))]
dd[, list(avgPrice= mean(price), median(carat), sum(table)), by= c('cut')]

unique(dd$cut)
dx= dd[,c('cut','color','clarity'), with=F]
setkeyv(dx, names(dx))
dx= unique(dx)
dx

dd[, .N, by= 'cut']
dd[, .N, by= c('color','clarity')]
dd[, mean(price), by= 'cut']
dd[, max(depth), by= c('color','clarity')]
dd[, mean_crt_by_color:= mean(carat), by= 'color']

cols2round= c('test','mean_crt_by_color')
dd[, (cols2round):= lapply(.SD, round, 2), .SDcols= cols2round]

d2= dd[, list(avgWt= mean(carat), avgPrice= mean(price)), by= c('cut','color','clarity')]
keys= c('cut','color','clarity')
dd= merge(dd, d2, by= keys, all.x=T)

d3= d2[1:100]
newcols= paste0(c('avgWt','avgPrice'), c('.x', '.y'))
dd[, newcols:= NULL, with=F]
setkeyv(dd, keys)
setkeyv(d3, keys)
dd= d3[dd]

d.chk= dd[!is.na(avgWt)]
setkeyv(d.chk, keys)
nrow(unique(d.chk))

dx
dd.cuts=      data.table(cut= unique(dd$cut), id= 1)
dd.colors=    data.table(color= unique(dd$color), id= 1)
dd.clarities= data.table(clarity= unique(dd$clarity), id= 1)
dd.cuts
dd.all= merge(dd.cuts, dd.colors, by='id', allow.cartesian = T)
dd.all= merge(dd.all, dd.clarities, by= 'id', allow.cartesian = T)
nrow(dd.all)==nrow(dx)
dd.all[, id:= NULL]
dx[, exists:= 1]
setkeyv(dd.all, keys)
setkeyv(dx, keys)
dd.all= dx[dd.all]
dd.all[is.na(exists)]



dx= diamonds[cut=='hello']
for (i in 1:(nrow(dx))){
  print ('Hey!')
}


if (T){
  print ('Hello')
} else {
  print ('Bye')
}