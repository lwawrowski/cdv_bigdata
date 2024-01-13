library(tidyverse)

load("data/wybory.rda")

wybory <- read_csv2("data/wybory.csv")

# Ile obwodów głosowania miało frekwencję powyżej 80%?
# Ile obwodów głosowania znajduje się w Poznaniu?
# Jaka była średnia frekwencja w województwach?
# Gdzie była największa różnica pomiędzy wybranymi partiami?
# W jakich miastach za granicą utworzono najwięcej obwodów głosowania?

# filtrowanie ----

karty_wazne_1000 <- wybory %>% 
  filter(liczba_kart_waznych > 1000)

wybory_wlkp <- wybory %>% 
  filter(wojewodztwo == "wielkopolskie")

# operatory

# koniunkcja
wybory_wlkp_1000 <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo == "wielkopolskie")

wybory_wlkp_1000 <- wybory %>% 
  filter(liczba_kart_waznych > 1000, 
         wojewodztwo == "wielkopolskie")

# alternatywa
wybory_wlkp_1000_alt <- wybory %>% 
  filter(liczba_kart_waznych > 1000 | wojewodztwo == "wielkopolskie") %>% 
  select(liczba_kart_waznych, wojewodztwo)

# %in%

wybory_wlkp_sl_1000_m1 <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & (wojewodztwo == "wielkopolskie" | wojewodztwo == "śląskie")) %>% 
  select(liczba_kart_waznych, wojewodztwo)

wybory_wlkp_sl_1000_m2 <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo %in% c("wielkopolskie", "śląskie")) %>% 
  select(liczba_kart_waznych, wojewodztwo)

wybrane_woj <- c("wielkopolskie", "śląskie")
# python
# wybrane_woj = ["wielkopolskie", "śląskie"]

wybory_wlkp_sl_1000_m3 <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo %in% wybrane_woj) %>% 
  select(liczba_kart_waznych, wojewodztwo)

# zadanie

movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")

movies_zad <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration >= 120 | rating > 8))

# braki danych

summary(wybory)

wybory_braki <- wybory %>% 
  filter(!is.na(teryt_gminy))

summary(wybory_braki)

complete.cases(wybory)

wybory_cc <- wybory %>% 
  filter(complete.cases(wybory))

# operator .
# . - aktualnie przetwarzany zbiór

wybory_cc <- wybory %>% 
  filter(complete.cases(.))

wybory_cc_woj <- wybory %>% 
  select(liczba_kart_waznych, wojewodztwo) %>% 
  filter(complete.cases(.))

# wybieranie kolumn -------------------------------------------------------

wybrane_kolumny <- wybory %>% 
  select(wojewodztwo, liczba_kart_waznych)

wybrane_kolumny <- wybory %>% 
  select(-wojewodztwo, -liczba_kart_waznych)

wybrane_kolumny <- wybory %>% 
  select(-c(wojewodztwo, liczba_kart_waznych))

wybrane_kolumny <- wybory %>%
  select(wojewodztwo:liczba_kart_waznych)

wybrane_kolumny <- wybory %>%
  select(starts_with("liczba"))

# Ile obwodów głosowania znajduje się w Poznaniu?

wybory_poz <- wybory %>% 
  filter(powiat == "Poznań")

wybory %>% 
  filter(powiat == "Poznań")


# zmiana nazwy ------------------------------------------------------------

wybory_siedziba <- wybory %>% 
  rename(siedziba_komisji=siedziba)


# modyfikacja kolumn ------------------------------------------------------

wybory <- wybory %>% 
  mutate(frekwencja=liczba_wyborcow_ktorym_wydano_karty_do_glosowania/liczba_wyborcow_uprawnionych_do_glosowania*100)

summary(wybory$frekwencja)





