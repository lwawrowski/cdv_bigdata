# generowanie danych

rnorm(10)
rnorm(30, 170, 10)

hist(rnorm(100000))

runif(10)
runif(30, 0, 100)
round(runif(30, 0, 100))

hist(runif(100000))

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=rnorm(10), x4=rnorm(10))

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

# zadanie

# sposób 1
przeskaluj01 <- function(x){
  
  z <- (x-min(x))/(max(x)-min(x))
  
  return(z)
  
}

dane$z1 <- przeskaluj01(dane$x1)
dane$z2 <- przeskaluj01(dane$x2)
dane$z3 <- przeskaluj01(dane$x3)
dane$z4 <- przeskaluj01(dane$x4)

plot(dane$x1, dane$z1)

# sposób 2

przeskaluj01 <- function(x){
  
  (x-min(x))/(max(x)-min(x))
  
}

# sposób 3

przeskaluj01 <- function(x) (x-min(x))/(max(x)-min(x))

# warunki

liczba <- 10

sprawdz_liczbe <- function(liczba){
  
  if(is.na(liczba)){
    stop("Argument liczba jest brakiem danych")
  } else if(is.character(liczba)){
    stop("Argument jest tekstem")
  }
  
  if(liczba > 0){
    print("Liczba większa od 0")
  } else if(liczba < 0){
    print("Liczba mniejsza od 0")
  } else {
    print("Liczba równa 0")
  }
  
}

sprawdz_liczbe(10)
sprawdz_liczbe(-10)
sprawdz_liczbe(NA)
sprawdz_liczbe("abc")

# ifelse

# sposób 1
wynik <- ifelse(test = liczba > 0, 
                yes = "Liczba większa od 0", 
                no = "Liczba mniejsza od 0")
print(wynik)

# sposób 2
if(liczba > 0){
  wynik <- "Liczba większa od 0"
} else {
  wynik <- "Liczba mniejsza od 0"
}
print(wynik)

# operacje na danych

dane$x1_tekst <- ifelse(dane$x1 > 0, "Liczba większa od 0", "Liczba mniejsza od 0")

dane$z1_tekst <- ifelse(dane$z1 > 0, "Liczba większa od 0", 
                        ifelse(dane$z1 < 0, "Liczba mniejsza od 0", "Liczba równa 0"))

library(tidyverse)

dane <- dane %>% 
  mutate(z1_tekst = case_when(
    z1 < 0 ~ "Liczba mniejsza od 0",
    z1 > 0 ~ "Liczba większa od 0",
    z1 == 0 ~ "Liczba równa 0"
  ))

# zadanie

czy_podzielna35 <- function(liczba){
  
  if(liczba %% 3 == 0 && liczba %% 5 == 0){
    print("Liczba podzielna przez 3 i 5")
  } else if(liczba %% 3 == 0){
    print("Liczba podzielna przez 3")
  } else if(liczba %% 5 == 0){
    print("Liczba podzielna przez 5")
  } else {
    print("Liczba niepodzielna ani przez 3 ani przez 5")
  }
  
}

czy_podzielna35(9)
czy_podzielna35(10)
czy_podzielna35(15)
czy_podzielna35(2)

# pętle

month.name

# 12 - magiczna liczba
for(month in 1:12){
  
  print(month.name[month])
  
}

# długość wektora
for(month in 1:length(month.name)){
  
  print(month.name[month])
  
}

# seq_along
for(month in seq_along(month.name)){
  
  print(month.name[month])
  
}

for(month in month.name){
  
  print(month)
  
}

month_upper <- character(length(month.name))

for(month in seq_along(month.name)){
  
  month_upper[month] <- toupper(month.name[month])
  
}

month_upper

# rzut kostką

rzut_kostka <- numeric(10000)

for(rzut in seq_along(rzut_kostka)){
  
  rzut_kostka[rzut] <- sample(1:6, 1)
  
}

rzut_kostka
mean(rzut_kostka)
table(rzut_kostka)

rzut_kostka_vec <- sample(1:6, 10000, replace = T)
mean(rzut_kostka_vec)
table(rzut_kostka_vec)











