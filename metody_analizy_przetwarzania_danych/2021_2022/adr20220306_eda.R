library(tidyverse)
library(readxl)

pracownicy <- read_xlsx("data/pracownicy.xlsx")

summary(pracownicy)

library(summarytools)

view(dfSummary(pracownicy))

freq(pracownicy$plec)

descr(pracownicy$bwynagrodzenie)

library(dlookr)

diagnose(pracownicy)

diagnose_numeric(pracownicy)

diagnose_category(iris)

diagnose_outlier(pracownicy)

library(dataReporter)

makeDataReport(pracownicy, output = "html")

summarize(pracownicy)

