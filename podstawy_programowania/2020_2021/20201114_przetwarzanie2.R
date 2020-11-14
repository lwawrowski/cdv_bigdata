library(tidyverse)

load("data/wybory.rda")

# zad1

# pipe ctrl+shift+m

obw_komorniki <- dane_czyste %>% 
  filter(gmina == "gm. Komorniki")

length(unique(dane_czyste$gmina))
length(unique(dane_czyste$kod_teryt))

obw_komorniki <- dane_czyste %>% 
  filter(kod_teryt == "302107")

# zad2

zad2 <- dane_czyste %>% 
  filter(frekwencja >= 61, wojewodztwo == "małopolskie")

zad2 <- dane_czyste %>% 
  filter(frekwencja >= 61 & wojewodztwo == "małopolskie")

zad2 <- dane_czyste %>% 
  filter(frekwencja >= 61) %>% 
  filter(wojewodztwo == "małopolskie")

# zad3

zad3 <- dane_czyste %>% 
  filter(wojewodztwo == "pomorskie" & frekwencja > 40 & (percent_glosow_waznych < 80 | andrzej_sebastian_duda > 70))

# mutate

dane_czyste <- dane_czyste %>% 
  mutate(procent_glosow=percent_glosow_niewaznych+percent_glosow_waznych)

dane_roznica <- dane_czyste %>% 
  mutate(roznica = abs(andrzej_sebastian_duda - rafal_kazimierz_trzaskowski)) %>% 
  filter(roznica != 100) %>% 
  select(typ_obwodu, siedziba, andrzej_sebastian_duda, rafal_kazimierz_trzaskowski, roznica) %>% 
  top_n(10, roznica) %>% 
  arrange(desc(roznica))

# summarise

# wynik tylko w konsoli
dane_czyste %>% 
  summarise(srednia_ad=mean(andrzej_sebastian_duda, na.rm = TRUE),
            srednia_rt=mean(rafal_kazimierz_trzaskowski, na.rm = TRUE))

# wynik w zbiorze danych
srednia_kand <- dane_czyste %>% 
  summarise(srednia_ad=mean(andrzej_sebastian_duda, na.rm = TRUE),
            srednia_rt=mean(rafal_kazimierz_trzaskowski, na.rm = TRUE))

srednia_kand

dane_czyste %>% 
  summarise(mean(frekwencja), median(frekwencja), sd(frekwencja))

# group by

frekwencja_woj <- dane_czyste %>% 
  group_by(wojewodztwo) %>% 
  summarise(srednia=mean(frekwencja))

frekwencja_woj_pow <- dane_czyste %>% 
  group_by(wojewodztwo, powiat) %>% 
  summarise(srednia=mean(frekwencja))

frekwencja2 <- dane_czyste %>% 
  mutate(frekwencja_przedzialy=cut(x = frekwencja, breaks = c(0,25,50,75,100), include.lowest = TRUE)) %>% 
  group_by(frekwencja_przedzialy) %>% 
  summarise(liczebnosc=n(),
            srednia=mean(percent_glosow_waznych, na.rm = TRUE))

frekwencja2

# count

dane_czyste %>% 
  count()

dane_czyste %>% 
  count(typ_obszaru)

woj_typ_obszaru <- dane_czyste %>% 
  count(wojewodztwo, typ_obszaru)

woj_typ_obszaru <- dane_czyste %>% 
  group_by(wojewodztwo, typ_obszaru) %>% 
  summarise(n=n())

dane_czyste %>% 
  group_by(typ_gminy) %>% 
  summarise(liczebnosc=n(),
            srednia_frek=mean(frekwencja))








