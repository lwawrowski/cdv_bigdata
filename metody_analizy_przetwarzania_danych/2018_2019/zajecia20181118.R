library(tidyverse)
library(readxl)
library(e1071)

rossmann <- read_xlsx("rossmann.xlsx")

n_sklep_asort <- count(rossmann, sklep_asort)

count(rossmann, sklep_asort)

rossmann %>%
  count(sklep_asort)

# analiza struktury

rossmann2 <- rossmann %>%
  filter(sklep_id == 842 | sklep_id == 15) %>%
  filter(czy_otwarty == "Tak")

rossmann2 <- rossmann %>%
  filter(sklep_id == 842 | sklep_id == 15,
         czy_otwarty == "Tak")

rossmann2 <- filter(filter(rossmann, sklep_id == 842 | sklep_id == 15),czy_otwarty == "Tak") 

rossmann2 %>%
  group_by(sklep_id) %>%
  summarise(liczebnosc = n(),
            srednia = mean(sprzedaz),
            odchylenie = sd(sprzedaz),
            wspolczynnik_zm = odchylenie/srednia*100,
            skosnosc = skewness(sprzedaz),
            kurtoza = kurtosis(sprzedaz))

rossmann2 %>%
  group_by(sklep_id) %>%
  summarise(mediana = median(sprzedaz),
            kwartyl1 = quantile(sprzedaz, 0.25),
            kwartyl3 = quantile(sprzedaz, 0.75))

boxplot(sprzedaz ~ sklep_id, data = rossmann2, 
        horizontal = TRUE)

t.test(sprzedaz ~ sklep_id, data = rossmann2)

# sprzedaż w sklepie nr 15 odchyla się średnio od
# średniej o +/- 1682 euro

rossmann3 <- rossmann %>%
  filter(czy_otwarty == "Tak")

rossmann3 %>%
  group_by(sklep_typ) %>%
  summarise(liczebnosc = n(),
            srednia = mean(liczba_klientow),
            odchylenie = sd(liczba_klientow),
            wspolczynnik_zm = odchylenie/srednia*100,
            skosnosc = skewness(liczba_klientow),
            kurtoza = kurtosis(liczba_klientow))

boxplot(liczba_klientow ~ sklep_typ, data = rossmann3, 
        horizontal = TRUE)

anova <- aov(liczba_klientow ~ sklep_typ, data = rossmann3)
summary(anova)

TukeyHSD(anova)
