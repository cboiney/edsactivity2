#install.packages(c("dplyr", "lubridate"))
library(dplyr)
library(lubridate)

#CLASSWORK

streamH <- read.csv("/cloud/project/stream_gauge.csv")
siteinfo <- read.csv("/cloud/project/site_info.csv")

#parsing our data
streamH$dateF <- ymd_hm(streamH$datetime,
                        tz="America/New_York")

#join site info to stream gauge height
floods <- full_join(streamH, siteinfo, by="siteID")

peace <- floods %>% 
  filter(siteID == 2295637)

example <- floods %>%
  filter(gheight.ft >= 10)

plot(peace$dateF, peace$gheight.ft, type ="l")

max.ht <- floods %>%
  group_by(names) %>%
  summarize(max_ht_ft=max(gheight.ft, na.rm = TRUE),
            mean_ht_ft=mean(gheight.ft, na.rm = TRUE))

earliest_days <- floods %>%
  filter(gheight.ft > flood.ft) %>%
  group_by(names) %>%
  summarize(date=min(dateF, na.rm = TRUE))


##HOMEWORK

streamH <- read.csv("/cloud/project/stream_gauge.csv")
siteinfo <- read.csv("/cloud/project/site_info.csv")

#parsing our data
streamH$dateF <- ymd_hm(streamH$datetime,
                        tz="America/New_York")

#join site info to stream gauge height
floods <- full_join(streamH, siteinfo, by="siteID")

#q1

palmdale <- floods %>%
  filter(siteID == 2256500)

plot(palmdale$dateF, palmdale$gheight.ft, type ="l", main = "Palmdale Heights",
     xlab = "Date", ylab = "Height")

peace <- floods %>%
  filter(siteID == 2295637)

plot(peace$dateF, peace$gheight.ft, type ="l", main = "Peace Heights",
     xlab = "Date", ylab = "Height")

santa_fe <- floods %>%
  filter(siteID == 2322500)

plot(santa_fe$dateF, santa_fe$gheight.ft, type ="l", main = "Santa Fe Heights",
     xlab = "Date", ylab = "Height")

trilby <- floods %>%
  filter(siteID == 2312000)

plot(trilby$dateF, trilby$gheight.ft, type ="l", main = "Trilby Heights",
     xlab = "Date", ylab = "Height")

#q2

action_date <- floods %>%
  group_by(names) %>%
  filter(gheight.ft > action.ft) %>%
  summarize(date=min(dateF, na.rm = TRUE))

flood_date <- floods %>%
  group_by(names) %>%
  filter(gheight.ft > flood.ft) %>%
  summarize(date=min(dateF, na.rm = TRUE))

moderate_date <- floods %>%
  group_by(names) %>%
  filter(gheight.ft > moderate.ft) %>%
  summarize(date=min(dateF, na.rm = TRUE))

major_date <- floods %>%
  group_by(names) %>%
  filter(gheight.ft > major.ft) %>%
  summarize(date=min(dateF, na.rm = TRUE))


#Cite: https://www.geeksforgeeks.org/merge-dataframes-by-column-names-in-r/
#forgot how to merge data frames, this is probably not the best way to do it
#and also isn't necessary to answer the question but made it more convenient

turning_points1 <- merge("action" = action_date, "flood" = flood_date,
                        by="names")

turning_points2 <- merge(moderate_date, major_date, 
                         by="names")

turning_points <- merge(turning_points1, turning_points2, 
                        by="names")

#Cite: https://www.datanovia.com/en/lessons/rename-data-frame-columns-in-r/#google_vignette
#syntax to change the name of a column

names(turning_points)[1] = "names"
names(turning_points)[2] = "action"
names(turning_points)[3] = "flood"
names(turning_points)[4] = "moderate"
names(turning_points)[5] = "major"

#q3

most_severe <- floods %>%
  group_by(names) %>%
  filter(gheight.ft > major.ft) %>%
  summarize(diff = max(gheight.ft, na.rm = TRUE),
            major = max(major.ft, na.rm = TRUE))
