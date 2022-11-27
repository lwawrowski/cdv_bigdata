library(tidyverse)
library(readxl)

fifa <- read_xlsx(path = "data/WorldCupMatches.xlsx")

summary(fifa)

mean(fifa$Attendance, na.rm = TRUE)

summary(fifa$`Home Team Name`)

fifa <- janitor::clean_names(fifa)

summary(fifa$home_team_name)

save(fifa, file = "data/fifa.RData")

write_csv2(fifa, "data/fifa.csv")

movies <- read_csv("data/movies.csv")
movies <- read_csv("http://wawrowski.edu.pl/data/movies.csv")

