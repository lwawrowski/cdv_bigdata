library(tidyverse)

load("data/wybory.rda")

# wybory_csv <- read_csv(file = "data/wybory.csv")
# rm(wybory_csv)


# filtrowanie -------------------------------------------------------------

frekwencja80 <- wybory %>% 
  filter(frekwencja >= 80)

wybory %>% 
  filter(frekwencja >= 80) %>% 
  count()

wybory %>% 
  select(gmina) %>% 
  filter(str_detect(gmina, "Poz")) %>% 
  distinct()

obw_poznan <- wybory %>% 
  filter(gmina == "m. Poznań")






