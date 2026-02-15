library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 15, czy_otwarty == "Tak")

plot(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)
hist(sklep$sprzedaz)
barplot(table(sklep$czy_promocja))
barplot(sklep$sprzedaz)
