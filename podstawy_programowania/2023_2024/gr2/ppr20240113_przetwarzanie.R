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

# Ile obwodów głosowania miało frekwencję powyżej 80%?

frekwencja80 <- wybory %>% 
  filter(frekwencja > 80)

wybory <- wybory %>% 
  rename(bs=komitet_wyborczy_bezpartyjni_samorzadowcy,
         td=koalicyjny_komitet_wyborczy_trzecia_droga_polska_2050_szymona_holowni_polskie_stronnictwo_ludowe,
         nl=komitet_wyborczy_nowa_lewica,
         pis=komitet_wyborczy_prawo_i_sprawiedliwosc,
         konf=komitet_wyborczy_konfederacja_wolnosc_i_niepodleglosc,
         ko=koalicyjny_komitet_wyborczy_koalicja_obywatelska_po_n_ipl_zieloni)

# sposób 1
wybory <- wybory %>% 
  mutate(bs_proc=bs/liczba_kart_waznych,
         td_proc=td/liczba_kart_waznych,
         nl_proc=nl/liczba_kart_waznych,
         pis_proc=pis/liczba_kart_waznych,
         konf_proc=konf/liczba_kart_waznych,
         ko_proc=ko/liczba_kart_waznych)

# sposób 2
wybory <- wybory %>% 
  mutate_at(.vars = vars(bs:ko), .funs = list(proc = ~./liczba_kart_waznych*100))

# Gdzie była największa różnica pomiędzy wybranymi partiami?

wybory_roznica <- wybory %>% 
  select(siedziba, td_proc, ko_proc) %>% 
  mutate(roznica=td_proc-ko_proc)

# podsumowania ----

wybory %>% 
  summarise(srednia=mean(liczba_wyborcow_uprawnionych_do_glosowania, na.rm = TRUE),
            mediana=median(liczba_wyborcow_uprawnionych_do_glosowania, na.rm = TRUE),
            liczebnosc=n())

summary(wybory$liczba_wyborcow_uprawnionych_do_glosowania)

wybory %>% 
  summarise_at(vars(liczba_wyborcow_uprawnionych_do_glosowania),
               list(srednia = mean, mediana = median), na.rm = TRUE)

komitety_stat <- wybory %>% 
  summarise_at(vars(bs_proc:ko_proc),
               list(srednia = mean, mediana = median), na.rm = TRUE)

# zadanie

wybory %>% 
  summarise(srednia=mean(frekwencja, na.rm = TRUE),
            mediana=median(frekwencja, na.rm = TRUE),
            odchylenie=sd(frekwencja, na.rm = TRUE))

wybory %>% 
  summarise_at(vars(frekwencja),
               list(srednia = mean, mediana = median, odchylenie = sd), na.rm = TRUE)

# grupowanie ----

liczba_wyborcow_powiat <- wybory %>% 
  group_by(powiat) %>% 
  summarise(srednia=mean(liczba_wyborcow_uprawnionych_do_glosowania, na.rm=TRUE))

koperty_woj <- wybory %>% 
  group_by(wojewodztwo, liczba_kopert_zwrotnych_w_ktorych_oswiadczenie_nie_bylo_podpisane) %>% 
  summarise(liczba=n())

woj <- wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(liczba=n())

woj2 <- wybory %>% 
  count(wojewodztwo) %>% 
  arrange(desc(n))

# Jaka była średnia frekwencja w województwach?

wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(mean(frekwencja))

# W jakich miastach za granicą utworzono najwięcej obwodów głosowania?

zagranica <- wybory %>% 
  filter(powiat == "zagranica") %>% 
  count(gmina) %>% 
  arrange(desc(n)) %>% 
  filter(n > 2)











