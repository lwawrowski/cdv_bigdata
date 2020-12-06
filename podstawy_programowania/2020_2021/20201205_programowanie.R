rnorm(10)

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=rnorm(10), x4=rnorm(10))

dane$w1 <- (min(dane$x1)-max(dane$x1))/mean(dane$x1)
dane$w2 <- (min(dane$x2)-max(dane$x2))/mean(dane$x2)
dane$w3 <- (min(dane$x3)-max(dane$x3))/mean(dane$x3)
dane$w4 <- (min(dane$x4)-max(dane$x4))/mean(dane$x4)

oblicz_wskaznik <- function(x){
  
  wskaznik <- (min(x)-max(x))/median(x)
  
  return(wskaznik)
  
}

dane$w1 <- oblicz_wskaznik(x = dane$x1)
dane$w2 <- oblicz_wskaznik(x = dane$x2)
dane$w3 <- oblicz_wskaznik(x = dane$x3)
dane$w4 <- oblicz_wskaznik(x = dane$x4)

przeskaluj01 <- function(x){
  
  z <- (x-min(x))/(max(x)-min(x))
  
  return(z)
  
}

dane$z1 <- przeskaluj01(dane$x1)
dane$z2 <- przeskaluj01(dane$x2)
dane$z3 <- przeskaluj01(dane$x3)
dane$z4 <- przeskaluj01(dane$x4)

plot(dane$x1, dane$z1)

# warunki

czy_jest0 <- function(liczba){
  
  if(is.character(liczba)){
    stop("Liczba jest tekstem")
  }
  stopifnot(!is.na(liczba))
  
  if(liczba > 0){
    print(paste("Liczba", liczba, "jest > 0"))
  } else if(liczba < 0){
    print("Liczba < 0")
  } else {
    print("Liczba jest równa 0")
  }
  
}

czy_jest0(105)
czy_jest0(NA)
czy_jest0("abc")

czy_podzielna3i5 <- function(liczba){
  
  if(liczba %% 3 == 0 && liczba %% 5 == 0){
    print("Liczba podzielna przez 3 i 5")
  } else if(liczba %% 5 == 0){
    print("Liczba podzielna przez 5")
  } else if(liczba %% 3 == 0){
    print("Liczba podzielna przez 3")
  } else {
    print("Liczba niepodzielna ani przez 3 ani przez 5")
  }
  
}

czy_podzielna3i5(17)

# pętle

month.name
length(month.name)

1:12
seq_along(month.name)

# rzut kostką

wynik_kostka <- numeric(10000)

for(rzut in 1:length(wynik_kostka)){
  
  wynik_rzut <- sample(x = 1:6, size = 1)
  
  wynik_kostka[rzut] <- wynik_rzut
  
}

wynik_kostka
table(wynik_kostka)

abc <- ifelse(test = 15 > 0, yes = "Jest > 0", no = "Jest <= 0")

dane$x1w0 <- ifelse(dane$x1 > 0, "Większe od 0", "Mniejsze od 0")

library(tidyverse)

load("data/wybory.rda")

dane_czyste <- dane_czyste %>% 
  mutate(wygrany=ifelse(andrzej_sebastian_duda > rafal_kazimierz_trzaskowski, "AD", 
                        ifelse(andrzej_sebastian_duda == rafal_kazimierz_trzaskowski, "remis", "RT")),
         wygrany2=if_else(andrzej_sebastian_duda > rafal_kazimierz_trzaskowski, "AD", 
                          if_else(andrzej_sebastian_duda == rafal_kazimierz_trzaskowski, "remis", "RT")))

table(dane_czyste$wygrany)
table(dane_czyste$wygrany2) 

ifelse(-15 > 0, "Tak", 0)
if_else(-15 > 0, "Tak", 0)

for(i in seq(99,0,-1)){
  if(i == 1){
    print('1 bottle of beer on the wall, 1 bottle of beer! So take it down, pass it around, no more bottles of beer on the wall!')
  } else if(i == 2){
    print('2 more bottles of beer on the wall, 2 more bottles of beer! So take one down, pass it around, 1 more bottle of beer on the wall!')
  } else {
    print(paste0(i,' bottles of beer on the wall, ', i, ' bottles of beer! So take it down, pass it around,', i - 1, 'more bottles of beer on the wall!'))
  }
}

