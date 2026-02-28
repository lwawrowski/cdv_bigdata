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

# wykres punktowy
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow, 
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  ylab("Liczba klientów") +
  xlab("Sprzedaż") +
  scale_color_discrete(name = "Promocja") +
  ylim(400,1200) +
  ggtitle("Sprzedaż i liczba klientów", subtitle = "Sklep nr 15") +
  labs(caption = "Opracowanie własne") +
  theme_light() +
  theme(legend.position = "inside", legend.position.inside = c(0.1,0.8))

ggsave(filename = "figs/sklep15_ggplot.png", width = 6, height = 4)
ggsave(filename = "figs/sklep15_ggplot.pdf", device = cairo_pdf)

plotly::ggplotly()

# zadanie
temp_maj <- read_csv("data/temp_maj.csv")

ggplot(temp_maj, aes(x = lon, y = lat, color = temp)) +
  geom_point() +
  scale_color_gradient2(name = "Temperatura", low = "blue", mid = "white", high = "red") +
  theme_void() +
  theme(legend.position = "top") +
  coord_fixed()

# histogram
ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram()

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

p <- ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000)

p

przedzialy <- layer_data(p)

ggplot(sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 1000)
 
ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000, fill = "pink", color = "white")

# wykres słupkowy

# dane jednostkowe
ggplot(sklep, aes(x = czy_promocja)) +
  geom_bar()

# dane zagregowane
sklep_promocja <- sklep %>% 
  count(czy_promocja)

ggplot(sklep_promocja, aes(x = czy_promocja, y = n)) +
  geom_col()

sklep %>% 
  count(czy_promocja) %>% 
  ggplot(aes(x = czy_promocja, y = n)) +
  geom_col()

# druga cecha
ggplot(sklep, aes(x = czy_promocja, fill = czy_swieto_szkolne)) +
  geom_bar(position = "dodge")

# wykres pudełkowy

ggplot(sklep, aes(x = sprzedaz, y = czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(y = sprzedaz, x = czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x = sprzedaz, y = czy_promocja)) +
  geom_boxplot() +
  geom_jitter(colour = "blue", alpha = 0.2)

ggplot(sklep, aes(x = sprzedaz, y = czy_promocja)) +
  geom_jitter(colour = "blue", alpha = 0.2) +
  geom_boxplot()

ggplot(sklep, aes(x = sprzedaz, y = czy_promocja)) +
  geom_violin() +
  geom_jitter(colour = "blue", alpha = 0.2)

# zadanie

ggplot(sklep, aes(x = liczba_klientow, y = as.character(dzien_tyg))) +
  geom_boxplot()

