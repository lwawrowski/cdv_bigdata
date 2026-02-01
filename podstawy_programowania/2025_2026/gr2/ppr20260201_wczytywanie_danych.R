library(tidyverse)

wybory <- read_csv2(file = "data/wybory2025.csv")

# library(readr)
# wybory2025 <- read_delim("data/wybory2025.csv", 
#                          delim = ";", escape_double = FALSE, trim_ws = TRUE)
# View(wybory2025)

summary(wybory$Gmina)
summary(wybory$`Teryt Gminy`)

wybory_clean <- janitor::clean_names(wybory) 

# plik movies

movies <- read_csv("data/movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")

summary(movies)

# zapisywanie

write_csv2(x = wybory_clean, file = "data/wybory.csv")

save(wybory_clean, movies, file = "data/wybory_movies.RData") # .rda

# czyszczenie zawartości pamięci
# wczytywanie

wybory2025 <- read_csv2("data/wybory.csv")

load(file = "data/wybory_movies.RData")
