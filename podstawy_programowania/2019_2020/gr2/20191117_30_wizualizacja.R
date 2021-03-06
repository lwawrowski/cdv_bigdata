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
  theme_light() +
  ggsave(filename = "figs/wykres.png", 
         width = 16, height = 12, 
         scale = 0.5, dpi = 1200)

# wykres interaktywny

p <- ggplot(data = sklep, aes(x = sprzedaz, 
                         y = liczba_klientow, 
                         color = czy_promocja,
                         shape = czy_swieto_szkolne,
                         label = data)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  scale_color_discrete(name = "Promocja") +
  scale_shape_discrete(name = "Szkoła wolne") +
  xlim(0,18000) +
  ylim(0,1600) +
  ggtitle("Sprzedaż i liczba klientów w sklepie 7") +
  theme_light() +
  theme(legend.position = "bottom")
  
p

plotly::ggplotly(p)

# histogram

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

ggplot(sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 1000)

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000, fill = "red")

# wykres słupkowy

ggplot(sklep, aes(x = czy_promocja)) +
  geom_bar(fill = "pink")

suma_sprzedazy <- sklep %>% 
  group_by(czy_promocja) %>% 
  summarise(suma=sum(sprzedaz))

options(scipen = 999)

ggplot(suma_sprzedazy, aes(x = czy_promocja,
                           y = suma)) +
  geom_col()

# facets

ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow)) +
  geom_point() +
  facet_wrap( ~ czy_promocja)

ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_promocja, nrow = 2)

ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_promocja)

# wykres pudełkowy

ggplot(sklep, aes(x = czy_promocja,
                  y = sprzedaz)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.3) +
  coord_flip() +
  ylab("Sprzedaż") +
  ylim(0,18000)

ggplot(sklep, aes(x = as.character(dzien_tyg),
                  y = liczba_klientow)) +
  geom_boxplot() +
  coord_flip()








