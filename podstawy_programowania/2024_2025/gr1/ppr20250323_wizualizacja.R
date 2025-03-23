library(tidyverse)
library(readxl)

rossmann <- read_xlsx(path = "data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 23, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
plot(sklep$sprzedaz, sklep$liczba_klientow)

hist(sklep$sprzedaz)

# wykres punktowy ---------------------------------------------------------

ggplot(data = sklep, mapping = aes(x = liczba_klientow, 
                                   y = sprzedaz, 
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  xlab("Liczba klientów") +
  ylab("Sprzedaż") +
  # scale_color_discrete(name = "Promocja") +
  # scale_color_manual(name = "Promocja", values = c("Tak" = "blue", "Nie" = "red")) +
  scale_color_brewer(name = "Promocja", palette = "Set2") +
  ggtitle("Sprzedaż i liczba klientów w 2014 roku") +
  labs(subtitle = "Sklep nr 23", caption = "opracowanie własne") +
  xlim(200, 1000) +
  theme_light() +
  theme(legend.position = "inside", legend.position.inside = c(0.1,0.8))

ggsave("figures/sklep_ggplot.png", width = 6, height = 4)
ggsave("figures/sklep_ggplot.pdf", width = 6, height = 4)

plotly::ggplotly()

# rola poza funkcją aes definiuje kolor
ggplot(data = sklep, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point(color = "deepskyblue")

ggplot(data = sklep, aes(x = liczba_klientow, y = sprzedaz)) +
  geom_point(aes(color = czy_promocja))

plotly::ggplotly()

# histogram ----

ggplot(sklep, aes(x=sprzedaz)) +
  geom_histogram()

ggplot(sklep, aes(x=sprzedaz)) +
  geom_histogram(binwidth = 1000)

p <- ggplot(sklep, aes(x=sprzedaz)) +
  geom_histogram(bins = 11)

przedzialy <- layer_data(p)

ggplot(sklep, aes(x=sprzedaz, fill = czy_promocja)) +
  geom_histogram()

ggplot(sklep, aes(x=sprzedaz)) +
  geom_histogram(fill = "pink", color = "white")


# wykres słupkowy ---------------------------------------------------------

# dane jednostkowe
ggplot(sklep, aes(x = czy_promocja)) +
  geom_bar()

ggplot(sklep, aes(y = czy_promocja)) +
  geom_bar()

# dane zagregowane
sklep_promocja <- sklep %>% 
  count(czy_promocja)

ggplot(sklep_promocja, aes(x = czy_promocja, y = n)) +
  geom_col()

# połączenie przetwarzania danych i wykresu
sklep %>% 
  count(czy_promocja) %>% 
  ggplot(aes(x = czy_promocja, y = n)) +
  geom_col()

# druga cecha
ggplot(sklep, aes(x = czy_promocja, fill = czy_swieto_szkolne)) +
  geom_bar(position = "dodge")

# facets ------------------------------------------------------------------

# 1 cecha
ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow)) +
  geom_point() +
  facet_wrap(~ czy_promocja)

# 2 cechy
ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_promocja, scales = "free", nrow = 2)

# grid
ggplot(sklep, aes(x=sprzedaz, y=liczba_klientow, color = czy_swieto_szkolne)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_promocja)


# wykres pudełkowy --------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_violin()

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, color = "darkblue")

sklep %>% 
  group_by(dzien_tyg) %>% 
  summarise(srednia=mean(liczba_klientow)) %>% 
  ggplot(aes(x=srednia, y=as.factor(dzien_tyg))) +
  geom_col()

ggplot(sklep, aes(x=liczba_klientow, y=as.factor(dzien_tyg))) +
  geom_boxplot()

