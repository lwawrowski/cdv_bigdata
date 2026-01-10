library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 10, czy_otwarty == "Tak")

plot(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)
hist(sklep$sprzedaz)

ggplot(data = sklep, mapping = aes(x = liczba_klientow,
                                   y = sprzedaz, 
                                   color = czy_promocja)) +
  geom_point() +
  xlab("Liczba klientów") +
  ylab("Sprzedaż") +
  scale_color_discrete(name = "Promocja") +
  ylim(3000, 9500) +
  ggtitle("Sprzedaż i liczba klientów", subtitle = "Sklep nr 10") +
  labs(caption = "opracowanie własne") +
  theme_light() +
  theme(legend.position = "inside", legend.position.inside = c(0.9, 0.25))
  