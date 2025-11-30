library(tidyverse)

wybory <- read_csv2(file = "data/wybory2025.csv")

summary(wybory)

wybory$`Liczba niewykorzystanych kart do głosowania`
wybory$Gmina

wybory_clean <- janitor::clean_names(dat = wybory)

# movies

movies <- read_csv(file = "data/movies.csv")
movies <- read_csv(file = "http://wawrowski.edu.pl/data/movies.csv")

summary(movies)

# zapisywanie danych

write_csv2(x = wybory_clean, file = "data/wybory.csv")

save(wybory_clean, file = "data/wybory.RData")

wybory <- read_csv2(file = "data/wybory.csv")

load(file = "data/wybory.RData")
