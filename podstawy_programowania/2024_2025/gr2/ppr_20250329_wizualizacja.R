library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 16, czy_otwarty == "Tak")

plot(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)
hist(sklep$sprzedaz)

# ggplot2

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
  scale_color_brewer(name = "Promocja", palette = "Accent") +
  xlim(400, 1600) +
  ggtitle("Liczba klientów i sprzedaż w roku 2014") +
  labs(subtitle = "Sklep nr 16", caption = "opracowanie własne") +
  theme_light() +
  # theme(legend.position = "top")
  theme(legend.position = "inside", legend.position.inside = c(0.9,0.2))

ggsave("figures/sklep16_ggplot.png", scale = 2)
ggsave("figures/sklep16_ggplot.png", width = 5, height = 3.5)
ggsave("figures/sklep16_ggplot.png", width = 1500, height = 900, units = "px")
ggsave("figures/sklep16_ggplot.pdf", width = 5, height = 3.5, device = cairo_pdf)

plotly::ggplotly()


# histogram ---------------------------------------------------------------

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram()

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000)

p <- ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

przedzialy <- layer_data(p)

ggplot(data = sklep, mapping = aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(bins = 10)

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(bins = 10, fill = "pink", color = "white")

# wykres słupkowy ---------------------------------------------------------

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

# wykres pudełkowy --------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(y=sprzedaz, x=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, color = "blue")

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_jitter(alpha = 0.2, color = "blue") +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=as.factor(dzien_tyg))) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, color = "blue")
