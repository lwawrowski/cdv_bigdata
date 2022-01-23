library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, 
                            by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, y = przyrost2016)

przyrost_15_17 <- inner_join(x = przyrost2015, y = przyrost2017)

# podejscie 1
przyrost1516 <- full_join(przyrost2015, przyrost2016)
przyrost151617 <- full_join(przyrost1516, przyrost2017)

# podejscie 2
przyrost151617 <- full_join(przyrost2015, full_join(przyrost2016, przyrost2017))

# podejscie 3
przyrost151617 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(x = ., y = przyrost2017) 

# zadanie

summary(bezrobocie)
summary(pod_10tys)
summary(wyn)

# zmiana danych wejściowych
bezrobocie_num <- bezrobocie %>% 
  mutate(id_powiat=as.numeric(id_powiat))

pod_10tys_num <- pod_10tys %>% 
  mutate(pow=as.numeric(pow))

dane <- inner_join(pod_10tys_num, wyn, by = "pow") %>% 
  inner_join(., bezrobocie_num, by = c("pow" = "id_powiat"))

# optymalnie
# z kropką oznaczającą aktualnie przetwarzany zbiór
dane <- inner_join(bezrobocie, pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(pow=as.numeric(id_powiat)) %>% 
  inner_join(x = ., y = wyn) %>% 
  select(-pow)

# bez kropki
dane_wstepne <- inner_join(bezrobocie, pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(pow=as.numeric(id_powiat))

dane_ostateczne <- inner_join(x = dane_wstepne, y = wyn) %>% 
  select(-pow)

# składnia z $
dane$stopa_bezr

# składnia z %>% 
dane %>% .$stopa_bezr

# reprezentacja danych

dane_long <- dane %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_long <- dane %>% 
  pivot_longer(-id_powiat)

dane %>% 
  summarise(srednia_bezr=mean(stopa_bezr),
            srednia_przed=mean(pod_10tys),
            srednia_wyn=mean(wynagrodzenie))

dane_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value))

dane_wide <- dane_long %>% 
  pivot_wider(names_from = name, values_from = value)


















