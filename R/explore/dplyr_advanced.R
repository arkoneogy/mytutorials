library(dplyr)
library(nycflights13)
flights

# select verb
flights %>% select(carrier, flight)
flights %>% select(-month, -day) 
flights %>% select(-(dep_time: arr_delay))
flights %>% select(-contains('time'))

cols= c('carrier', 'flight', 'tailnum')
flights %>% select(cols)
flights %>% select(one_of(cols))

# rename verb
flights %>% select(tail= tailnum)
flights %>% rename(tail = tailnum)

# slice and filter verbs
flights %>% slice(1000:1010)

flights %>% filter(dep_time >= 600, dep_time <= 605)
flights %>% filter(between(dep_time, 600, 605))
flights %>% filter(!is.na(dep_time))

# group by verb
flights %>% group_by(month, day) %>% slice(1:3)
flights %>% group_by(month, day) %>% sample_n(3)
flights %>% group_by(month, day) %>% top_n(3, dep_delay) %>% arrange(desc(dep_delay))


# unique, distinct etc
flights %>% select(origin) %>% unique()
flights %>% select(dest) %>% unique()

flights %>% select(origin, dest) %>% unique()
flights %>% select(origin, dest) %>% distinct()
flights %>% select(origin, dest) %>% distinct     #this works too!

# mutate, transmute
flights %>% mutate(speed= distance/air_time * 60)
flights %>% transmute(speed= distance/air_time * 60)

mtcars %>% head()
mtcars= mtcars %>% add_rownames("model") 
mtcars %>% head()
mtcars %>%tbl_df()

# summarize, counting, tallying
flights %>% group_by(year, month) %>% summarize(count= n())
flights %>% group_by(month) %>% tally
flights %>% count(month)

flights %>% group_by(year, month) %>% summarize(count= n()) %>% arrange(desc(count))
flights %>% group_by(month) %>% tally(sort= T)
flights %>% count(month, sort= T)

# sorting
flights %>% group_by(month) %>% summarize(dist= sum(distance))
flights %>% group_by(month) %>% summarize(dist= sum(distance)) %>% arrange(desc(dist))

flights %>% group_by(month) %>% tally(wt= distance)
flights %>% count(month, wt= distance)

flights %>% group_by(month) %>% group_size()
flights %>% group_by(month) %>% n_groups()

# this sorts only within the group by level
flights %>% group_by(month, day) %>% tally(sort= T) %>% print(n= 40)

#even this!
temp= flights %>% group_by(month, day) %>% tally(sort= T)
temp %>% arrange(desc(n))

# use ungroup to get the global descending sequence
flights %>% group_by(month, day) %>% summarise(cnt= n()) %>% ungroup() %>% arrange(desc(cnt)) %>% print(n= 30)

data_frame(a= 1:6, b= a*2, c= 'string', 'd+e'= 1) %>% glimpse()
data.frame(a= 1:6, c= 'string', 'd+e'= 1) %>% glimpse()

a= data_frame(color= c('green', 'yellow', 'red'), num= 1:3)
b= data_frame(color= c('green', 'yellow', 'pink'), size= c('S', 'M', 'L'))
a
b

# this automatically creates and prints
( a= data_frame(color= c('green', 'yellow', 'red'), num= 1:3) )
( b= data_frame(color= c('green', 'yellow', 'pink'), size= c('S', 'M', 'L')) )

inner_join(a,b)
full_join(a,b)
right_join(a,b)
left_join(a,b)
left_join(b,a)

# this is same as a, but only those keys that exist in b
semi_join(a,b)
semi_join(b,a)

# this is same as a, but only those kets that DONT exist in b
anti_join(a,b)
anti_join(b,a)

( b= b %>% rename(col= color) )
inner_join(a,b, by= c('color'= 'col'))
inner_join(a,b, by= c('col'= 'color'))


# here are just a few things for viewing convenience
flights
flights %>% print(n= 15)
flights %>% head(15)

mtcars %>% print(n= Inf)
flights %>% print(width= Inf)
flights %>% View()
