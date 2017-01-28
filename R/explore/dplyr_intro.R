library(dplyr)
library(hflights)

data("hflights")
head(hflights)

flights= tbl_df(hflights)
head(flights)
flights
flights
print(flights, n=20)
names(flights)
data.frame(head(flights))

filter(flights, Month==1, DayofMonth==1)
filter(flights, Month==1 & DayofMonth==1)
filter(flights, UniqueCarrier=='AA' | UniqueCarrier=='UA')
filter(flights, UniqueCarrier %in% c('UA','AA'))

names(flights)
select(flights, FlightNum, DepTime, ArrTime, ArrDelay)
select(flights, Year:DayofMonth, contains('Taxi'), contains('Delay'))
select(flights, Year:DayofMonth, contains('Taxi'), contains('Delay'), contains('Time'))

filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)

x1= 1:5
x2= 2:6
(x2-x1)^2 %>% sum() %>% sqrt()

flights %>% select(UniqueCarrier, DepDelay) %>% filter(DepDelay > 60)

flights %>% select(UniqueCarrier, DepDelay) %>% arrange(DepDelay)
flights %>% select(UniqueCarrier, DepDelay) %>% arrange(desc(DepDelay))

flights %>% select(Distance, AirTime) %>% mutate(Speed = Distance / AirTime)
flights
flights = flights %>% mutate(Speed = Distance / AirTime)
flights

flights %>% group_by(Dest) %>% summarise(avg_delay = mean(ArrDelay, na.rm=T))
flights %>% group_by(UniqueCarrier) %>% summarise(avg_delay = mean(ArrDelay, na.rm=T)) %>% arrange(avg_delay)
af= flights %>% group_by(UniqueCarrier) %>% summarise(avg_delay = mean(ArrDelay, na.rm=T)) %>% arrange(avg_delay)
af

flights %>% group_by(UniqueCarrier) %>% summarise_each(funs(mean), Cancelled, Diverted)
flights %>% 
  group_by(UniqueCarrier) %>% 
  summarise_each(funs(min(.,na.rm=T), mean(.,na.rm=T), max(.,na.rm=T)), matches('Delay'))

flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count= n()) %>%
  arrange(desc(flight_count))

flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort=T)

flights %>% count(Month, DayofMonth, sort = T)

flights %>%
  group_by(Dest) %>%
  summarise(flight_count= n(), plane_count= n_distinct(TailNum))

flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table()

flights %>% 
  group_by(UniqueCarrier) %>% 
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 3) %>% 
  arrange(desc(DepDelay)) %>% 
  print(n=20)

flights %>% 
  group_by(UniqueCarrier) %>% 
  select(Month, DayofMonth, DepDelay) %>%
  top_n(3) %>%
  arrange(desc(DepDelay))

flights %>%
  group_by(Month) %>%
  summarise(flight_count= n()) %>%
  mutate(change= flight_count - lag(flight_count))

flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change= n - lag(n))

flights %>% 
  count(Month) %>% 
  mutate(change= n - lag(n))

flights %>% sample_n(100)
flights %>% sample_frac(0.3)

glimpse(flights)
str(flights)
