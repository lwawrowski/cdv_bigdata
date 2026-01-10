library(tidyverse)

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id, name))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, y = przyrost2016)

przyrost_15_17 <- inner_join(przyrost2015, przyrost2017)

przyrost_15_17a <- anti_join(przyrost2015, przyrost2017)

przyrost_17_15a <- anti_join(przyrost2017, przyrost2015)

przyrost_15_17f <- full_join(przyrost2015, przyrost2017)

# łącznie trzech zbiorów

# 1 sposób
przyrost_15_16 <- full_join(przyrost2015, przyrost2016)
przyrost_15_16_17 <- full_join(przyrost_15_16, przyrost2017)

# 2 sposób
przyrost_15_16_17 <- full_join(przyrost2015, full_join(przyrost2016, przyrost2017))

# 3 sposób
przyrost_15_16_17 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(przyrost2017)

przyrost_15_16_17 <- przyrost2015 %>% 
  full_join(przyrost2016) %>% 
  full_join(przyrost2017)

# zadanie

summary(bezrobocie)
summary(pod_10tys)
summary(wyn)

dane_final <- inner_join(bezrobocie, pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(pow_num=as.numeric(id_powiat)) %>% 
  inner_join(wyn, by = c("pow_num" = "pow")) %>% 
  select(-pow_num)

wyn1 <- wyn %>% 
  mutate(id_powiat=str_pad(string = pow, width = 4, side = "left", pad = "0"))

# reprezentacja długa

dane_final_long <- dane_final %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_final %>% 
  summarise(across(stopa_bezr:wynagrodzenie, 
                   list(srednia = ~ mean(.),
                        mediana = ~ median(.))))

dane_final_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value),
            mediana=median(value))

# reprezentacja szeroka

dane_final_wide <- dane_final_long %>% 
  pivot_wider(names_from = name, values_from = value)

