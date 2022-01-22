library(tidyverse)

load("data/wybory.rda")

# wybory_prez <- read_csv("data/wybory.csv")

summary(wybory)

# braki danych

sd(wybory$percent_glosow_waznych, na.rm = TRUE)

wybory_braki <- wybory %>% 
  filter(!is.na(percent_glosow_waznych))

wybory_complete <- wybory %>% 
  select(-w_tym_z_powodu_postawienia_znaku_x_wylacznie_obok_skreslonego_nazwiska_kandydata) %>% 
  filter(complete.cases(.))

summary(wybory_complete)

# filtrowanie według kilku warunków

miasto80 <- wybory %>% 
  filter(typ_obszaru == "miasto", frekwencja > 80)

miasto80 <- wybory %>% 
  filter(typ_obszaru == "miasto" & frekwencja > 80)

miasto80 <- wybory %>% 
  filter(typ_obszaru == "miasto") %>% 
  filter(frekwencja > 80)

miasto80 <- wybory %>% 
  filter(typ_obszaru == "miasto" | frekwencja > 80)

# tylko te trzy miasta
miasta3 <- wybory %>% 
  filter(powiat %in% c("Poznań", "Kraków", "Wrocław"))

# wszystko oprócz tych trzech miast
miasta3 <- wybory %>% 
  filter(!powiat %in% c("Poznań", "Kraków", "Wrocław"))

# trzy warunki
wybory %>% 
  filter(wojewodztwo == "dolnośląskie", 
         frekwencja > 80, 
         typ_gminy == "gmina wiejska")

# wybieranie kolumn - select

wybrane_kolumny <- wybory %>% 
  # select(kod_teryt, frekwencja)
  # select(symbol_kontrolny:numer_obwodu)
  select(1:5)

# tworzenie nowej kolumny - mutate

wybory <- wybory %>% 
  mutate(suma_glosow=percent_glosow_niewaznych+percent_glosow_waznych) %>% 
  mutate(roznica=abs(rafal_kazimierz_trzaskowski-andrzej_sebastian_duda))

# podsumowania - summarise

wybory %>% 
  summarise(srednie_poparcie_rt=mean(rafal_kazimierz_trzaskowski, na.rm=T),
            srednie_poparcie_ad=mean(andrzej_sebastian_duda, na.rm=T))

wybory %>% 
  summarise(mean(frekwencja), median(frekwencja), sd(frekwencja))

frekwencja_woj <- wybory %>% 
  group_by(wojewodztwo) %>% 
  summarise(srednia=mean(frekwencja))

frekwencja_woj_pow <- wybory %>% 
  group_by(wojewodztwo, powiat) %>% 
  summarise(srednia=mean(frekwencja))

# stworzenie cechy jakościowej z ilościowej
glosy_frekwencja <- wybory %>%
  mutate(frekwencja_przedzialy=cut(x = frekwencja, 
                                   breaks = c(0,25,50,75,100), 
                                   include.lowest=TRUE)) %>% 
  group_by(frekwencja_przedzialy) %>% 
  summarise(srednia=mean(rafal_kazimierz_trzaskowski, na.rm=TRUE),
            liczebnosc=n())

# zliczanie - count

wybory %>% 
  count(typ_gminy)

wybory %>% 
  count(typ_obszaru)

obszar_woj <- wybory %>% 
  count(wojewodztwo, typ_obszaru)

obszar_woj <- wybory %>% 
  group_by(wojewodztwo, typ_obszaru) %>% 
  summarise(n=n())

obszar_woj <- wybory %>% 
  count(wojewodztwo, typ_obszaru) %>% 
  count(wojewodztwo) %>% 
  filter(n != 3)

gm_frek <- wybory %>% 
  group_by(typ_gminy) %>% 
  summarise(liczebnosc=n(),
            sr=mean(frekwencja))

