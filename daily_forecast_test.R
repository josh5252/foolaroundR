library(tidyverse)
library(lubridate)
library(prophet)

sls <- read_rds('sls.RDS')

sls <- rename(sls, y = sls)

sls_train <- sls %>%
  select(-cann) %>%
  filter(ds <= ymd(20161231)) %>%
  group_by(store) %>%
  nest() %>%
  ungroup()

sls_test <- sls %>%
  select(-cann) %>%
  filter(ds > ymd(20161231)) %>%
  group_by(store) %>%
  nest() %>%
  ungroup()

proph_m <- map(sls_train$data, prophet)