library(tidyverse)

klienci <- read_csv("data/klienci.csv")

summary(klienci)

ggplot(klienci, aes(x = wskaznik_wydatkow,
                    y = roczny_dochod)) +
  geom_point()

klienci_z <- klienci %>% 
  select(wskaznik_wydatkow, roczny_dochod) %>% 
  scale()

# metoda k-średnich

grupy <- kmeans(x = klienci_z, centers = 5)

klienci$kmeans5 <- as.factor(grupy$cluster)

ggplot(klienci, aes(x = wskaznik_wydatkow,
                    y = roczny_dochod,
                    color = kmeans5)) +
  geom_point()

# algorytm kmeans++

library(ClusterR)

Optimal_Clusters_KMeans(data = klienci_z, 
                        max_clusters = 15,
                        criterion = "WCSSE")

grupy2 <- KMeans_rcpp(data = klienci_z, 
                      clusters = 5)

klienci$kmeans5_2 <- as.factor(grupy2$clusters)

ggplot(klienci, aes(x = wskaznik_wydatkow,
                    y = roczny_dochod,
                    color = kmeans5_2)) +
  geom_point()

# podsumowanie średnich
klienci %>% 
  select(wskaznik_wydatkow, 
         roczny_dochod, 
         kmeans5_2) %>% 
  group_by(kmeans5_2) %>% 
  summarise_all("mean")

# zadanie - auta

auta <- read_csv2("data/auta.csv")

auta_z <- auta %>% 
  select(pojemnosc:cena) %>% 
  scale()

Optimal_Clusters_KMeans(data = auta_z, 
                        max_clusters = 15,
                        criterion = "WCSSE")

library(clusterCrit)

auta_grupy <- KMeans_rcpp(data = auta_z, 
                          clusters = 3)

intCriteria(traj = auta_z, 
            part = as.integer(auta_grupy$clusters), 
            crit = "cal")

# metoda hierarchiczna

macierz_odl <- dist(klienci_z)

dendrogram <- hclust(d = macierz_odl,
                     method = "ward.D")

plot(dendrogram)

library(ggdendro)

ggdendrogram(dendrogram, rotate = TRUE)

grupy_dendro <- cutree(tree = dendrogram, 
                       k = 6)

klienci$dendro6 <- as.factor(grupy_dendro)

ggplot(klienci, aes(x = wskaznik_wydatkow,
                    y = roczny_dochod,
                    color = dendro6)) +
  geom_point()

# zadanie

row.names(auta_z) <- auta$model

auta_odl <- dist(auta_z)

auta_dendro <- hclust(d = auta_odl,
                      method = "ward.D")

# plot(auta_dendro)
ggdendrogram(auta_dendro)












