library(tidyverse)

wybory <- read_csv("data/wybory.csv")

wybory <- wybory %>% 
  mutate(frekwencja=liczba_kart_wyjetych_z_urny/liczba_wyborcow_uprawnionych_do_glosowania*100) %>% 
  rename(bs=komitet_wyborczy_bezpartyjni_samorzadowcy,
         td=koalicyjny_komitet_wyborczy_trzecia_droga_polska_2050_szymona_holowni_polskie_stronnictwo_ludowe,
         nl=komitet_wyborczy_nowa_lewica,
         pis=komitet_wyborczy_prawo_i_sprawiedliwosc,
         konf=komitet_wyborczy_konfederacja_wolnosc_i_niepodleglosc,
         ko=koalicyjny_komitet_wyborczy_koalicja_obywatelska_po_n_ipl_zieloni) %>% 
  mutate(bs_proc=bs/liczba_kart_waznych*100,
         td_proc=td/liczba_kart_waznych*100,
         nl_proc=nl/liczba_kart_waznych*100,
         pis_proc=pis/liczba_kart_waznych*100,
         konf_proc=konf/liczba_kart_waznych*100,
         ko_proc=ko/liczba_kart_waznych*100)

# summarise

wybory %>% 
  summarise(srednia=mean(liczba_wyborcow_uprawnionych_do_glosowania, na.rm=TRUE),
            mediana=median(liczba_wyborcow_uprawnionych_do_glosowania, na.rm=TRUE),
            liczebnosc=n())

summary(wybory$liczba_wyborcow_uprawnionych_do_glosowania)

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

# zadanie

wybory %>% 
  summarise_at(vars(frekwencja), 
               list(srednia = mean, mediana = median, odch = sd), 
               na.rm=TRUE)

wybory %>% 
  summarise(srednia=mean(frekwencja, na.rm=TRUE),
            mediana=median(frekwencja, na.rm=TRUE),
            odch=sd(frekwencja, na.rm=TRUE))

# group_by

liczba_glos_powiaty <- wybory %>% 
  group_by(powiat) %>% 
  summarise(srednia_glos=round(mean(liczba_wyborcow_uprawnionych_do_glosowania)))

wybory
liczba_glos_powiaty

koperty_woj <- wybory %>% 
  group_by(wojewodztwo, liczba_kopert_zwrotnych_w_ktorych_oswiadczenie_nie_bylo_podpisane) %>% 
  summarise(liczba=n())

koperty_woj_n <- wybory %>% 
  count(wojewodztwo, liczba_kopert_zwrotnych_w_ktorych_oswiadczenie_nie_bylo_podpisane)

# Jaka była średnia frekwencja w województwach?

wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(srednia_frekwencja=mean(frekwencja))

# W jakich miastach za granicą utworzono najwięcej obwodów głosowania?

obwody_zagranica <- wybory %>% 
  filter(powiat=="zagranica") %>% 
  count(gmina) %>% 
  arrange(desc(n))

# zadanie

niewazne_woj <- wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(liczba_komisji=n(),
            srednia_niewaznych=mean(liczba_glosow_niewaznych))

# łączenie danych ----

load("data/gus.RData")

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017)

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = join_by(id, name))

przyrost_16_17 <- left_join(x = przyrost2016, y = przyrost2017, by = c("id" = "id", "name"))

przyrost_16_17r <- right_join(x = przyrost2017, y = przyrost2016)

przyrost_15_17 <- inner_join(przyrost2015, przyrost2017)

przyrost_15_17_full <- full_join(przyrost2015, przyrost2017)

# podejście 1
przyrost_15_16 <- full_join(przyrost2015, przyrost2016)
przyrost_15_16_17 <- full_join(przyrost_15_16, przyrost2017)

# podejście 2
przyrost_15_16_17 <- full_join(x = przyrost2015, 
                               y = full_join(przyrost2016, przyrost2017))

# podejście 3
przyrost_15_16_17 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(x = ., y = przyrost2017) 

przyrost_15_16_17 <- full_join(przyrost2015, przyrost2016) %>% 
  full_join(., przyrost2017) 

przyrost_15_16_17 <- przyrost2015 %>% 
  full_join(., przyrost2016) %>% 
  full_join(., przyrost2017) 

# zadanie

summary(wyn)
summary(pod_10tys)
summary(bezrobocie)

# sposób 1
bezr_podmioty <- inner_join(bezrobocie, pod_10tys, by=c("id_powiat"="pow")) %>% 
  mutate(pow=as.numeric(id_powiat))

bezr_podmioty_wyn <- inner_join(bezr_podmioty, wyn)

# sposób 2
bezr_podmioty_wyn <- inner_join(bezrobocie, pod_10tys, by=c("id_powiat"="pow")) %>% 
  mutate(pow=as.numeric(id_powiat)) %>% 
  inner_join(., wyn) %>% 
  select(pow_chr=id_powiat, pow_num=pow, pod_10tys, stopa_bezr, wynagrodzenie)

# reprezentacja długa ----

dane_long <- bezr_podmioty_wyn %>% 
  pivot_longer(pod_10tys:wynagrodzenie)

bezr_podmioty_wyn %>% 
  summarise_at(vars(pod_10tys:wynagrodzenie), list(srednia=mean, mediana=median))

dane_long %>% 
  group_by(name) %>% 
  summarise(srednia=mean(value),
            mediana=median(value))

# reprezentacja szeroka

# tylko jeżeli jest name i value w nazwach kolumn
dane_wide <- dane_long %>% 
  pivot_wider()

dane_wide <- dane_long %>% 
  pivot_wider(names_from = name, values_from = value, names_prefix = "rok2018_")

# zapisywanie wyniku
write_csv2(bezr_podmioty_wyn, "data/statystyki.csv")

dane <- read_csv2("data/statystyki.csv")
  
  
  