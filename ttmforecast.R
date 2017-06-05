sls <- readRDS('sls.RDS')
sls <- sls %>% filter(ds >= ymd('20130101'), ds <= ymd('20170331'))
library(xts)
sll <- split(sls, f = sls$store)
names(sll) <- paste('Store',names(sll), sep = '')
sll <- map(sll, ~select(., -store))
sllday <- sll
sll <- map(sll, ~select(., -cann))
sll <- map(sll, ~xts(x = .$sls, order.by = .$ds))
sll <- map(sll, ~apply.monthly(., sum) )
slt <- map(sll, ~ts(coredata(.), start = c(year(min(index(.))), month(min(index((.))))), frequency = 12))
slt2 <- slt[map_lgl(slt, ~length(.) >=12)]
slyear <- map(slt2, ~stats::filter(., rep(1,12), sides = 1))
slfit <- map(slyear, auto.arima)
slfcst <- map(slfit, ~forecast(., h = 12))

library(seasonal)
ll <- lapply(slt2, function(e) try(seas(e, x11="")))
