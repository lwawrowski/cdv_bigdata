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


# wybór kolumn ------------------------------------------------------------

wybory_kolumny <- wybory %>% 
  select(-wojewodztwo, -liczba_niewykorzystanych_kart_do_glosowania)

wybory_kolumny <- wybory %>% 
  select(-c(wojewodztwo, liczba_niewykorzystanych_kart_do_glosowania))

wybory_kolumny <- wybory %>% 
  select(nr_komisji:wojewodztwo)

wybory_kolumny <- wybory %>% 
  select(wojewodztwo:nr_komisji)

wybory_liczba <- wybory %>% 
  select(starts_with("liczba"))

wybory_kart <- wybory %>% 
  select(contains("kart"))

wybory_num <- wybory %>% 
  select_if(is.numeric)

# zmiana nazwy kolumny ----------------------------------------------------

wybory_siedziba <- wybory %>% 
  rename(siedziba_komisji=siedziba) %>% 
  rename_with(toupper)


# nowe kolumny ------------------------------------------------------------

wybory <- wybory %>% 
  mutate(frekwencja=liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych/liczba_wyborcow_uprawnionych_do_glosowania_umieszczonych_w_spisie_z_uwzglednieniem_dodatkowych_formularzy_w_chwili_zakonczenia_glosowania*100)

summary(wybory$frekwencja)

# zadanie

wybory <- wybory %>% 
  mutate(bartoszewicz_artur_proc=bartoszewicz_artur/liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych,
         biejat_magdalena_agnieszka_proc=biejat_magdalena_agnieszka/liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych,
         braun_grzegorz_michal_proc=braun_grzegorz_michal/liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych)

wybory <- wybory %>% 
  mutate(across(bartoszewicz_artur:zandberg_adrian_tadeusz,
                ~ . / liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych*100,
                .names = "{.col}_proc"))

wybory <- wybory %>% 
  mutate(frekwencja_kat2=if_else(condition = frekwencja > 64, 
                                 true = "powyżej średniej", 
                                 false = "poniżej średniej"))

wybory <- wybory %>% 
  mutate(frekwencja_kat4=case_when(
    frekwencja < 25 ~ "poniżej 25",
    frekwencja >= 25 & frekwencja < 50 ~ "między 25 a 50",
    frekwencja >= 50 & frekwencja < 75 ~ "między 50 a 75",
    frekwencja > 75 ~ "powyżej 75"
  ))


# podsumowanie danych -----------------------------------------------------

wybory_stat <- wybory %>% 
  summarise(srednia=mean(liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych, na.rm=T),
            minimum=min(liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych, na.rm=T),
            maksimum=max(liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych, na.rm=T))

kandydaci_stat <- wybory %>% 
  summarise(across(bartoszewicz_artur:zandberg_adrian_tadeusz,
                   list(srednia = ~ mean(., na.rm=T),
                        minimum = ~ min(., na.rm=T),
                        maksimum = ~ max(., na.rm=T))))

# grupowanie --------------------------------------------------------------

liczba_glos_powiat <- wybory %>% 
  group_by(powiat) %>% 
  summarise(srednia=mean(liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych, na.rm=T)) %>% 
  arrange(desc(srednia))

# wybory
# liczba_glos_powiat

frekwencja_woj <- wybory %>% 
  group_by(wojewodztwo, frekwencja_kat2) %>% 
  summarise(liczba=n()) %>% 
  drop_na()

wybory %>% 
  group_by(frekwencja_kat4) %>% 
  summarise(liczba=n())

wybory %>% 
  count(frekwencja_kat4)













