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

# wybór kolumn ------------------------------------------------------------

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

wybory_komitet <- wybory %>% 
  select(contains("komitet"))

# kolejność działań w przetwarzaniu potokowym

wybory %>% 
  filter(liczba_kart_waznych == 777) %>% 
  select(siedziba)

wybory %>% 
  select(siedziba) %>% 
  filter(liczba_kart_waznych == 777)


# zmiana nazwy kolumny ----------------------------------------------------

wybory_siedziba <- wybory %>% 
  rename(siedziba_komisji=siedziba) %>% 
  rename_with(toupper)


# nowe kolumny ------------------------------------------------------------

wybory <- wybory %>% 
  mutate(frekwencja=liczba_kart_wyjetych_z_urny/liczba_wyborcow_uprawnionych_do_glosowania*100) %>% 
  rename(bs=komitet_wyborczy_bezpartyjni_samorzadowcy,
         td=koalicyjny_komitet_wyborczy_trzecia_droga_polska_2050_szymona_holowni_polskie_stronnictwo_ludowe,
         nl=komitet_wyborczy_nowa_lewica,
         pis=komitet_wyborczy_prawo_i_sprawiedliwosc,
         konf=komitet_wyborczy_konfederacja_wolnosc_i_niepodleglosc,
         ko=koalicyjny_komitet_wyborczy_koalicja_obywatelska_po_n_ipl_zieloni)

summary(wybory$frekwencja)

# modyfikacja istniejącej zmiennej

zepsuty <- wybory

zepsuty <- zepsuty %>% 
  mutate(frekwencja=frekwencja*0)

# zadanie - 1 sposób

wybory <- wybory %>% 
  mutate(bs_proc=bs/liczba_kart_waznych,
         td_proc=td/liczba_kart_waznych,
         nl_proc=nl/liczba_kart_waznych,
         pis_proc=pis/liczba_kart_waznych,
         konf_proc=konf/liczba_kart_waznych,
         ko_proc=ko/liczba_kart_waznych)

# 2 sposób

wybory <- wybory %>% 
  mutate_at(.vars = vars(bs:ko), .funs = list(proc = ~ .x/liczba_kart_waznych*100))

# 3 sposób

wybory <- wybory %>%
  mutate(across(bs:ko, ~ . / liczba_kart_waznych * 100, .names = "{.col}_proc"))


# podsumowanie danych -----------------------------------------------------

wybory_stat <- wybory %>% 
  summarise(srednia=mean(liczba_wyborcow_uprawnionych_do_glosowania, na.rm = T),
            minimum=min(liczba_wyborcow_uprawnionych_do_glosowania, na.rm = T),
            maksimum=max(liczba_wyborcow_uprawnionych_do_glosowania, na.rm = T))

wybory_summ <- summary(wybory$liczba_wyborcow_uprawnionych_do_glosowania)

wybory %>% 
  summarise_at(vars(liczba_wyborcow_uprawnionych_do_glosowania), 
               list(srednia = mean, minimum = min, maksimum = max), na.rm = T)


komitety_stat <- wybory %>% 
  summarise_at(vars(bs:ko), 
               list(srednia = mean, minimum = min, maksimum = max), na.rm = T)

komitety_stat <- wybory %>% 
  summarise(across(bs:ko, 
                   list(srednia = \(x) mean(x, na.rm = TRUE), 
                        minimum = \(x) min(x, na.rm = TRUE), 
                        maksimum = \(x) max(x, na.rm = TRUE))))

# \(x) = function(x)

# grupowanie --------------------------------------------------------------

liczba_glos_powiat <- wybory %>% 
  group_by(powiat) %>% 
  summarise(srednia=round(mean(liczba_wyborcow_uprawnionych_do_glosowania))) %>% 
  arrange(desc(srednia))

wybory
liczba_glos_powiat

koperty_woj <- wybory %>% 
  group_by(wojewodztwo, liczba_kopert_zwrotnych_w_ktorych_oswiadczenie_nie_bylo_podpisane) %>% 
  summarise(liczba=n())

koperty_woj

koperty_woj_n <- wybory %>% 
  count(wojewodztwo, liczba_kopert_zwrotnych_w_ktorych_oswiadczenie_nie_bylo_podpisane, name = "liczba")

# Ile obwodów głosowania miało frekwencję powyżej 80%?

wybory %>% 
  filter(frekwencja > 80) %>% 
  count()

# Ile obwodów głosowania znajduje się w Poznaniu?

wybory %>% 
  filter(powiat == "Poznań") %>% 
  count()

# Jaka była średnia frekwencja w województwach?

wybory %>% 
  filter(!is.na(wojewodztwo)) %>% 
  group_by(wojewodztwo) %>% 
  summarise(srednia=mean(frekwencja)) %>% 
  arrange(srednia)

# Gdzie była największa różnica pomiędzy wybranymi partiami?

wybory_diff = wybory %>% 
  mutate(roznica_td_nl=abs(td_proc-nl_proc)) %>% 
  select(siedziba, td_proc, nl_proc, roznica_td_nl)

summary(wybory_diff$roznica_td_nl)

wybory_diff %>% 
  filter(roznica_td_nl == max(roznica_td_nl, na.rm=T))

wybory_diff %>% 
  slice_max(order_by = roznica_td_nl, n = 10)

# W jakich miastach za granicą utworzono najwięcej obwodów głosowania?

wybory_zagranica <- wybory %>% 
  filter(powiat == "zagranica") %>% 
  count(gmina) %>% 
  arrange(desc(n))
