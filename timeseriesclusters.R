sls <- read_rds('~/foolaroundR/sls.rds')
library(tidyverse)
library(lubridate)
library(TSclust)
library(dtwclust)

sls <- sls %>% filter(ds >= ymd('20130101')) %>% select(-cann)
sll <- split(sls )
sls_clust <- sll
tsc <- tsclust(series = sls_clust, type = 'hierarchical', k = 8L)
tsc_results <- rownames_to_column(as.data.frame(tsc@cluster))
names(tsc_results) <- c('store', 'cluster')
tsc_results$store <- as.numeric(stringr::str_sub(tsc_results$store, 6))
write_csv(tsc_results, 'results1.csv')
