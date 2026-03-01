library(tidyverse)

smog <- read_csv2("data/smog_pszczyna.csv")

smog <- smog %>% 
  mutate(pm10_poziom=if_else(condition = pm10 < 50, true = "w normie", false = "podwyższony"),
         tmin_zero=if_else(tmin_daily < 0, "poniżej 0", "powyżej 0"))

ggplot(data = smog, mapping = aes(x = tmax_daily, y = tmin_daily)) +
  geom_point()

smog2017 <- smog %>%  
  filter(rok == 2017)

# test niezależności

# H0: poziom pm10 i kategoria temperatury są niezależne
# H1: poziom pm10 i kategoria temperatury nie są niezależne

# alfa = 0.05
# p = 95%

# tablica kontyngencji
table(smog$pm10_poziom, smog$tmin_zero)
chisq.test(table(smog$pm10_poziom, smog$tmin_zero))

# wartość p < alfa -> odrzucamy hipotezę zerową
# poziom pm10 i kategoria temperatury nie są niezależne

# test propocji

# H0: odsetek palaczy w obu grupach jest taki sam
# H1: odsetek palaczy w obu grupach nie jest taki sam

# alfa = 0.05

prop.test(x = c(200,250), n = c(500,600))

# wartość p > alfa -> nie mamy podstaw do odrzucenia hipotezy zerowej
# odsetek palaczy w obu grupach jest taki sam

# test normalności

hist(smog2017$t2m_mean_daily)

# H0: rozkład temperatury jest normalny
# H1: rozkład temperatury nie jest normalny

# alfa = 0.05

shapiro.test(smog$t2m_mean_daily)

# wartość p < alfa -> odrzucamy hipotezę zerową
# rozkład temperatury nie jest normalny

ggplot(smog2017, aes(sample = t2m_mean_daily)) +
  stat_qq() +
  stat_qq_line()

# zadanie

hist(smog2017$tmin_daily)

shapiro.test(smog2017$tmin_daily)

ggplot(smog2017, aes(sample = tmin_daily)) +
  stat_qq() +
  stat_qq_line()

# test dla dwóch grup
# próby zależne

# H0: temp min = temp max
# H1: temp min != temp max

# alfa = 0.05

shapiro.test(smog2017$tmin_daily)
shapiro.test(smog2017$tmax_daily)

wilcox.test(x = smog2017$tmin_daily, y = smog2017$tmax_daily, paired = TRUE)

# wartość p < alfa -> odrzucamy H0
# temp min != temp max

t.test(x = smog2017$tmin_daily, y = smog2017$tmax_daily, paired = TRUE)

# próby niezależne
# H0: średnia temp nie różni się w 2 grupach poziomu pm10
# H1: średnia temp różni się w 2 grupach poziomu pm10

# alfa = 0.05

wilcox.test(smog2017$t2m_mean_daily ~ smog2017$pm10_poziom)
wilcox.test(t2m_mean_daily ~ pm10_poziom, data = smog2017)

# wartość p < alfa -> odrzucamy H0
# średnia temp różni się w 2 grupach poziomu pm10

# testy dla wielu prób

ggplot(smog2017, aes(x=t2m_mean_daily, y = kwartal)) +
  geom_boxplot()

# H0: temperatura we wszystkich kwartałach jest taka sama
# H1: istnieje co najmniej jedna para kwartałów o różnej temperaturze

# alfa = 0.05

kruskal.test(smog2017$t2m_mean_daily ~ smog2017$kwartal)
# wartość p < alfa -> odrzucamy H0
# istnieje co najmniej jedna para kwartałów o różnej temperaturze

pairwise.wilcox.test(x = smog2017$t2m_mean_daily, g = smog2017$kwartal)
# wszystkie pary kwartałów różnią się istotnie

# ANOVA
temp_kw_aov <- aov(smog2017$t2m_mean_daily ~ smog2017$kwartal)
summary(temp_kw_aov)

TukeyHSD(temp_kw_aov)

# alternatywnie bez tworzenia obiektu
summary(aov(smog2017$t2m_mean_daily ~ smog2017$kwartal))
TukeyHSD(aov(smog2017$t2m_mean_daily ~ smog2017$kwartal))
