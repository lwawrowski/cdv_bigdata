library(tidyverse)

klienci <- read_csv("data/klienci.csv")
summary(klienci)

ggplot(klienci, aes(x = wskaznik_wydatkow, y = roczny_dochod)) +
  geom_point()

klienci_z <- klienci %>% 
  select(wskaznik_wydatkow, roczny_dochod) %>% 
  scale()

# metoda k-średnich
grupy1 <- kmeans(x = klienci_z, centers = 5)

klienci$grupy1 <- as.factor(grupy1$cluster)

ggplot(klienci, aes(x = wskaznik_wydatkow, 
                    y = roczny_dochod,
                    color = grupy1)) +
  geom_point()

library(ClusterR)

Optimal_Clusters_KMeans(data = klienci_z, 
                        max_clusters = 10, 
                        criterion = "WCSSE")

grupy2 <- KMeans_rcpp(data = klienci_z, clusters = 5)

klienci$grupy2 <- as.factor(grupy2$clusters)

ggplot(klienci, aes(x = wskaznik_wydatkow, 
                    y = roczny_dochod,
                    color = grupy2)) +
  geom_point()

klienci %>% 
  select(wskaznik_wydatkow, roczny_dochod, grupy2) %>% 
  group_by(grupy2) %>% 
  summarise_all("mean")

# metoda hierarchiczna

macierz_odl <- dist(klienci_z)

dendrogram <- hclust(d = macierz_odl, method = "ward.D")

plot(dendrogram)

library(ggdendro)

ggdendrogram(dendrogram, rotate = T)

grupy3 <- cutree(tree = dendrogram, k = 5)

klienci$grupy3 <- as.factor(grupy3)

ggplot(klienci, aes(x = wskaznik_wydatkow, 
                    y = roczny_dochod,
                    color = grupy3)) +
  geom_point()

