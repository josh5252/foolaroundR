library(tidyverse)
library(lubridate)
library(prophet)

sls <- read_rds('sls.RDS') %>%
  rename(ds = dt, y = sls) %>%
  group_by(st) %>%
  nest()

s1 <- sls[1,2][[1]][[1]]

m <- prophet(s1)
fut <- make_future_dataframe(m, periods = 365)
fc <- predict(m, fut)
plot(m, fc)
