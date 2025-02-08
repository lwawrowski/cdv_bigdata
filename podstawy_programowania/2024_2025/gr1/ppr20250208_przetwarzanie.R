library(tidyverse)

load("data/wybory.RData")

wybory_csv <- read_csv2("data/wybory.csv")

# filtrowanie -------------------------------------------------------------

wybory_1000kart <- wybory %>% 
  filter(liczba_kart_waznych == 1000)

wybory_slaskie <- wybory %>% 
  filter(wojewodztwo == "śląskie")

# koniunkcja warunków

wybory_1000kart_slaskie <- wybory %>% 
  filter(liczba_kart_waznych > 1000, wojewodztwo == "śląskie")

wybory_1000kart_slaskie <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo == "śląskie")

wybory_1000kart_slaskie <- wybory %>% 
  filter(liczba_kart_waznych > 1000) %>% 
  filter(wojewodztwo == "śląskie")

# alternatywa warunków

wybory_1000kart_slaskie_alt <- wybory %>% 
  filter(liczba_kart_waznych > 1000 | wojewodztwo == "śląskie") %>% 
  select(wojewodztwo, liczba_kart_waznych)

# %in%

wybory_1000kart_slaskie_wlkp <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & (wojewodztwo == "śląskie" | wojewodztwo == "wielkopolskie")) %>% 
  select(wojewodztwo, liczba_kart_waznych)

summary(wybory_1000kart_slaskie_wlkp)

wybory_1000kart_slaskie_wlkp <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo %in% c("śląskie", "wielkopolskie")) %>% 
  select(wojewodztwo, liczba_kart_waznych)

wybrane_woj <- c("śląskie", "wielkopolskie", "mazowieckie")

wybory_1000kart_slaskie_wlkp_maz <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & wojewodztwo %in% wybrane_woj) %>% 
  select(wojewodztwo, liczba_kart_waznych)

# negacja

wybory_1000kart_nie_slaskie_wlkp_maz <- wybory %>% 
  filter(liczba_kart_waznych > 1000 & !wojewodztwo %in% wybrane_woj) %>% 
  select(wojewodztwo, liczba_kart_waznych)

# zadanie

movies <- read_csv("data/movies.csv")

movies_zad <- movies %>% 
  filter(genre == "Action" & year > 2010 & (duration >= 120 | rating > 8))

# braki danych ------------------------------------------------------------

summary(wybory)

wybory_braki <- wybory %>% 
  filter(!is.na(teryt_gminy))

summary(wybory_braki$teryt_gminy)

wybory_braki_chr <- wybory %>% 
  filter(!is.na(wojewodztwo))

summary(wybory_braki_chr$wojewodztwo)

complete.cases(wybory)

wybory_cc <- wybory %>% 
  filter(complete.cases(wybory))

# . oznacza aktualnie przetwarzany obiekt
wybory_cc <- wybory %>% 
  filter(complete.cases(.))

wybory_cc <- wybory %>%
  select(liczba_kart_waznych, wojewodztwo) %>% 
  filter(complete.cases(.))

# select - wybieranie kolumn ----------------------------------------------

wybory_kolumny <- wybory %>% 
  select(-liczba_kart_waznych, -wojewodztwo)

wybory_kolumny <- wybory %>% 
  select(-c(liczba_kart_waznych, wojewodztwo))

wybory_kolumny <- wybory %>% 
  select(siedziba:wojewodztwo)

wybory_liczba <- wybory %>% 
  select(starts_with("liczba"))

wybory_char <- wybory %>% 
  select_if(is.character)

# kolejność w przetwarzaniu potokowym

wybory %>% 
  filter(liczba_kart_waznych > 3000) %>% 
  select(siedziba)

wybory %>% 
  select(siedziba) %>% 
  filter(liczba_kart_waznych > 3000)


# rename - zmiana nazwy ---------------------------------------------------

wybory_siedziba <- wybory %>% 
  rename(siedziba_komisji=siedziba)

wybory %>% 
  select(siedziba_komisji=siedziba)

# mutate - nowe kolumny ---------------------------------------------------

wybory <- wybory %>% 
  mutate(frekwencja=liczba_kart_wyjetych_z_urny/liczba_wyborcow_uprawnionych_do_glosowania*100) %>% 
  rename(bs=komitet_wyborczy_bezpartyjni_samorzadowcy,
         td=koalicyjny_komitet_wyborczy_trzecia_droga_polska_2050_szymona_holowni_polskie_stronnictwo_ludowe,
         nl=komitet_wyborczy_nowa_lewica,
         pis=komitet_wyborczy_prawo_i_sprawiedliwosc,
         konf=komitet_wyborczy_konfederacja_wolnosc_i_niepodleglosc,
         ko=koalicyjny_komitet_wyborczy_koalicja_obywatelska_po_n_ipl_zieloni)

summary(wybory$frekwencja)

# zepsuty zbiór

wybory_zepsuty <- wybory

wybory_zepsuty <- wybory_zepsuty %>% 
  mutate(frekwencja=frekwencja/100)

summary(wybory_zepsuty$frekwencja)

# 1 sposób

wybory <- wybory %>% 
  mutate(bs_proc=bs/liczba_kart_waznych,
         td_proc=td/liczba_kart_waznych,
         nl_proc=nl/liczba_kart_waznych,
         pis_proc=pis/liczba_kart_waznych,
         konf_proc=konf/liczba_kart_waznych,
         ko_proc=ko/liczba_kart_waznych)

summary(wybory)

# 2 sposób

wybory <- wybory %>% 
  mutate(across(
    bs:ko, 
    ~ . / liczba_kart_waznych * 100, 
    .names = "procent_{.col}"
  ))

summary(wybory)

# 3 sposób

# wynik_proc <- function(x,y) x/y*100
# 
# wybory <- wybory %>% 
#   mutate_at(vars(bs:ko), list(proc = ~ wynik_proc(.x, liczba_kart_waznych)))

wybory <- wybory %>% 
  mutate_at(vars(bs:ko), list(proc = ~ .x / liczba_kart_waznych*100))

summary(wybory)

# Ile obwodów głosowania miało frekwencję powyżej 80%?

wybory %>% 
  filter(frekwencja > 80)

# Ile obwodów głosowania znajduje się w Poznaniu?

wybory %>% 
  filter(powiat == "Poznań")

# Gdzie była największa różnica pomiędzy wybranymi partiami?

wybory <- wybory %>% 
  mutate(roznica_td_nl=abs(td_proc-nl_proc))

# summarise - podsumowania ------------------------------------------------

wybory_stat <- wybory %>% 
  summarise(srednia=mean(liczba_wyborcow_uprawnionych_do_glosowania, na.rm=TRUE),
            mediana=median(liczba_wyborcow_uprawnionych_do_glosowania, na.rm=TRUE),
            liczebnosc=n())

wybory %>% 
  summarise_at(vars(liczba_wyborcow_uprawnionych_do_glosowania),
               list(srednia = mean, mediana = median),
               na.rm=TRUE)

komitety_stat <- wybory %>% 
  summarise_at(vars(bs:ko),
               list(srednia = mean, mediana = median),
               na.rm=TRUE)
