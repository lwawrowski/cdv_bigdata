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

