library(tidyverse)

load("data/rossmann.RData")

sklep27 <- rossmann %>%
  filter(sklep_id == 27, czy_otwarty == "Tak")

sklep27 %>%
  count(czy_promocja, czy_swieto_szkolne) %>%
  ggplot(., aes(x = czy_promocja, 
                y = czy_swieto_szkolne,
                fill = n)) +
  geom_tile() +
  geom_label(aes(label = n), color = "white") +
  scale_fill_gradient(low = "#66c2a4", 
                      high = "#005824")

tab <- table(sklep27$czy_promocja, sklep27$czy_swieto_szkolne)
chisq.test(tab)

# zadanie 1
sklep_b <- rossmann %>%
  filter(sklep_typ == "b", dzien_tyg %in% 1:5)

tab1 <- table(sklep_b$dzien_tyg, sklep_b$czy_promocja)
chisq.test(tab1)

# wykres w czasie

library(lubridate)

sklep27a <- sklep27 %>%
  mutate(dzien_tyg=as.factor(dzien_tyg),
         data=ymd(data),
         tydzien=week(data))

ggplot(sklep27a, aes(x=data, 
                    y=sprzedaz, 
                    color=dzien_tyg)) +
  geom_point()

p <- ggplot(sklep27a, aes(x=data, 
                     y=sprzedaz, 
                     color=dzien_tyg)) +
  geom_point()

plotly::ggplotly(p)

sklep27_tyg <- sklep27a %>%
  group_by(tydzien) %>%
  summarise(sprzedaz_tyg=mean(sprzedaz),
            klienci_tyg=mean(liczba_klientow))

ggplot(sklep27_tyg, aes(x=tydzien, 
                        y=sprzedaz_tyg,
                        color=klienci_tyg)) + 
  geom_point() + 
  geom_smooth()


nbp <- readxl::read_xlsx("data/archiwum_tab_a_2014.xlsx")

nbp <- janitor::clean_names(nbp)

nbp_eur <- nbp %>%
  select(data, x1_eur) %>%
  mutate(data=as_date(data))

sklep27_full <- full_join(sklep27a, nbp_eur)

sklep27_left <- left_join(sklep27a, nbp_eur)

sklep27_inner <- inner_join(sklep27a, nbp_eur) %>%
  mutate(sprzedaz_pln=sprzedaz*x1_eur,
         miesiac=month(data))

sklep27_inner %>%
  group_by(miesiac) %>%
  summarise(suma_sprzedazy=sum(sprzedaz_pln)) %>%
  arrange(desc(suma_sprzedazy))

# szeroka i długa reprezentacja

spozycie <- readxl::read_xlsx("data/spozycie.xlsx")

spozycie_long <- gather(data = spozycie,
                        key = artykul,
                        value = wartosc,
                        -kod, -nazwa)

spozycie_long <- gather(data = spozycie,
                        key = artykul,
                        value = wartosc,
                        mieso, owoce, warzywa)

ggplot(spozycie_long, aes(x=nazwa, 
                          y=wartosc,
                          color=artykul)) +
  geom_point() + 
  coord_flip()

spozycie_wide <- spread(data = spozycie_long,
                        key = artykul,
                        value = wartosc)





