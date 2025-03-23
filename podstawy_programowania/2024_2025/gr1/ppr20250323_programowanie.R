# generowanie danych

rnorm(20)

hist(rnorm(10000))

rnorm(30, 170, 10)

runif(10)
runif(30, 0, 100)

hist(runif(10000))

dane <- data.frame(x1=rnorm(20), x2=rnorm(20), x3=runif(20), x4=runif(20))

w1 <- mean(dane$x1)/sum(dane$x1)
w2 <- mean(dane$x2)/sum(dane$x2)
w3 <- mean(dane$x3)/sum(dane$x3)
w4 <- mean(dane$x4)/sum(dane$x4)

# funkcje

oblicz_wskaznik <- function(x){
  
  wskaznik <- mean(x)/sd(x)
  
  return(wskaznik)
  
}

w1 <- oblicz_wskaznik(dane$x1)
w2 <- oblicz_wskaznik(dane$x2)
w3 <- oblicz_wskaznik(dane$x3)
w4 <- oblicz_wskaznik(dane$x4)

# 1 sposób
normalizuj <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

dane$z1 <- normalizuj(dane$x1)
dane$z2 <- normalizuj(dane$x2)
dane$z3 <- normalizuj(dane$x3)
dane$z4 <- normalizuj(dane$x4)

plot(dane$x1, dane$z1)

# 2 sposób
normalizuj <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# 3 sposób
normalizuj <- function(x) (x - min(x)) / (max(x) - min(x))

normalizuj(dane$x1)

# 4 sposób
normalizuj <- \(x) (x - min(x)) / (max(x) - min(x))

normalizuj(dane$x1)


# warunki -----------------------------------------------------------------

liczba <- 0

sprawdz_liczbe <- function(liczba){
  
  if(is.na(liczba)){
    stop("Argument jest brakiem danych")
  }
  if(is.character(liczba)){
    stop("Argument jest tekstem")
  }
  
  if(liczba > 0){
    print("Liczba większa od 0")
  } else if(liczba < 0) {
    print("Liczba mniejsza od 0")
  } else{
    print("Liczba jest równa 0")
  }
  
}

sprawdz_liczbe(100)
sprawdz_liczbe(-10)
sprawdz_liczbe(NA)
sprawdz_liczbe("abc")

# ifelse

# funkcja jeżeli w Excelu
ifelse(test = liczba > 0, yes = "Liczba > 0", no = "Liczba <= 0")
dane$x1_zero <- ifelse(test = dane$x1 > 0, 
                       yes = "Liczba > 0", 
                       no = "Liczba <= 0")

dane$x1_zero <- ifelse(test = dane$x1 > 0, 
                       yes = "Liczba > 0", 
                       no = ifelse(dane$x1 < 0, 
                                   "Liczba < 0", 
                                   "Liczba = 0"))

library(tidyverse)

dane <- dane %>% 
  mutate(x1_zero = ifelse(test = x1 > 0, 
                          yes = "Liczba > 0", 
                          no = ifelse(x1 < 0, 
                                      "Liczba < 0", 
                                      "Liczba = 0")))

dane <- dane %>% 
  mutate(x2_zero = case_when(
    x2 < 0 ~ "Liczba < 0",
    x2 > 0 ~ "Liczba > 0",
    x2 == 0 ~ "Liczba = 0"
  ))

# zadanie

sprawdz_podzielnosc <- function(liczba) {
  if (liczba %% 3 == 0 && liczba %% 5 == 0) {
    return("liczba podzielna przez 3 i 5")
  } else if (liczba %% 3 == 0) {
    return("liczba podzielna przez 3")
  } else if (liczba %% 5 == 0) {
    return("liczba podzielna przez 5")
  } else {
    return("liczba niepodzielna ani przez 3 ani przez 5")
  }
}

sprawdz_podzielnosc(15)

# pętle -------------------------------------------------------------------

month.name

for(month in 1:12){
  
  print(month.name[month])
  
}

for(month in 1:length(month.name)){
  print(month.name[month])
}

for(month in seq_along(month.name)){
  print(month.name[month])
}

for(month in month.name){
  print(month)
}

# toupper

month_upper <- character(length = length(month.name))

for(month in seq_along(month.name)){
  
  month_upper[month] <- toupper(month.name[month])
  
}

month_upper
toupper(month.name)

# rzut kostką

rzut_kostka <- numeric(10000)

for(rzut in seq_along(rzut_kostka)){
  
  rzut_kostka[rzut] <- sample(1:6, 1)
  
}

rzut_kostka
mean(rzut_kostka)
table(rzut_kostka)

rzut_kostka_vec <- sample(1:6, 10000, replace = T)

rzut_kostka_vec
mean(rzut_kostka_vec)
table(rzut_kostka_vec)
