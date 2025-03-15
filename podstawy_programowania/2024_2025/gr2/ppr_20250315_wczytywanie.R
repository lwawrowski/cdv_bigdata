library(tidyverse)

wybory <- read_csv2("data/wybory2023.csv")
wybory

summary(wybory)

wybory$`Liczba wyborców uprawnionych do głosowania`
wybory$Siedziba

wybory <- janitor::clean_names(wybory)

wybory$liczba_wyborcow_uprawnionych_do_glosowania

save(wybory, file = "data/wybory.RData") # .rda
load("data/wybory.RData")

write_csv2(x = wybory, file = "data/wybory.csv")

wybory_parlament <- read_csv2("data/wybory.csv")

movies <- read_csv("data/movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")
