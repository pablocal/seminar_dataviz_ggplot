# Metadata ----------------------------------------------------------------
# Title: Data prepration craft beer (Kaggle)
# Purpose: Webinar R & ggplot2
# Author(s): @pablocal
# Date: 2020-04-22
#
# Comments ----------------------------------------------------------------
#   Data from Kaggle https://www.kaggle.com/nickhould/craft-cans
# 
# 
#
#
# Options and packages ----------------------------------------------------
library(tidyverse)


# 1. Read files and select only complete cases ----------------------------
beers <- read_csv("_prep/beers.csv")
beers <- beers[complete.cases(beers),]

sjmisc::frq(beers$style, sort.frq = "desc")


# 2. Prepare data ---------------------------------------------------------
# Classify styles
# Drop few extreme cases
# Sample 1k

beers <- beers %>% 
  mutate(family = case_when(
           str_detect(style, "Lager|Pilsner|Pilsener") ~ "Lager & Pilsener",
           str_detect(style, "Stout|Bitter|Porter") ~ "Stout & Bitter",
           str_detect(style, "Pale Ale|IPA") ~ "Pale Ale",
           str_detect(style, "Ale") ~ "Other Ales",
           TRUE ~ "Other"
         ),
         family = fct_relevel(family, "Pale Ale", "Other Ales", "Lager & Pilsener", "Stout & Bitter")) %>% 
  select(id, name, family, style, abv, ibu, ounces) %>% 
  rename(alc_vol = abv, bitter = ibu) %>% 
  filter(alc_vol < .101 & bitter < 125 & family != "Other") %>% 
  sample_n(1000)


# 3. Save exercise file ---------------------------------------------------
write_csv(beers, "beers.csv")

