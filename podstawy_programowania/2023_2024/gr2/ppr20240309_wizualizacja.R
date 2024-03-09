library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 9, czy_otwarty == "Tak")

plot(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)
hist(sklep$sprzedaz)


# wykres punktowy ---------------------------------------------------------

# rola zmiennej jako nazwa kolumny
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow, 
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  scale_color_discrete(name = "Promocja") +
  # scale_color_manual(name = "Promocja", values = c("Tak" = "blue", "Nie" = "red")) +
  # scale_color_brewer(palette = "Set2") +
  ggtitle("Sprzedaż i liczba klientów w 2014 roku") +
  labs(subtitle = "Sklep nr 9", caption = "Opracowanie własne") +
  xlim(4000,14000) +
  theme_light() +
  theme(legend.position = c(0.15,0.8))

ggsave("figs/sklep9_ggplot.png", width = 6, height = 4)
ggsave("figs/sklep9_ggplot.pdf", width = 6, height = 4, device = cairo_pdf)

# rola color jako nazwa koloru
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow)) +
  geom_point(color = "lightblue") +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") 

plotly::ggplotly()


# histogram ---------------------------------------------------------------

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram()

p <- ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000)

p <- ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

# sprawdzenie wartości przedziałów
dat <- layer_data(p)

ggplot(sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 1000)

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000, fill = "pink", color = "white")


# wykres słupkowy ---------------------------------------------------------

# dane jednostkowe
ggplot(sklep, aes(x=czy_promocja)) +
  geom_bar()

# dane zagregowane
sklep_promocja <- sklep %>% 
  count(czy_promocja)

ggplot(sklep_promocja, aes(x=czy_promocja, y=n)) +
  geom_col()

# połączenie zbioru danych i wykresu
sklep %>% 
  count(czy_promocja) %>% 
  ggplot(aes(x=czy_promocja, y=n)) +
  geom_col()

# druga cecha
ggplot(sklep, aes(x=czy_promocja, fill=czy_swieto_szkolne)) +
  geom_bar(position = "dodge")

# facets ------------------------------------------------------------------

ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow, 
                  color = czy_promocja,
                  shape = czy_swieto_szkolne)) +
  geom_point()

# 1 cecha
ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow, 
                  color = czy_promocja)) +
  geom_point() +
  facet_wrap(~ czy_swieto_szkolne)

# 2 cechy
ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow, 
                  color = czy_promocja)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_swieto_szkolne, ncol = 4, scales = "free")

# grid
ggplot(sklep, aes(x = sprzedaz, 
                  y = liczba_klientow, 
                  color = czy_promocja)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_swieto_szkolne)


# wykres pudełkowy --------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(y=sprzedaz, x=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=as.character(dzien_tyg))) +
  geom_boxplot()




















