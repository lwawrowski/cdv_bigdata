library(tidyverse)

wybory <- read_csv2(file = "data/wybory.csv")


# filtrowanie -------------------------------------------------------------

wybory_karty <- wybory %>% 
  filter(liczba_kart_waznych == 330)

wybory_woj <- wybory %>% 
  filter(wojewodztwo == "zachodniopomorskie") %>% 
  select(wojewodztwo, liczba_kart_waznych) 

# koniunkcja warunków

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 330) %>% 
  filter(wojewodztwo == "zachodniopomorskie") %>% 
  select(siedziba, wojewodztwo, liczba_kart_waznych) 

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 330, wojewodztwo == "zachodniopomorskie") %>% 
  select(siedziba, wojewodztwo, liczba_kart_waznych) 

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 330 & wojewodztwo == "zachodniopomorskie") %>% 
  select(siedziba, wojewodztwo, liczba_kart_waznych)

# alternatywa

wybory_karty_lub_woj <- wybory %>% 
  filter(liczba_kart_waznych == 330 | wojewodztwo == "zachodniopomorskie") %>% 
  select(siedziba, wojewodztwo, liczba_kart_waznych)

wybory_woj2 <- wybory %>% 
  filter(wojewodztwo == "zachodniopomorskie" | wojewodztwo == "pomorskie")

wybory_woj2 <- wybory %>% 
  filter(wojewodztwo %in% c("zachodniopomorskie", "pomorskie"))

wybrane_woj <- c("zachodniopomorskie", "pomorskie", "kujawsko-pomorskie")

wybory_woj3 <- wybory %>% 
  filter(wojewodztwo %in% wybrane_woj) 

# 
wybory_liceum <- wybory %>% 
  filter(grepl("Liceum", siedziba))

wybory_liceum_v1 <- wybory %>% 
  filter(str_detect(siedziba, "Liceum|liceum"))

wybory_liceum_v2 <- wybory %>% 
  filter(str_detect(str_to_lower(siedziba), "liceum"))

wybory_liceum_v2 <- wybory %>% 
  mutate(siedziba_lower=str_to_lower(siedziba)) %>% 
  filter(str_detect(siedziba_lower, "liceum"))

wybory_liceum_roznica <- wybory_liceum_v2 %>% 
  filter(!siedziba %in% wybory_liceum_v1$siedziba)

# zadanie
movies <- read_csv(file = "http://wawrowski.edu.pl/data/movies.csv")

movies_zadanie <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration >= 120 | rating > 8.0))

movies_zadanie <- movies %>% 
  filter(genre == "Action", year > 2010, duration >= 120 | rating > 8.0)

movies_zadanie <- movies %>% 
  filter(genre == "Action" & year > 2010) %>% 
  filter(duration >= 120 | rating > 8.0)

# braki danych

summary(wybory$liczba_kart_waznych)

mean(wybory$liczba_kart_waznych, na.rm = TRUE)

wybory_pl <- wybory %>% 
  filter(!is.na(teryt_gminy))

summary(wybory_pl)

summary(wybory)

sum(complete.cases(wybory))

# nie do końca poprawne
wybory_cc <- wybory %>% 
  filter(complete.cases(wybory))

# . oznacza aktualnie przetwarzany zbiór
wybory_cc <- wybory %>% 
  filter(complete.cases(.))










