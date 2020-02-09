library(tidyverse)
library(readxl)

pracownicy <- read_excel("data/pracownicy.xlsx")

summary(pracownicy)

library(summarytools)

view(dfSummary(pracownicy))

freq(pracownicy$kat_pracownika)

descr(pracownicy$bwynagrodzenie)





