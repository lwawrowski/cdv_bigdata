library(tidyverse)

wybory <- read_csv2(file = "data/wybory2023.csv")

summary(wybory)

summary(wybory$`Nr okręgu`)
summary(wybory$Siedziba)

wybory <- janitor::clean_names(wybory)

save(wybory, file = "data/wybory.rda")

write_csv(wybory, "data/wybory.csv")

movies <- read_csv("C:\\Users\\lukas\\Downloads\\movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")


