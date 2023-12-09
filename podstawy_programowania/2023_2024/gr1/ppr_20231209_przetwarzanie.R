library(tidyverse)

load("data/wybory.rda")
wybory <- read_csv("data/wybory.csv")

# ponad 1000 ważnych kart

wybory_1000kart <- wybory %>% 
  filter(liczba_kart_waznych > 1000)

# obwody w woj. dolnośląskim

# %>% ctrl + shift + m

wybory_dolsl <- wybory %>% 
  filter(wojewodztwo == "dolnośląskie")

# koniunkcja
wybory_1000kart_dolsl <- wybory %>% 
  filter(liczba_kart_waznych > 1000, wojewodztwo == "dolnośląskie")

wybory_1000kart_dolsl <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo == "dolnośląskie")

# alternatywa
wybory_1000kart_dolsl <- wybory %>% 
  filter(liczba_kart_waznych > 1000 | wojewodztwo == "dolnośląskie") %>% 
  select(wojewodztwo, liczba_kart_waznych)

# %in%
wybory_1000kart_dolsl_sl <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & (wojewodztwo == "dolnośląskie" | wojewodztwo == "śląskie")) %>% 
  select(wojewodztwo, liczba_kart_waznych)

wybory_1000kart_dolsl_sl <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo %in% c("dolnośląskie", "śląskie")) %>% 
  select(wojewodztwo, liczba_kart_waznych)

wybrane_woj <- c("dolnośląskie", "śląskie")

wybory_nie_1000kart_dolsl_sl <- wybory %>% 
  filter(!liczba_kart_waznych > 1000 & !wojewodztwo %in% wybrane_woj) %>% 
  select(wojewodztwo, liczba_kart_waznych)

# zadanie 
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")

movies_zad <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration > 120 | rating > 8))

# braki danych

wybory_braki <- wybory %>% 
  filter(!is.na(teryt_gminy))

wybory_braki_chr <- wybory %>% 
  filter(!is.na(wojewodztwo))

complete.cases(wybory)

wybory_cc <- wybory %>% 
  filter(complete.cases(wybory))

# . - aktualnie przetwarzany zbiór
wybory_cc <- wybory %>% 
  filter(complete.cases(.))

# modyfikacja zbioru w pipeline
wybory_cc <- wybory %>% 
  select(wojewodztwo, liczba_kart_waznych) %>% 
  filter(complete.cases(.))

# select - wybieranie kolumn ----

wybory_kolumny <- wybory %>% 
  select(siedziba, liczba_glosow_niewaznych)

wybory_kolumny <- wybory %>% 
  select(-siedziba, -liczba_glosow_niewaznych)

wybory_kolumny <- wybory %>% 
  select(-c(siedziba, liczba_glosow_niewaznych))

wybory_kolumny <- wybory %>% 
  select(siedziba:wojewodztwo)

wybory %>% 
  select(siedziba:wojewodztwo)

wybory_liczba <- wybory %>% 
  select(starts_with("liczba"))

# kolejność w przetwarzaniu potokowym

# dobrze
wybory %>% 
  filter(liczba_glosow_niewaznych > 100) %>% 
  select(siedziba)

# błąd
wybory %>% 
  select(siedziba) %>% 
  filter(liczba_glosow_niewaznych > 100)

# rename 

wybory_siedziba <- wybory %>% 
  rename(siedziba_komisji=siedziba)

wybory %>% 
  select(siedziba_komisji=siedziba)

# mutate

wybory <- wybory %>% 
  mutate(frekwencja=liczba_kart_wyjetych_z_urny/liczba_wyborcow_uprawnionych_do_glosowania*100) %>% 
  rename(bs=komitet_wyborczy_bezpartyjni_samorzadowcy,
         td=koalicyjny_komitet_wyborczy_trzecia_droga_polska_2050_szymona_holowni_polskie_stronnictwo_ludowe,
         nl=komitet_wyborczy_nowa_lewica,
         pis=komitet_wyborczy_prawo_i_sprawiedliwosc,
         konf=komitet_wyborczy_konfederacja_wolnosc_i_niepodleglosc,
         ko=koalicyjny_komitet_wyborczy_koalicja_obywatelska_po_n_ipl_zieloni)

summary(wybory$frekwencja)

# możliwe problemy
wybory_zepsute <- wybory

wybory_zepsute <- wybory_zepsute %>% 
  mutate(frekwencja=frekwencja/100)

summary(wybory_zepsute$frekwencja)

# Ile obwodów głosowania miało frekwencję powyżej 80%?

wybory %>% 
  filter(frekwencja > 80)

# Ile obwodów głosowania znajduje się w Poznaniu?

wybory %>% 
  filter(powiat == "Poznań")

# zadanie

wybory <- wybory %>% 
  mutate(bs_proc=bs/liczba_kart_waznych*100,
         td_proc=td/liczba_kart_waznych*100,
         nl_proc=nl/liczba_kart_waznych*100,
         pis_proc=pis/liczba_kart_waznych*100,
         konf_proc=konf/liczba_kart_waznych*100,
         ko_proc=ko/liczba_kart_waznych*100)

summary(wybory)

# wybory <- wybory %>% 
#   mutate_at(vars(bs:ko), funs(./liczba_kart_waznych*100))

# Gdzie była największa różnica pomiędzy wybranymi partiami?
wybory <- wybory %>% 
  mutate(roznica_ko_td=abs(ko_proc-td_proc))

summary(wybory$roznica_ko_td)



