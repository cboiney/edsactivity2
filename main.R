#install.packages(c("dplyr", "lubridate"))
library(dplyr)
library(lubridate)

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


