library(tidyverse)

smog <- read_csv2("data/smog_pszczyna.csv")

smog <- smog %>% 
  mutate(pm10_poziom=if_else(condition = pm10 < 50, true = "w normie", false = "podwyższony"),
         tmin_zero=if_else(tmin_daily < 0, "poniżej 0", "powyżej 0"))

ggplot(data = smog, mapping = aes(x = tmax_daily, y = tmin_daily)) +
  geom_point()

smog2017 <- smog %>%  
  filter(rok == 2017)
