library(tidyverse)
library(readxl)

rossmann <- read_excel("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 15, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
mean(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)

hist(sklep$liczba_klientow)


# wykres punktowy ---------------------------------------------------------

# color jako rola 
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow,
                                   color = czy_promocja)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  scale_color_discrete(name = "Promocja") +
  scale_x_continuous(limits = c(4000,14000), 
                     breaks = seq(4000,14000,2000)) + 
  ggtitle("Sprzedaż i liczba klientów w roku 2014") +
  labs(subtitle = "Sklep nr 15") +
  theme_light() +
  theme(legend.position = "top")

ggsave(filename = "figs/sprzedaz_klienci_15_gg.png",
       width = 8, 
       height = 6)

ggsave(filename = "figs/sprzedaz_klienci_15_gg.pdf",
       width = 8, 
       height = 6,
       device = cairo_pdf)

# color jako kolor
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow)) +
  geom_point(color = "#ff0099") +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  ggtitle("Sprzedaż i liczba klientów w roku 2014") +
  labs(subtitle = "Sklep nr 15") +
  theme_light()


# plotly ------------------------------------------------------------------

p <- ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow,
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  scale_color_discrete(name = "Promocja") +
  scale_x_continuous(limits = c(4000,14000), 
                     breaks = seq(4000,14000,2000)) + 
  ggtitle("Sprzedaż i liczba klientów w roku 2014") +
  labs(subtitle = "Sklep nr 15") +
  theme_light() +
  theme(legend.position = "top")

plotly::ggplotly(p)


# histogram ---------------------------------------------------------------

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 600)

ggplot(sklep, aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 600)

ggplot(sklep, aes(x = sprzedaz)) +
  geom_histogram(binwidth = 600, fill = "purple", color = "white")

# wykres słupkowego -------------------------------------------------------

sklep <- sklep %>% 
  mutate(sprzedaz3=cut(x = sprzedaz, 
                       breaks = c(min(sprzedaz), 7000, 10000, max(sprzedaz)),
                       include.lowest = TRUE,
                       labels = c("do 7000 EUR", "7000-10000 EUR", "powyżej 10000 EUR")))

# jedna cecha

ggplot(sklep, aes(x = sprzedaz3)) +
  geom_bar()

# sposób 1
sprzedaz_count <- sklep %>% 
  count(sprzedaz3)

ggplot(sprzedaz_count, aes(x = sprzedaz3, y = n)) +
  geom_col()

# sposób 2
sklep %>% 
  count(sprzedaz3) %>% 
  ggplot(aes(x = sprzedaz3, y = n)) +
  geom_col()

# dwie cechy

ggplot(sklep, aes(x = sprzedaz3, fill = czy_promocja)) +
  geom_bar(position = "dodge")


# facets ------------------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_swieto_szkolne)) +
  geom_point() +
  facet_wrap(~ czy_promocja)

ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_swieto_szkolne)) +
  geom_point() +
  facet_wrap(dzien_tyg ~ czy_promocja, nrow = 2, scales = "free")

ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_swieto_szkolne)) +
  geom_point() +
  facet_grid(dzien_tyg ~ czy_promocja)


# wykres pudełkowy --------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=as.factor(dzien_tyg))) +
  geom_boxplot()







