library(stringr)
library(dplyr)

# zenderschema ------------------------------------------------------------

tbl_zenderschema <- tbl_raw_zenderschema %>% 
  mutate(start = str_pad(string = start, side = "left", width = 5, pad = "0"), 
         slot = paste0(str_sub(dag, start = 1, end = 2), start)
  ) %>% 
  rename(hh_formule = `hhOffset-dag.uur`,
         balk = Balk,
         balk_tonen = Toon,
         wekelijks = `elke week`,
         product_wekelijks = te,
         bijzonderheden_wekelijks = be,
         AB_cyclus = `twee-wekelijks`,
         product_A_cyclus = A,
         bijzonderheden_A_cyclus = ba,
         product_B_cyclus = B,
         bijzonderheden_B_cyclus = bb, 
         week_1 = `week 1`,
         product_week_1 = t1,
         bijzonderheden_week_1 = b1,
         week_2 = `week 2`,
         product_week_2 = t2,
         bijzonderheden_week_2 = b2,
         week_3 = `week 3`,
         product_week_3 = t3,
         bijzonderheden_week_3 = b3,
         week_4 = `week 4`,
         product_week_4 = t4,
         bijzonderheden_week_4 = b4,
         week_5 = `week 5`,
         product_week_5 = t5,
         bijzonderheden_week_5 = b5) %>%
  select(-starts_with("r"), -dag, -start) %>% 
  select(slot, hh_formule, everything())

# presentatie-rooster -----------------------------------------------------




