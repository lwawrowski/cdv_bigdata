library(tidyverse)

load("data/fifa.RData") # 1 sposób
mecze <- read_csv2("data/fifa.csv") # 2 sposób


# filtrowanie -------------------------------------------------------------

# Ile razy Włochy grały w finale MŚ?

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


# nowa kolumna ------------------------------------------------------------

# Jaka jest największa liczba bramek w jednym meczu?

fifa <- fifa %>% 
  mutate(goals_sum=home_team_goals+away_team_goals)

fifa %>% 
  select(year, home_team_name, away_team_name, goals_sum) %>% 
  arrange(desc(goals_sum))

fifa %>% 
  select(year, home_team_name, away_team_name, goals_sum) %>% 
  top_n(5, goals_sum)

# W zbiorze stwórz nową zmienną, która będzie zawierała bezwzględną różnicę pomiędzy wynikami zespołów.

fifa <- fifa %>% 
  mutate(goals_abs_diff=abs(home_team_goals-away_team_goals))


# podsumowanie ------------------------------------------------------------

# Jaka była średnia liczba widzów?

fifa %>% 
  summarise(mean_attendance=mean(attendance, na.rm = TRUE))

fifa_stats <- fifa %>% 
  summarise(mean_attendance=round(mean(attendance, na.rm = TRUE)),
            size=n())

fifa %>% 
  summarise(mean_goals=mean(goals_sum),
            median_goals=median(goals_sum),
            sd_goals=sd(goals_sum))

fifa %>% 
  summarise_at(vars(goals_sum), list(mean = mean, median = median, sd = sd))

fifa_stats_goals <- fifa %>% 
  summarise_at(vars(home_team_goals, away_team_goals), list(mean = mean, median = median, sd = sd))


# grupowanie --------------------------------------------------------------

fifa_stats <- fifa %>% 
  group_by(stage) %>% 
  summarise(mean_attendance=round(mean(attendance, na.rm = TRUE)),
            size=n())

fifa_stats <- fifa %>% 
  group_by(year) %>% 
  summarise(mean_attendance=round(mean(attendance, na.rm = TRUE)),
            size=n()) %>% 
  mutate(attendance_per_match=mean_attendance/size)

fifa %>% 
  group_by(year, stage) %>% 
  summarise(mean_goals=mean(goals_sum),
            median_goals=median(goals_sum),
            sd_goals=sd(goals_sum))


# liczebności -------------------------------------------------------------

# Jakie miasto najczęściej gościło piłkarzy?

cites <- fifa %>% 
  group_by(city) %>% 
  summarise(n=n())

cites <- fifa %>% 
  count(city)

cities_year <- fifa %>% 
  count(year, city)

cities_goals <- fifa %>% 
  group_by(city) %>% 
  summarise(n=n(),
            mean_goals=mean(goals_sum)) %>% 
  arrange(desc(mean_goals))
   
# Ile było meczów, w których drużyna prowadząca po pierwszej połowie ostatecznie przegrywała?
