library(readxl)
library(tidyverse)
library(lubridate)


# First let's get the date adjusting Excel file loaded
date_adj_path <- 'dateadjusting.xlsx'
date_adj <-
  as.tibble(read_excel(date_adj_path,
                       sheet = 'Tall format',
                       col_names = c('dt', 'adj'),
                       col_types = 'date',
                       skip = 1
  )) %>%
  mutate(dt = as_date(dt),
         adj = as_date(adj)) %>%
  arrange(adj)

# Bring in the sales data
sls <- read_rds('sls.RDS')

# And bring in stores data
stores <- read.delim('stores.csv',
                     fileEncoding = 'UTF-16LE',
                     stringsAsFactors = FALSE,
                     col.names = c('dist', 'name','region',
                                   'store', 'st', 'open_date', 'lat', 'lon'))
stores$open_date <- mdy(stores$open_date)

# Grab the latest date in the data so we can trim the end. Round to the whole month.
max_dt <- (tibble(dt = max(sls$dt)) %>%
  inner_join(date_adj) %>%
  select(adj))[[1]] %>% rollback()

# And do a full outer join to make sure all dates are covered and the duplicate dates are duplicated
adj_sls <- full_join(sls, date_adj) %>%
  select(-dt) %>%
  rename(dt = adj) %>%
  filter(dt <= max_dt)



