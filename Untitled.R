library(tidyverse)
library(lubridate)
library(seasonalview)
monthlysales <- dailysales %>% 
  mutate(yr = year(slsdt), mnth = month(slsdt, label = TRUE, abbr = TRUE)) %>%
  group_by(strnum, yr, mnth) %>% summarise(sls = sum(sales)) %>% ungroup() %>%
  mutate(dt = make_date(year = yr, month = mnth, day = 1)) %>% select(-yr, -mnth) %>%
  group_by(strnum)

slist <- nest(monthlysales, 2:3, .key = sls)

> to.ts <- function(x) {
  ts(x$sls, start = c(year(min(x$dt)), month(min(x$dt))), 
     frequency = 12)}

slist$sls <- lapply(slist$sls, to.ts)

short <- lapply(slist$sls, FUN = length)
short <- short >= 12
slist <- slist[short,]

fiscal_year <- function(x) {
   ifelse(x >= ymd('20160502'), 2017,
          ifelse(x >= ymd('20150504'), 2016, 
                 ifelse(x>= ymd('20140505'), 2015,
                         ifelse(x>=ymd('20130506'), 2014, NA))))
}


adjust_date <- function(x) {
  as_date( x) + 
    ifelse(x >= ymd('20170502'), NA,
           ifelse(x >= ymd('20160502'), 364,
                  ifelse(x >= ymd('20150504'), 364*2,
                         ifelse(x>= ymd('20140505'), 364*3,
                                ifelse(x>=ymd('20130506'), 364*4, NA)))))
}

  
}