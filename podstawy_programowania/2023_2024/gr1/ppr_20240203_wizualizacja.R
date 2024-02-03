library(tidyverse)
library(readxl)

rossmann <- read_xlsx("data/rossmann.xlsx")

sklep <- rossmann %>% 
  filter(sklep_id == 3, czy_otwarty == "Tak")

plot(sklep$sprzedaz)
mean(sklep$sprzedaz)

plot(sklep$sprzedaz, sklep$liczba_klientow)
hist(sklep$sprzedaz)

# wykres punktowy ---------------------------------------------------------

# color jako rola w aes
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow, 
                                   color = czy_promocja,
                                   label = data)) +
  geom_point() +
  xlab("Sprzedaż") +
  ylab("Liczba klientów") +
  scale_color_discrete(name = "Promocja") +
  ggtitle("Sprzedaż i liczba klientów w 2014 roku") +
  labs(subtitle = "Sklep nr 3", caption = "Opracował: ŁW") +
  xlim(3000, 16000) +
  theme_light() +
  theme(legend.position = c(0.1, 0.8))
  # theme(legend.position = "top")

ggsave("figs/sklep3_ggsave.png", width = 8, height = 5)
ggsave("figs/sklep3_ggsave.pdf", width = 8, height = 5, device = cairo_pdf)

plotly::ggplotly()
  
# color jako nazwa koloru
ggplot(data = sklep, mapping = aes(x = sprzedaz, 
                                   y = liczba_klientow)) +
  # geom_point(color="lightblue3") +
  geom_point(color="#99d8c9") +
  xlab("Sprzedaż") +
  ylab("Liczba klientów")


# histogram ---------------------------------------------------------------

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram()

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(bins = 10)

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000)

ggplot(data = sklep, mapping = aes(x = sprzedaz, fill = czy_promocja)) +
  geom_histogram(binwidth = 1000)

ggplot(data = sklep, mapping = aes(x = sprzedaz)) +
  geom_histogram(binwidth = 1000, fill = "pink", color = "white")


# wykres słupkowy ---------------------------------------------------------

sklep <- sklep %>% 
  mutate(sprzedaz3=cut(x = sprzedaz, 
                       breaks = c(min(sprzedaz), 6000, 12000, max(sprzedaz)),
                       include.lowest = TRUE,
                       labels = c("do 6000 EUR", "6000-12000 EUR", "powyżej 12000 EUR")))

# sposób 1 - dane jednostkowe
ggplot(sklep, aes(x=sprzedaz3)) +
  geom_bar()

# sposób 2 - dane zagregowane

sklep_sprzedaz <- sklep %>% 
  count(sprzedaz3)

ggplot(sklep_sprzedaz, aes(x=sprzedaz3, y=n)) +
  geom_col()

# sposób 3

sklep %>% 
  count(sprzedaz3) %>% 
  ggplot(aes(x=sprzedaz3, y=n)) +
  geom_col()

# druga cecha

ggplot(sklep, aes(x=sprzedaz3, fill=czy_promocja)) +
  geom_bar(position = "dodge")


# facets ------------------------------------------------------------------

# 1 cecha
ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_promocja)) +
  geom_point() +
  facet_wrap(~czy_swieto_szkolne)

# 2 cechy
ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_promocja)) +
  geom_point() +
  facet_wrap(dzien_tyg~czy_swieto_szkolne, nrow = 2, scales = "free")

ggplot(sklep, aes(x=sprzedaz, 
                  y=liczba_klientow, 
                  color=czy_promocja)) +
  geom_point() +
  facet_grid(dzien_tyg~czy_swieto_szkolne)


# wykres pudełkowy --------------------------------------------------------

ggplot(sklep, aes(x=sprzedaz, y=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(y=sprzedaz, x=czy_promocja)) +
  geom_boxplot()

ggplot(sklep, aes(x=sprzedaz, y=as.factor(dzien_tyg))) +
  geom_boxplot()

