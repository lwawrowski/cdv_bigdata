library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id, name))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, y = przyrost2016)

przyrost_15_17 <- inner_join(x = przyrost2015, y = przyrost2017)

przyrost_15_17_full <- full_join(x = przyrost2015, y = przyrost2017)

# podejście 1

przyrost_15_16 <- full_join(przyrost2015, przyrost2016)
przyrost_15_16_17 <- full_join(przyrost_15_16, przyrost2017)

# podejście 2 

przyrost_15_16_17 <- full_join(x = przyrost2015,
                               y = full_join(x = przyrost2016, y = przyrost2017))

# podejście 3

przyrost_15_16_17 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

# długa reprezentacja danych

przyrost_long <- przyrost_15_16_17 %>% 
  rename(podregion=name) %>% 
  pivot_longer(przyrost2015:przyrost2017)

przyrost_15_16_17 %>% 
  summarise_at(vars(przyrost2015:przyrost2017), list(srednia=mean, mediana=median), na.rm=T)

przyrost_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value, na.rm=T),
            mediana=median(value, na.rm=T))

# szeroka reprezentacja danych

przyrost_wide <- przyrost_long %>% 
  pivot_wider()

przyrost_wide <- przyrost_long %>% 
  pivot_wider(names_from = name, values_from = value)

  
  
  
  
  
  
  
  
  
  