library(tidyverse)
library(readxl)

dane <- read_excel(path = "data/wybory2020.xlsx")

summary(dane)

mean(dane$Frekwencja)
mean(dane$`% głosów nieważnych`, na.rm = TRUE)

dane_czyste <- janitor::clean_names(dane)

mean(dane_czyste$percent_glosow_niewaznych, na.rm = TRUE)

# zapisanie danych
save(dane_czyste, file = "data/wybory.rda")
