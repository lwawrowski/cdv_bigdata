library(tidyverse)

wybory <- read_csv2("data/wybory.csv")

# filtrowanie ----

wybory_karty <- wybory %>% 
  filter(liczba_kart_waznych == 102)

wybory_woj <- wybory %>% 
  filter(wojewodztwo == "dolnośląskie")

# łączenie warunków
wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 102) %>% 
  filter(wojewodztwo == "dolnośląskie")

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 102, wojewodztwo == "dolnośląskie")

wybory_karty_woj <- wybory %>% 
  filter(liczba_kart_waznych == 102 & wojewodztwo == "dolnośląskie")

# alternatywa

wybory_karty_lub_woj <- wybory %>% 
  filter(liczba_kart_waznych == 102 | wojewodztwo == "dolnośląskie") %>% 
  select(siedziba, wojewodztwo, liczba_kart_waznych)

wybory_woj2 <- wybory %>% 
  filter(wojewodztwo == "dolnośląskie" | wojewodztwo == "śląskie")

wybory_woj2 <- wybory %>% 
  filter(wojewodztwo %in% c("dolnośląskie", "śląskie"))

wybrane_woj <- c("dolnośląskie", "śląskie")

wybory_woj2 <- wybory %>% 
  filter(wojewodztwo %in% wybrane_woj)

# fragment tekstu

wybory_kino <- wybory %>% 
  filter(grepl("Kino", siedziba))

wybory_kino <- wybory %>% 
  filter(str_detect(siedziba, "Kino|kino"))

# zadanie
movies <- read_csv(file = "http://wawrowski.edu.pl/data/movies.csv")

movies_zadanie <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration >= 120 | rating > 8.0))

movies_zadanie <- movies %>% 
  filter(genre == "Action" & year > 2010) %>% 
  filter(duration >= 120 | rating > 8.0)

# braki danych

mean(wybory$liczba_kart_waznych)

summary(wybory$liczba_kart_waznych)

mean(wybory$liczba_kart_waznych, na.rm = TRUE)

wybory_braki <- wybory %>% 
  filter(!is.na(liczba_kart_waznych))

wybory_complete <- wybory %>% 
  drop_na()

# zadanie

wybory_poznan <- wybory %>% 
  filter(gmina == "m. Poznań")

wybory_poznan <- wybory %>% 
  filter(powiat == "Poznań")
