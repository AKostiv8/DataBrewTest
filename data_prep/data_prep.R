library(dplyr)
library(tidyr)
library(tibble)
library(lubridate)

# attach data frame from 'mtcars' dataset to global environment
mtcars <- datasets::mtcars

# convert the rownames to an actual column.  We suggest to never use row names, just
# use a regular column.
mtcars <- rownames_to_column(mtcars, var = 'model')

# Converting Weight (i.e. 'wt') from 1000's of lbs to lbs
mtcars$wt <- mtcars$wt * 1000


# Converting binary values to intended, character values
mtcars <- mtcars %>%
  mutate(
    vs = ifelse(vs == 0, 'V-shaped', 'Straight'),
    am = ifelse(am == 0, 'Automatic', 'Manual')
  )


saveRDS(mtcars, file = '01_traditional/data_prep/prepped/mtcars.RDS')

readRDS(file = "../testtask/data_prep/prepped/mtcars.RDS")[-(1:32),] %>% 
  mutate(uid = as.character(1)) %>%
  mutate(created_at = as_datetime(ymd_hms("2010-08-03 00:50:50"))) %>% 
  mutate(created_by = as.character(ymd_hms("2010-08-03 00:50:50"))) %>%
  mutate(modified_at = as_datetime(ymd_hms("2010-08-03 00:50:50"))) %>%
  mutate(modified_by = as.character(ymd_hms("2010-08-03 00:50:50"))) %>%
  saveRDS(., file ="../testtask/shiny_app/data/emptymtcars.RDS" ) 
# ../testtask/data_prep/prepped/emptymtcars.RDS
  
