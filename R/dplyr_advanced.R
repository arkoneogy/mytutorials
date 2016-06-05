library(dplyr)
library(nycflights13)
flights

flights %>% select(carrier, flight)
flights %>% select(-month, -day) 
flights %>% select(-(dep_time: arr_delay))
flights %>% select(-contains('time'))

cols= c('carrier', 'flight', 'tailnum')
flights %>% select(cols)
flights %>% select(one_of(cols))

flights %>% select(tail= tailnum)
flights %>% rename(tail = tailnum)

flights %>% filter(dep_time >= 600, dep_time <= 605)
flights %>% filter(between(dep_time, 600, 605))
flights %>% filter(!is.na(dep_time))

flights %>% slice(1000:1010)

flights %>% group_by(month, day) %>% slice(1:3)
flights %>% group_by(month, day) %>% sample_n(3)
flights %>% group_by(month, day) %>% top_n(3, dep_delay) %>% arrange(desc(dep_delay))

flights %>% select(origin, dest) %>% unique()
flights %>% select(origin, dest) %>% distinct()

flights %>% 