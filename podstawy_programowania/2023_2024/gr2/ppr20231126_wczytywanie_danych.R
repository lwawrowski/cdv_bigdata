library(tidyverse)

wybory <- read_csv2(file = "data/wybory2023.csv")

summary(wybory)

summary(wybory$Siedziba)
summary(wybory$`Liczba komisji`)

wybory <- janitor::clean_names(wybory)

summary(wybory$liczba_komisji)

write_csv2(x = wybory, file = "data/wybory.csv")
save(wybory, file = "data/wybory.rda")

load("data/wybory.rda")
wybory <- read_csv2("data/wybory.csv")

# zadanie

movies <- read_csv("C:\\Users\\lukas\\Downloads\\movies.csv")
movies <- read_csv("C:/Users/lukas/Downloads/movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")

