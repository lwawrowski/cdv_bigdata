library(tidyverse)

load("data/fifa.RData") # 1 sposób
mecze <- read_csv2("data/fifa.csv") # 2 sposób


# filtrowanie -------------------------------------------------------------

fifa_wlochy <- fifa %>% 
  filter(stage == "Final" & (home_team_name == "Italy" | away_team_name == "Italy"))

fifa %>% 
  filter(attendance > 100000)

fifa %>% 
  filter(city == "Rome" | city == "Paris" | city == "Berlin")

# wszystkie mecze w miastach "Rome", "Paris", "Berlin"
fifa %>% 
  filter(city %in% c("Rome", "Paris", "Berlin"))

# wszystkie mecze w miastach poza "Rome", "Paris", "Berlin"
fifa %>% 
  filter(!city %in% c("Rome", "Paris", "Berlin"))

# braki danych ------------------------------------------------------------

fifa_na <- fifa %>% 
  filter(!is.na(attendance))

complete.cases(fifa)

# argument z nazwą zbioru
fifa_bez_brakow <- fifa %>% 
  filter(complete.cases(fifa))

# argument jako kropka wskazująca na aktualny zbiór
fifa_bez_brakow <- fifa %>% 
  filter(complete.cases(.))

# nowa zmienna - niepoprawne działanie
fifa_z_brakami <- fifa %>% 
  mutate(braki=NA) %>% 
  filter(complete.cases(fifa))

# nowa zmienna - poprawne działanie
fifa_z_brakami <- fifa %>% 
  mutate(braki=NA) %>% 
  filter(complete.cases(.))

# nie bierzemy pod uwagę jednej zmiennej przy usuwaniu braków
fifa_bez_brakow <- fifa %>% 
  filter(complete.cases(
    select(., -win_conditions)
  ))

# wybieranie kolumn -------------------------------------------------------

fifa_wlochy %>% 
  select(year, home_team_name, home_team_goals, away_team_goals, away_team_name)

fifa_wlochy %>% 
  select(year, home_team_name:away_team_name)

fifa_wlochy %>% 
  select(year_of_match=year, home_team_name:away_team_name)

