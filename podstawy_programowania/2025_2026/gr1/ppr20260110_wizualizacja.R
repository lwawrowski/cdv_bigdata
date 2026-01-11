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
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  xlab("Liczba klientów") +
  ylab("Sprzedaż") +
  scale_color_discrete(name = "Promocja") +
  ylim(3000, 9500) +
  ggtitle("Sprzedaż i liczba klientów", subtitle = "Sklep nr 10") +
  labs(caption = "opracowanie własne") +
  theme_light() +
  theme(legend.position = "inside", legend.position.inside = c(0.9, 0.25))

ggsave(filename = "figs/sklep10_ggplot.png", width = 8, height = 4)
ggsave(filename = "figs/sklep10_ggplot.pdf", device = cairo_pdf)

# wykres interaktywny

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
  geom_histogram(bins = 12)

p <- ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 500)

przedzialy <- layer_data(p)

ggplot(sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 500)

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 500, fill = "pink", color = "white")

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

ggplot(sklep, aes(x=sprzedaz, y = czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(y=sprzedaz, x = czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y = czy_promocja)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, color = "blue")

ggplot(sklep, aes(x=sprzedaz, y = czy_promocja)) +
  geom_jitter(alpha = 0.2, color = "blue") +
  geom_boxplot() 

# zadanie

ggplot(sklep, aes(x=liczba_klientow, y=as.character(dzien_tyg))) +
  geom_boxplot()

ggplot(sklep, aes(x=liczba_klientow, y=as.factor(dzien_tyg))) +
  geom_boxplot()






