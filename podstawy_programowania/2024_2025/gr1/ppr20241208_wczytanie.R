library(tidyverse)

wybory <- read_csv2("data/wybory2023.csv")
wybory

summary(wybory)

wybory$`Nr komisji`
wybory$Siedziba

wybory <- janitor::clean_names(wybory)

save(wybory, file = "data/wybory.RData") # .rda
write_csv2(x = wybory, file = "data/wybory.csv")

movies <- read_csv("data/movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")
