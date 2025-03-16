library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id, name))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, przyrost2016)

przyrost_15_17 <- inner_join(przyrost2015, przyrost2017)

przyrost_15_17a <- anti_join(przyrost2015, przyrost2017)

przyrost_17_15a <- anti_join(przyrost2017, przyrost2015)

przyrost_15_17_full <- full_join(przyrost2015, przyrost2017)

# wszystkie zbiory

# 1 sposób
przyrost_15_16 <- full_join(przyrost2015, przyrost2016)
przyrost_15_16_17 <- full_join(przyrost_15_16, przyrost2017)

# 2 sposób
przyrost_15_16_17 <- full_join(x = przyrost2015, 
                               y = full_join(x = przyrost2016, y = przyrost2017))

# 3 sposób
przyrost_15_16_17 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(y = przyrost2017)

przyrost_15_16_17 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

przyrost_15_16_17 <- przyrost2015 %>% 
  full_join(przyrost2016) %>% 
  full_join(przyrost2017)

# zadanie

summary(bezrobocie)
summary(pod_10tys)
summary(wyn)

bezr_pod_wyn <- inner_join(bezrobocie, pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(pow=as.numeric(id_powiat)) %>% 
  inner_join(wyn) %>% 
  select(-pow)

# długa reprezentacja danych ----------------------------------------------

bezr_pod_wyn %>% 
  summarise_at(vars(stopa_bezr:wynagrodzenie), list(srednia=mean, mediana=median))

dane_long <- bezr_pod_wyn %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value),
            mediana=median(value))

# szeroka reprezentacja danych

dane_wide <- dane_long %>% 
  pivot_wider()

dane_wide <- dane_long %>% 
  pivot_wider(names_from = name, values_from = value, names_prefix = "rok2018_")

