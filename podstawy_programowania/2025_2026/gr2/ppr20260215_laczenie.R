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

# łączenie trzech zbiorów

przyrost_15_16_17 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(przyrost2017)

przyrost_15_16_17 <- przyrost2015 %>% 
  full_join(przyrost2016) %>% 
  full_join(przyrost2017)

# zadanie

summary(bezrobocie)
summary(pod_10tys)
summary(wyn)

gus <- inner_join(bezrobocie, pod_10tys, by = c("id_powiat" = "pow")) %>% 
  mutate(id_powiat_num=as.numeric(id_powiat)) %>% 
  inner_join(wyn, c("id_powiat_num" = "pow")) %>% 
  select(-id_powiat_num)

gus2 <- wyn %>%
  # 1. Naprawiamy TERYT w zbiorze 'wyn': zamiana na tekst i dodanie zera na początku
  mutate(pow = str_pad(as.character(pow), width = 4, side = "left", pad = "0")) %>%
  # 2. Łączymy z 'bezrobocie' (używając różnych nazw kluczy)
  full_join(bezrobocie, by = c("pow" = "id_powiat")) %>%
  # 3. Łączymy z 'pod_10tys' (klucze nazywają się tak samo)
  full_join(pod_10tys, by = "pow")

# długa reprezentacja danych

gus_long <- gus %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

gus %>% 
  summarise(across(stopa_bezr:wynagrodzenie,
                   list(srednia = ~ mean(.),
                        mediana = ~ median(.))))

gus_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value),
            mediana=median(value))

# szeroka reprezentacja danych

gus_wide <- gus_long %>% 
  pivot_wider(names_from = name, values_from = value)
