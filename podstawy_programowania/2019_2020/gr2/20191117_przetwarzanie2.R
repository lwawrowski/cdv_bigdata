library(tidyverse)

filmy <- read_csv("data/movies.csv")

przygodowe <- filmy %>% 
  filter(genre == "Adventure")

# braki danych

is.na(5)
is.na(NA)

1/0 # Inf
sqrt(-1) #NaN
NULL

load("data/pgss.RData")

bezbrakow_q34 <- pgss %>% 
  filter(!is.na(q34))

complete.cases(pgss)

bezbrakow <- pgss %>%
  filter(complete.cases(pgss))

c(1,2,3,NULL,4,5)

bezbrakow <- pgss %>%
  filter_all(all_vars(!is.na(.)))

# wybieranie kolumn

filmy3 <- filmy %>% 
  select(title, year, genre) %>% 
  filter(genre == "Drama")

filmy3 <- filmy %>% 
  filter(genre == "Drama") %>% 
  select(title, year) %>%
  rename(tytul=title, rok=year)

filmy <- filmy %>% 
  mutate(dur_hour=round(duration/60,2))

filmy <- filmy %>%
  mutate(dur_hour=duration/60,
         dur_hour=round(dur_hour,2),
         age=2019-year)

Sys.Date()

filmy <- filmy %>%
  mutate(dur_hour=duration/60,
         dur_hour=round(dur_hour,2),
         age=as.integer(format(Sys.Date(),"%Y"))-year)

# podsumowanie
filmy %>% 
  as_tibble() %>% 
  summarise(srednia=mean(rating),
            mediana=median(rating),
            liczebnosc=n())

# zadanie
filmy %>% 
  summarise(sr_czas=mean(duration),
            med_czas=median(duration),
            odch_czas=sd(duration))

genre_duration <- filmy %>% 
  group_by(genre) %>% 
  summarise(sr_czas=mean(duration),
            liczba_filmow=n())

# zliczanie
filmy %>%
  count(genre)

filmy %>% 
  group_by(genre) %>% 
  summarise(n=n())

director_genre <- filmy %>%
  count(director, genre)

# zadanie
dir_year <- filmy %>%
  filter(year >= 2000, year <= 2010) %>% 
  group_by(year) %>% 
  summarise(srednia_ocena=mean(rating),
            liczba=n()) %>% 
  arrange(desc(liczba))

# łączenie danych

load("data/gus.RData")

przyrost16_17 <- left_join(x = przyrost2016,
                           y = przyrost2017)

przyrost16_17r <- right_join(x = przyrost2016,
                             y = przyrost2017,
                             by = c("id"="id", "name"))

przyrost15_17 <- inner_join(x = przyrost2015,
                            y = przyrost2017)

przyrost151617 <- full_join(x = przyrost2015,
                            y = full_join(x = przyrost2016,
                                          y = przyrost2017))

przyrost151617 <- full_join(x = przyrost2015, y = przyrost2016) %>% 
  full_join(x = ., y = przyrost2017)

# zadanie
dane_gus <- inner_join(x = bezrobocie,
                       y = pod_10tys,
                       by = c("id_powiat"="pow")) %>%
  mutate(pow=as.numeric(id_powiat)) %>%
  inner_join(x = ., y = wyn) %>% 
  select(-pow)

# szeroka i wąska reprezentacja danych
dane_gus %>%
  summarise(srednia_bezr=mean(stopa_bezr),
            srednia_pod10tys=mean(pod_10tys),
            srednia_wynagr=mean(wynagrodzenie))

dane_gus_long <- dane_gus %>%
  pivot_longer(stopa_bezr:wynagrodzenie)

dane_gus_long %>%
  group_by(name) %>%
  summarise(srednia=mean(value))

dane_gus_wide <- dane_gus_long %>%
  pivot_wider()

# przykład z reżyserem i gatunkiem
director_genre <- filmy %>%
  count(director, genre)

dir_genre_wide <- director_genre %>%
  pivot_wider(names_from = genre, values_from = n)


















  
  
  
  

