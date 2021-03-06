library(tidyverse)

filmy <- read.csv("data/movies.csv")

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

# 
filmy %>% 
  as_tibble() %>% 
  summarise(srednia=mean(rating),
            mediana=median(rating),
            liczebnosc=n())

  
  
  
  

