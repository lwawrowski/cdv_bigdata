library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 23, czy_otwarty == "Tak")

# histogram

ggplot(data = sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 5)

ggplot(data = sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 500)

ggplot(data = sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 500)

ggplot(data = sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 500, fill = "blue", color = "white")

# wykres słupkowy

ggplot(data = sklep, aes(x = czy_promocja)) +
  geom_bar()

dni_promocja <- sklep %>% 
  count(czy_promocja)

ggplot(data = dni_promocja, aes(x = czy_promocja, y = n)) +
  geom_col()

ggplot(data = sklep, aes(x= czy_promocja, fill = czy_swieto_szkolne)) +
  geom_bar(position = "dodge")

# facet

ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow, color = czy_swieto_szkolne)) +
  geom_point() +
  facet_wrap( ~ czy_promocja)

ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow, color = czy_swieto_szkolne)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_promocja, nrow = 2, scales = "free_x")

ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow, color = czy_swieto_szkolne)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_promocja)

# boxplot

ggplot(sklep, aes(y=czy_promocja, x=sprzedaz)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.3)

ggplot(sklep, aes(y=as.character(dzien_tyg), x=liczba_klientow)) +
  geom_boxplot()



