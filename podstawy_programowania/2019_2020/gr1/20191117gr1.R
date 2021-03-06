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
  theme_light() +
  ggsave(filename = "figs/wykres1.png", 
         width = 16, height = 12, 
         scale = 0.5, dpi = 1200)

p <- ggplot(data = sklep, aes(x = sprzedaz, 
                         y = liczba_klientow, 
                         color = czy_promocja,
                         shape = czy_swieto_szkolne)) +
  geom_point() +
  scale_color_discrete(name = "Promocja") +
  scale_shape_discrete(name = "Święto szkolne") +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  xlim(0,20000) +
  ylim(0,2000) +
  ggtitle("Sprzedaż i liczba klientów w sklepie 11") +
  theme_light() +
  theme(legend.position = "bottom")

p
plotly::ggplotly(p)

# histogram

ggplot(data = sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

ggplot(data = sklep, aes(x = sprzedaz,
                         fill = czy_promocja)) +
  geom_histogram(binwidth = 1000)

ggplot(data = sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000, fill = "blue")

# wykres słupkowy

ggplot(data = sklep, aes(x = czy_promocja)) +
  geom_bar(fill = "green")

suma_sprzedazy <- sklep %>% 
  group_by(czy_promocja) %>% 
  summarise(suma=sum(sprzedaz))

options(scipen = 10)

ggplot(data = suma_sprzedazy, aes(x = czy_promocja,
                                  y = suma)) +
  geom_col()

# facets
ggplot(data = sklep, aes(x = sprzedaz,
                         y = liczba_klientow)) +
  geom_point() +
  facet_wrap(~ czy_promocja)

ggplot(data = sklep, aes(x = sprzedaz,
                         y = liczba_klientow)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_promocja, nrow = 2)

ggplot(data = sklep, aes(x = sprzedaz,
                         y = liczba_klientow)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_promocja)

# wykres pudełkowy

ggplot(data = sklep, aes(x = czy_promocja,
                         y = sprzedaz)) +
  geom_boxplot() +
  coord_flip() +
  ylab("Sprzedaż") +
  ylim(0,20000)











