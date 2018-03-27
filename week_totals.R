library(tidyverse)
library(lubridate)

sls <- read_rds('sls.RDS')

sls <- sls %>%
  filter(st < 4) %>%
  mutate(wk = floor_date(dt, unit = 'week')) %>%
  group_by(st, wk) %>%
  summarize(wk_sls = sum(sls))

sls_l <- sls %>% nest()
