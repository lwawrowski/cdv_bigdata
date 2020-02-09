library(tidyverse)
library(readxl)

rossmann <- read_excel("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 7, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
plot(sklep$sprzedaz, sklep$liczba_klientow)

hist(sklep$sprzedaz)

ggplot(data = sklep, aes(x = sprzedaz, 
                         y = liczba_klientow)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  xlim(0,18000) +
  ylim(0,1600) +
  ggtitle("Sprzedaż i liczba klientów w sklepie 7") +
  theme_light()










