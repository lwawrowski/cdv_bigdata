# generowanie danych

rnorm(10)

rnorm(30, 170, 10)

hist(rnorm(10000))

runif(10)

runif(30, 0, 100)

hist(runif(10000))

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=runif(10), x4=runif(10))
dane

w1 <- mean(dane$x1)/median(dane$x1)
w2 <- mean(dane$x2)/median(dane$x2)
w3 <- mean(dane$x3)/median(dane$x3)
w4 <- mean(dane$x4)/median(dane$x4)

# funkcje -----------------------------------------------------------------

oblicz_wskaznik <- function(x){
  
  wskaznik <- mean(x)/sd(x)
  
  return(wskaznik)
  
}

w1 <- oblicz_wskaznik(dane$x1)
w2 <- oblicz_wskaznik(dane$x2)
w3 <- oblicz_wskaznik(dane$x3)
w4 <- oblicz_wskaznik(dane$x4)

# 1 sposób
normalize <- function(x) {
  # Normalizowanie wartości cechy w zakresie od 0 do 1
  return((x - min(x)) / (max(x) - min(x)))
}

dane$z1 <- normalize(dane$x1)
dane$z2 <- normalize(dane$x2)
dane$z3 <- normalize(dane$x3)
dane$z4 <- normalize(dane$x4)

plot(dane$x1, dane$z1)

# 2 sposób
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# 3 sposób
normalize <- function(x) (x - min(x)) / (max(x) - min(x))

# 4 sposób
normalize <- \(x) (x - min(x)) / (max(x) - min(x))

# warunki -----------------------------------------------------------------

wartosc <- 0

sprawdz_wartosc <- function(wartosc){
  
  if(is.na(wartosc)){
    stop("Podana wartość to NA")
  }
  if(is.character(wartosc)){
    stop("Podana wartość to tekst")
  }
  
  if(wartosc > 0){
    print("Wartość > 0")
  } else if(wartosc < 0){
    print("Wartość < 0")
  } else {
    print("Wartość = 0")
  }
  
}

rm(wartosc)
sprawdz_wartosc(55)
sprawdz_wartosc(-9)
sprawdz_wartosc(0)
sprawdz_wartosc(NA)
sprawdz_wartosc("abc")

# ifelse - funkcja JEŻELI w Excelu

wartosc <- 10
ifelse(test = wartosc > 0, yes = "Wartość > 0", no = "Wartość < 0")

dane$x1_zero <- ifelse(dane$x1 > 0, "wartość > 0", "wartość < 0")

dane$z1_zero <- ifelse(dane$z1 > 0, "wartość > 0", 
                       ifelse(dane$z1 < 0, "wartość < 0", "wartość = 0"))

library(tidyverse)

dane <- dane %>% 
  mutate(z1_zero = ifelse(z1 > 0, "wartość > 0", 
                          ifelse(z1 < 0, "wartość < 0", "wartość = 0")))

dane <- dane %>% 
  mutate(z1_zero = case_when(
    z1 > 0 ~ "wartość > 0",
    z1 < 0 ~ "wartość < 0",
    z1 == 0 ~ "wartość = 0"
  ))

# zadanie

sprawdz_liczbe <- function(liczba) {
  if (liczba %% 3 == 0 && liczba %% 5 == 0) {
    return("Liczba podzielna przez 3 i 5")
  } else if (liczba %% 3 == 0) {
    return("Liczba podzielna przez 3")
  } else if (liczba %% 5 == 0) {
    return("Liczba podzielna przez 5")
  } else {
    return("Liczba niepodzielna ani przez 3 ani przez 5")
  }
}

sprawdz_liczbe(15)


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
  rzut_kostka[rzut] <- sample(1:6,1)
}

rzut_kostka
mean(rzut_kostka)
table(rzut_kostka)

rzut_kostka_vec <- sample(1:6, 10000, replace = T)

mean(rzut_kostka_vec)
table(rzut_kostka_vec)
