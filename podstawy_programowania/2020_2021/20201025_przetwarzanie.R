library(tidyverse)

load("data/wybory.rda")

# iris

# tworzenie nowego obiektu
frekwencja80 <- dane_czyste %>% 
  filter(frekwencja >= 80) %>% 
  count()

# odczytanie wyniku z konsoli
dane_czyste %>% 
  filter(frekwencja >= 80) %>% 
  count()

# tworzenie %>% : ctrl + shift + m 

# obwody w Poznaniu I z frekwencją powyżej 60%
obw_poznan <- dane_czyste %>% 
  filter(powiat == "Poznań" & frekwencja > 60)

obw_poznan <- dane_czyste %>% 
  filter(powiat == "Poznań", frekwencja > 60)

# obwody w Poznaniu z jakąkolwiek frekwencją LUB jakiekolwiek obwody z frekwencją powyżej 60%
obw_poznan2 <- dane_czyste %>% 
  filter(powiat == "Poznań" | frekwencja > 60)

# obwody znajdujące się w Poznaniu, Krakowie lub Wrocławiu
obw_poznan3 <- dane_czyste %>% 
  filter(powiat %in% c("Poznań", "Kraków", "Wrocław"))

# obwody NIE znajdujące w Poznaniu, Krakowie lub Wrocławiu
obw_poznan4 <- dane_czyste %>% 
  filter(!powiat %in% c("Poznań", "Kraków", "Wrocław"))

# braki danych
is.na(45)
is.na(NA)

summary(dane_czyste)

dane_bez_brakow <- dane_czyste %>% 
  filter(!is.na(percent_glosow_waznych))

summary(dane_bez_brakow)

dane_cc <- complete.cases(dane_czyste)
sum(dane_cc)

# wybór kolumn
dane_kolumny <- dane_czyste %>% 
  select(-w_tym_z_powodu_postawienia_znaku_x_obok_nazwiska_dwoch_lub_wiekszej_liczby_kandydatow,
         -w_tym_z_powodu_niepostawienia_znaku_x_obok_nazwiska_zadnego_kandydata,
         -w_tym_z_powodu_postawienia_znaku_x_wylacznie_obok_skreslonego_nazwiska_kandydata)

dane_kolumny <- dane_czyste %>% 
  select(symbol_kontrolny:percent_glosow_niewaznych, percent_glosow_waznych:rafal_kazimierz_trzaskowski) %>% 
  rename(identyfikator=symbol_kontrolny)

dane_kolumny2 <- dane_czyste %>% 
  select(1:5)






























