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

# wybieranie kolumn ----

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

# nowa zmienna ----

wybory <- wybory %>% 
  mutate(frekwencja=liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych/liczba_wyborcow_uprawnionych_do_glosowania_umieszczonych_w_spisie_z_uwzglednieniem_dodatkowych_formularzy_w_chwili_zakonczenia_glosowania*100)

summary(wybory$frekwencja)

# zadanie

wybory <- wybory %>% 
  mutate(across(bartoszewicz_artur:zandberg_adrian_tadeusz,
                ~ . / liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych*100,
                .names = "{.col}_proc")) %>% 
  mutate(diff_ms_za=abs(mentzen_slawomir_jerzy_proc-zandberg_adrian_tadeusz_proc))

wybory_diff <- wybory %>% 
  select(nr_komisji:siedziba, mentzen_slawomir_jerzy_proc, zandberg_adrian_tadeusz_proc, diff_ms_za)

wybory <- wybory %>% 
  mutate(frekwencja_srednia=if_else(condition = frekwencja > mean(frekwencja, na.rm=T),
                                    true = "powyżej średniej",
                                    false = "poniżej średniej"))

wybory <- wybory %>% 
  mutate(frekwencja_kat3=case_when(
    frekwencja < 33 ~ "poniżej 33%",
    frekwencja >= 33 & frekwencja < 66 ~ "między 33% a 66%",
    frekwencja >= 66 ~ "powyżej 66%"
  ))

table(wybory$frekwencja_kat3)

wybory <- wybory %>% 
  mutate(frekwencja_kat3=case_when(
    frekwencja < 33 ~ "poniżej 33%",
    frekwencja >= 66 ~ "powyżej 66%",
    is.na(frekwencja) ~ "brak danych",
    .default = "między 33% a 66%"
  ))

table(wybory$frekwencja_kat3)

# podsumowanie ----

wybory_stat <- wybory %>% 
  summarise(srednia=mean(frekwencja, na.rm=T),
            minimum=min(frekwencja, na.rm=T),
            maksimum=max(frekwencja, na.rm=T))

wybory_stat

kandydaci_stat <- wybory %>% 
  summarise(across(bartoszewicz_artur_proc:zandberg_adrian_tadeusz_proc,
                   list(srednia = ~ mean(., na.rm=T),
                        minimum = ~ min(., na.rm=T),
                        maksimum = ~ max(., na.rm=T))))

# grupowanie ----

liczba_glos_powiat <- wybory %>% 
  group_by(powiat) %>% 
  summarise(srednia=mean(liczba_glosow_waznych_oddanych_lacznie_na_wszystkich_kandydatow_z_kart_waznych, na.rm=T)) %>% 
  arrange(desc(srednia))

# wybory
# liczba_glos_powiat

frekwencja_woj <- wybory %>% 
  group_by(wojewodztwo, frekwencja_srednia) %>% 
  summarise(liczba=n())

wybory %>% 
  group_by(frekwencja_kat3) %>% 
  summarise(liczba=n())

wybory %>% 
  count(frekwencja_kat3)

# zadanie

woj_niewazne <- wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(liczba=n(),
            srednia=mean(liczba_glosow_niewaznych_z_kart_waznych, na.rm=T))

wybory_zagranica <- wybory %>% 
  filter(gmina == "zagranica") %>% 
  mutate(
    kraj = str_split_i(siedziba, ",", -1) %>% str_trim(),
    miasto = str_split_i(siedziba, ",", -2) %>% str_trim()
  ) %>% 
  count(kraj, miasto) %>% 
  arrange(desc(n))
