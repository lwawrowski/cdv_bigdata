library(tidyverse)

klienci <- read.csv("data/klienci.csv")

ggplot(klienci, aes(x=wiek, y=roczny_dochod)) +
  geom_point()

ggplot(klienci, aes(x=wiek, y=wskaznik_wydatkow)) +
  geom_point()

ggplot(klienci, aes(x=wskaznik_wydatkow, y=roczny_dochod)) +
  geom_point()

klienci_z <- klienci %>%
  select(roczny_dochod, wskaznik_wydatkow) %>%
  scale()

grupy <- kmeans(x = klienci_z, centers = 5)

klienci$grupa <- as.factor(grupy$cluster)

ggplot(klienci, aes(x=wskaznik_wydatkow, 
                    y=roczny_dochod,
                    color=grupa)) +
  geom_point()

library(ClusterR)

Optimal_Clusters_KMeans(data = klienci_z, 
                        max_clusters = 15,
                        criterion = "WCSSE")

grupy2 <- KMeans_rcpp(data = klienci_z, clusters = 5)

klienci$grupa2 <- as.factor(grupy2$clusters)

ggplot(klienci, aes(x=wskaznik_wydatkow, 
                    y=roczny_dochod,
                    color=grupa2)) +
  geom_point()

klienci %>%
  # select(wiek, roczny_dochod, 
  #       wskaznik_wydatkow, grupa2) %>%
  select(-klientID, -plec, -grupa) %>%
  group_by(grupa2) %>%
  summarise_all(.funs = "mean")

# zadanie

wlkp <- readxl::read_xlsx("data/dane_wlkp_2017.xlsx")

GGally::ggpairs(wlkp[,3:8])

wlkp_z <- wlkp %>%
  select(-kod, -nazwa, -dlugosc_zywoplotow) %>%
  scale()

corrplot::corrplot(cor(wlkp_z))

Optimal_Clusters_KMeans(data = wlkp_z, 
                        max_clusters = 15,
                        criterion = "WCSSE")

wlkp_g <- KMeans_rcpp(data = wlkp_z, clusters = 6)

wlkp$grupa <- as.factor(wlkp_g$clusters)

ggplot(wlkp, aes(x=stopa_bezr, 
                    y=pomoc_spoleczna,
                    color=grupa)) +
  geom_point()

wlkp_sr <- wlkp %>%
  select(-kod, -nazwa, -dlugosc_zywoplotow) %>%
  group_by(grupa) %>%
  summarise_all("mean")
