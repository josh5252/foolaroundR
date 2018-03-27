library(tidyverse)
library(readxl)

sdt <- read_excel('scorecard.xlsx',
                  sheet = 'data') %>%
  select(-SOD_ID:-REC_RANGE,
         -STORE_NAME:-REGION_RANK) %>%
  mutate_if(is.character,
            as.numeric) %>%
  mutate(DT_AS_OF = as.Date(DT_AS_OF))

sdt1 <- sdt %>%
  select(-ends_with('TARGET'),
         -ends_with('POINTS'),
         -ends_with('LY'),
         -ends_with('TREND'),
         -ends_with('SCORE'),
         -ends_with('PCNT'),
         -ends_with('PCNT_BUDGET'),
         -DT_BUILD)

sdt2 <- sdt1 %>%
  mutate(sls_num = SALES_NET - SALES_NET_BUDGET,
         esp_den = SALES_NET - ESP_TRANS - ITC_TRANS,
         itc_den = SALES_NET - ESP_TRANS - ITC_TRANS,
         ret_num = -SALES_RETURNS,
         ret_den = SALES_NET - SALES_RETURNS,
         shr_num = -SHRINK_KNOWN,
         spl_den = 1,
         sca_num = as.integer(SCAN_ACTUAL_DATE <= SCAN_SCHEDULE_DATE),
         sca_den = 1) %>%
  rename(sls_den = SALES_NET_BUDGET,
         esp_num = ESP_TRANS,
         itc_num = ITC_TRANS,
         shr_den = SALES_NET,
         dis_num = UNAUTH_DISCOUNT,
         dis_den = SALES_NET,
         iso_num = ISOS_COUNT,
         iso_den = ISOS_PLANOGRAM_QTY,
         cap_num = CAPACITY_AT_PERCENT,
         cap_dun = ISOS_PLANOGRAM_QTY,
         ord_num = ORDIS_COGS,
         ord_den = ORDIS_SHIPORDER,
         nam_num = NEW_CUSTOMERS,
         nam_den = TOTAL_TRANSACTIONS,
         act_num = CUSTOMER_PURCHASE_AMT,
         act_den = TOTAL_PURCHASE_AMT,
         ema_num = EMAIL_COUNT,
         ema_den = TOTAL_TRANSACTIONS,
         pac_num = PRICE_INACCURACY,
         pac_den = PRICE_SCANS,
         pay_num = PAYROLL_ACTUALS,
         pay_den = SALES_NET,
         spl_num = SALES_NET,
         hir_num = STAFFING_HIRE,
         hir_den = STAFFING_CENSUS,
         dri_num = DRIFT_ACTIONABLE_EMPLOYEES,
         dri_den = DRIFT_TOTAL_EMPLOYEES) %>%
  select(DT_AS_OF:STORE_NUM,
         ends_with('num',
                   ignore.case = FALSE),
         ends_with('den',
                   ignore.case = FALSE))

metrics <- read_excel('scorecard.xlsx',
                      sheet = 'STOREOPS_POINTS') %>%
  filter(!is.na(Num)) %>%
  select(-Points:-`Hi_Val`) %>%
  mutate(k = 1)

s <- sdt1 %>%
  filter(DT_AS_OF == as.Date('2017-01-01'),
         STORE_NUM < 3) %>%
  select(DT_AS_OF,
         STORE_NUM,
         SALES_RETURNS) %>%
  mutate(k = 1)

s <- s %>%
  inner_join(metrics) %>%
  select(-k)

y <- expr(-SALES_RETURNS)

z <- s %>% mutate(z = y)          # Error
z <- z %>% mutate(zz = eval(y))

z <- s %>% mutate(z = eval(rlang::parse_expr('Num')))
z <- z %>% mutate(zz = -SALES_RETURNS)
z <- z %>% mutate(zzz = eval(syms(Num)))

z <- s %>% mutate(z = eval(Num))
