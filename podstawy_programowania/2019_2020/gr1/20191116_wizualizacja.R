library(tidyverse)
library(readxl)

rossmann <- read_excel("data/rossmann.xlsx")

summary(rossmann)

sklep <- rossmann %>%
  filter(sklep_id == 11, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
plot(sklep$sprzedaz, sklep$liczba_klientow)

hist(sklep$sprzedaz)

# ggplot2

ggplot(data = sklep, aes(x = sprzedaz, 
                         y = liczba_klientow)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  xlim(0,20000) +
  ylim(0,2000) +
  ggtitle("Sprzedaż i liczba klientów w sklepie 11") +
  theme_light()









