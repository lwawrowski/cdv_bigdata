# generowanie danych

rnorm(10)
rnorm(10, 170, 10)

hist(rnorm(10000))

runif(10)
hist(runif(10000))
round(runif(10, 1, 100))

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=rnorm(10), x4=rnorm(10))

w1 <- (min(dane$x1)-max(dane$x1))/mean(dane$x1)
w2 <- (min(dane$x2)-max(dane$x2))/mean(dane$x2)
w3 <- (min(dane$x3)-max(dane$x3))/mean(dane$x3)
w4 <- (min(dane$x4)-max(dane$x4))/mean(dane$x4)

# funkcje

oblicz_wskaznik <- function(x){
  
  wskaznik <- (min(x)-max(x))/median(x)
  
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

# sposób 2
przeskaluj01 <- function(x){
  
  (x-min(x))/(max(x)-min(x))
  
}

# sposób 3
przeskaluj01 <- function(x) (x-min(x))/(max(x)-min(x)) 

# warunki

liczba <- 10

sprawdz_liczbe <- function(liczba){
  
  if(is.character(liczba)){
    stop("Argument jest tekstem")
  } else if(is.na(liczba)){
    stop("Argument jest brakiem danych")
  }
  
  if(liczba > 0){
    print("Liczba jest większa od 0")
  } else if(liczba < 0){
    print("Liczba jest mniejsza od 0")
  } else{
    print("Liczba jest równa 0")
  }
  
}

sprawdz_liczbe(-10)
sprawdz_liczbe(0)
sprawdz_liczbe(10)
sprawdz_liczbe("abc")
sprawdz_liczbe("")
sprawdz_liczbe(NA)

# ifelse

# sposób 1
tekst <- ifelse(test = liczba > 0, 
                yes = "Liczba większa od 0", 
                no = "Liczba nie jest większa od 0")

print(tekst)

# sposób 2
if(liczba > 0){
  tekst <- "Liczba większa od 0"
} else {
  tekst <- "Liczba nie jest większa od 0"
}

print(tekst)

# operacje na danych

dane$x1_tekst <- ifelse(dane$x1 > 0, "Liczba > 0", "Liczba <= 0")

dane$x1_tekst <- ifelse(test = dane$x1 > 0, yes = "Liczba > 0", 
                        no = ifelse(test = dane$x1 < 0, yes = "Liczba < 0", no = "Liczba = 0"))

library(tidyverse)

dane <- dane %>% 
  mutate(z1_tekst=case_when(
    z1 == 0 ~ "Liczba = 0",
    z1 < 0.5 ~ "Liczba < 0.5",
    z1 >= 0.5 ~ "Liczba >= 0.5"
  ))

dane <- dane %>% 
  mutate(z1_tekst=if_else(z1 == 0, "Liczba = 0", 
                          if_else(z1 < 0.5, "Liczba < 0.5", "Liczba >= 0.5")))

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

# pętla

month.name

# magiczna liczba 12
for(month in 1:12){
  
  print(month.name[month])
  
}

# długość wektora
for(month in 1:length(month.name)){
  
  print(month.name[month])
  
}

# użycie seq_along
for(month in seq_along(month.name)){
  
  print(month.name[month])
  
}

# użycie iteratora
month_upper <- character(length(month.name))

for(month in seq_along(month.name)){
  
  month_upper[month] <- toupper(month.name[month])
  
}

month_upper

# iterowanie elementów
for(month in month.name){
  
  print(month)
  
}

# rzut kostką

wynik_kostka <- numeric(1000000)

for(i in 1:1000000){
  
  wynik_kostka[i] <- sample(1:6, 1)
  
}

wynik_kostka
mean(wynik_kostka)
table(wynik_kostka)

wynik_kostka_vec <- sample(1:6, 1000000, replace = T)
mean(wynik_kostka_vec)

# zadanie

for(i in seq(99,1,-1)){
  if(i == 1){
    print('1 bottle of beer on the wall, 1 bottle of beer! So take it down, pass it around, no more bottles of beer on the wall!')
  } else if(i == 2){
    print('2 more bottles of beer on the wall, 2 more bottles of beer! So take one down, pass it around, 1 more bottle of beer on the wall!')
  } else {
    print(paste0(i,' bottles of beer on the wall, ', i, ' bottles of beer! So take it down, pass it around,', i - 1, 'more bottles of beer on the wall!'))
  }
}
