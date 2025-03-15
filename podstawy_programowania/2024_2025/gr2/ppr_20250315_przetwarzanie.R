library(tidyverse)

wybory <- read_csv2("data/wybory.csv")
load("data/wybory.RData")

# filtrowanie -------------------------------------------------------------

wybory_karty <- wybory %>%
  filter(liczba_kart_waznych == 777)

wybory_woj <- wybory %>% 
  filter(wojewodztwo == "pomorskie")

# koniunkcja warunków

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 777) %>% 
  filter(wojewodztwo == "pomorskie")

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 777, wojewodztwo == "pomorskie")

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 777 & wojewodztwo == "pomorskie")

# alternatywa

wybory_karty_woj_alt <- wybory %>% 
  filter(liczba_kart_waznych == 777 | wojewodztwo == "pomorskie")

wybory_karty_woj2 <- wybory %>% 
  filter(liczba_kart_waznych == 777 & (wojewodztwo == "pomorskie" | wojewodztwo == "kujawsko-pomorskie"))

wybory_karty_woj2 <- wybory %>% 
  filter(liczba_kart_waznych == 777 & wojewodztwo %in% c("pomorskie", "kujawsko-pomorskie"))

wybrane_woj <- c("pomorskie", "kujawsko-pomorskie", "podlaskie")

wybory_karty_woj2 <- wybory %>% 
  filter(liczba_kart_waznych == 777 & wojewodztwo %in% wybrane_woj)

# negacja

wybory_karty_woj_neg <- wybory %>% 
  filter(liczba_kart_waznych == 777 & !wojewodztwo %in% wybrane_woj)

# zadanie

movies <- read_csv("data/movies.csv")
movies_zad <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration >= 120 | rating > 8))

# braki danych

wybory_braki <- wybory %>% 
  filter(!is.na(teryt_gminy))

summary(wybory_braki$teryt_gminy)

wybory_braki_woj <- wybory %>% 
  filter(is.na(wojewodztwo))

sum(complete.cases(wybory))

# nie do końca poprawne
wybory_cc <- wybory %>% 
  filter(complete.cases(wybory))

# . oznacza aktualnie przetwarzany zbiór
wybory_cc <- wybory %>% 
  filter(complete.cases(.))

wybory_cc <- wybory %>% 
  select(liczba_kart_waznych, wojewodztwo) %>% 
  filter(complete.cases(.))

summary(wybory_cc)