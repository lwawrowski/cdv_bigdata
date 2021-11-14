library(tidyverse)
library(readxl)

dane <- read_xlsx(path = "data/wybory2020.xlsx")

summary(dane)

mean(dane$Frekwencja)
mean(dane$`% głosów ważnych`, na.rm=TRUE)

wybory <- janitor::clean_names(dane)

summary(wybory)

mean(wybory$percent_glosow_waznych, na.rm=TRUE)

save(wybory, file = "data/wybory.rda")

write_csv(x = wybory, file = "data/wybory.csv")

movies <- read_csv(file = "http://wawrowski.edu.pl/data/movies.csv")

movies <- read_csv(file = "data/movies.csv")
