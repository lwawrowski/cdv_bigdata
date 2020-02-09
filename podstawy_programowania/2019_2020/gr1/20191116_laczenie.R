library(tidyverse)

filmy <- read_csv("data/movies.csv")

przygodowe <- filmy %>% 
  filter(genre == "Adventure")

filmy %>% 
  count(genre) %>% 
  filter(genre == "Adventure")

# łączenie danych
load("data/gus.RData")

przyrost16_15 <- left_join(x = przyrost2016, 
                           y = przyrost2015, by = "id")

przyrost15_17 <- inner_join(x = przyrost2015,
                            y = przyrost2017)

przyrost151617 <- full_join(x = przyrost2015, 
                            y = full_join(x = przyrost2016, 
                                          y = przyrost2017))

przyrost151617 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

# zadanie

dane_gus <- inner_join(bezrobocie, pod_10tys,
                       by = c("id_powiat"="pow")) %>%
  mutate(pow=as.numeric(id_powiat)) %>%
  inner_join(x = ., y = wyn, by = "pow") %>% 
  select(-pow)

# źle
wyn_chr <- wyn %>%
  mutate(id_powiat=as.character(pow))

wyn_bezr <- inner_join(bezrobocie, wyn_chr)

# dobrze
wyn_chr <- wyn %>%
  mutate(id_powiat=sprintf("%04d", pow))

wyn_bezr <- inner_join(bezrobocie, wyn_chr)

# szeroka i wąska reprezentacja danych

summary(dane_gus)

dane_gus %>%
  summarise(sr_bezr=mean(stopa_bezr),
            sr_pod10tys=mean(pod_10tys),
            sr_wynagrodzenie=mean(wynagrodzenie))

dane_gus_long <- dane_gus %>% 
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_gus_long %>%
  group_by(name) %>%
  summarise(srednia=mean(value))

dane_gus_wide <- dane_gus_long %>% 
  pivot_wider()