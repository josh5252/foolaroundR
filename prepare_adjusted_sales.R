library(tidyverse)
library(lubridate)

## Make the date adjustment table
last_date <- ymd(20170331)
start_date <- last_date - dyears(1) + 1

dts <- tibble(d = 0:364) %>%
  mutate(d1 = start_date + days(d)) %>%
  mutate(m = month(d1)) %>%
  mutate(d2 = d1 - 364) %>%
  mutate(d3 = d2 - 364) %>%
  mutate(d4 = d3 - 364) %>%
  mutate(d5 = d4 - 364 - 7) %>%
  select(-d)

sdt <- tibble(dt = ymd(20120201) + 0:2191)

dts2 <- dts %>%
  gather(key = y, value = dt, -m)

sdt <- sdt %>%
  inner_join(dts2)

sls <- read_rds('sls.RDS') %>%
  inner_join(sdt)
