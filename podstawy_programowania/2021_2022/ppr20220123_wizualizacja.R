library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 23, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
plot(sklep$sprzedaz, sklep$liczba_klientow)

hist(sklep$sprzedaz)

ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow, 
                                   color = czy_promocja)) +
  geom_point()

ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow)) +
  geom_point(color = "blue") +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  ylim(0, 1000) +
  ggtitle("Sprzedaż i liczba klientów w sklepie 23") +
  theme_bw()

ggsave(filename = "figs/wykres.pdf", 
       width = 8, 
       height = 5,
       scale = 0.5)

p <- ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow, 
                                   color = czy_promocja,
                                   shape = czy_swieto_szkolne,
                                   label = data)) +
  geom_point()

plotly::ggplotly(p)
