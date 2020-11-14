library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17r <- right_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_15_17 <- inner_join(x = przyrost2015, y = przyrost2017)

# 1 podejście
przyrost1516 <- full_join(x = przyrost2015, y = przyrost2016)
przyrost151617 <- full_join(x = przyrost1516, y = przyrost2017)

# 2 podejście
przyrost151617 <- full_join(x = przyrost2015, y = full_join(x = przyrost2016, y = przyrost2017))

# 3 podejście
przyrost151617 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

# zadanie

dane_gus <- inner_join(x = bezrobocie, y = pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(id_powiat=as.numeric(id_powiat)) %>% 
  inner_join(x = ., y = wyn, by = c("id_powiat" = "pow"))

dane_gus2 <- wyn %>% 
  mutate(pow = sprintf("%04d", pow)) %>% 
  inner_join(x = ., y = pod_10tys) %>% 
  inner_join(x = ., y = bezrobocie, by = c("pow" = "id_powiat"))

# reprezentacje danych

dane_gus %>% 
  summarise(srednia_bezr=mean(stopa_bezr),
            srednia_pod=mean(pod_10tys),
            srednia_wyn=mean(wynagrodzenie))

dane_gus_long <- dane_gus %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_gus_long <- dane_gus %>% 
  pivot_longer(-id_powiat)

dane_gus_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value))

dane_gus_wide <- dane_gus_long %>% 
  pivot_wider()

dane_gus_wide <- dane_gus_long %>% 
  pivot_wider(id_cols = id_powiat, names_from = name, values_from = value)




