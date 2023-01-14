library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, y = przyrost2016)

przyrost_15_17 <- inner_join(x = przyrost2015, y = przyrost2017)

# podejście 1
przyrost_15_16 <- full_join(x = przyrost2015, y = przyrost2016)
przyrost_15_16_17 <- full_join(x = przyrost_15_16, y = przyrost2017)

# podejście 2
przyrost_15_16_17 <- full_join(x = przyrost2015, y = full_join(x = przyrost2016, y = przyrost2017))
przyrost_15_16_17 <- full_join(przyrost2015, full_join(przyrost2016, przyrost2017))

# podejście 3
przyrost_15_16_17 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017) 

# zadanie

summary(bezrobocie)
summary(pod_10tys)
summary(wyn)

# podejście 1
bezr_pod_10tys <- inner_join(x = bezrobocie, y = pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(id_powiat=as.numeric(id_powiat))

bezr_pod_10tys_wyn <- inner_join(x = bezr_pod_10tys, y = wyn, by = c("id_powiat" = "pow"))

# podejście 2
dane <- inner_join(x = bezrobocie, y = pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(id_powiat=as.numeric(id_powiat)) %>% 
  inner_join(x = ., y = wyn, by = c("id_powiat" = "pow"))


# reprezentacja długa -----------------------------------------------------

dane_long <- dane %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

(ncol(dane)-1)*nrow(dane)

dane_long <- dane %>% 
  pivot_longer(-id_powiat)

dane %>% 
  summarise(srednia_stopa=mean(stopa_bezr),
            srednia_liczba_pod=mean(pod_10tys),
            srednie_wyn=mean(wynagrodzenie))

dane_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value),
            mediana=median(value))

dane_wide <- dane_long %>% 
  pivot_wider(names_from = name, values_from = value)
