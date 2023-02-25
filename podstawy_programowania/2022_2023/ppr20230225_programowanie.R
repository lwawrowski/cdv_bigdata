# generowanie danych

rnorm(10)

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=rnorm(10), x4=rnorm(10))

dane$w1 <- (min(dane$x1)-max(dane$x1))/mean(dane$x1)
dane$w2 <- (min(dane$x2)-max(dane$x2))/mean(dane$x2)
dane$w3 <- (min(dane$x3)-max(dane$x3))/mean(dane$x3)
dane$w4 <- (min(dane$x4)-max(dane$x4))/mean(dane$x4)

# funkcje

oblicz_wskaznik <- function(x){
  
  wskaznik <- (min(x)-max(x))/median(x)
  
  return(wskaznik)
  
}

dane$w1 <- oblicz_wskaznik(dane$x1)
dane$w2 <- oblicz_wskaznik(dane$x2)
dane$w3 <- oblicz_wskaznik(dane$x3)
dane$w4 <- oblicz_wskaznik(dane$x4)

przeskaluj01 <- function(x){
  
  z <- (x - min(x))/(max(x)-min(x))
  
  return(z)
  
}

przeskaluj01 <- function(x){
  
  (x - min(x))/(max(x)-min(x))

}


dane$z1 <- przeskaluj01(dane$x1)
dane$z2 <- przeskaluj01(dane$x2)
dane$z3 <- przeskaluj01(dane$x3)
dane$z4 <- przeskaluj01(dane$x4)

plot(dane$x1, dane$z1)

# warunki

sprawdz_liczbe <- function(liczba){
  
  if(is.character(liczba)){
    stop("Argument jest tekstem")
  } else if(is.na(liczba)){
    stop("Argument jest brakiem danych")
  }
  
  if(liczba > 0){
    print("Liczba większa od 0")
  } else if(liczba < 0){
    print("Liczba mniejsza od 0")
  } else{
    print("Liczba równa 0")
  }
  
}

sprawdz_liczbe(9)
sprawdz_liczbe(0)
sprawdz_liczbe("abc")
sprawdz_liczbe(NA)

# ifelse v1

liczba <- 10

tekst <- ifelse(test = liczba > 0, yes = "Liczba większa od 0", no = "Liczba <= 0")

if(liczba > 0){
  tekst <- "Liczba większa od 0"
} else{
  tekst <- "Liczba <= 0"
}

# ifelse v2

tekst <- ifelse(test = liczba > 0, yes = "Liczba większa od 0", 
                no = ifelse(liczba < 0, "Liczba mniejsza od 0", "Liczba równa 0"))

if(liczba > 0){
  tekst <- "Liczba większa od 0"
} else if(liczba < 0){
  tekst <- "Liczba mniejsza od 0"
} else{
  tekst <- "Liczba równa 0"
}

# przykład na danych

dane$tekst <- ifelse(test = dane$x1 > 0, yes = "Liczba większa od 0", 
                     no = ifelse(dane$x1 < 0, "Liczba mniejsza od 0", "Liczba równa 0"))

# zadanie

czy_podzielna35 <- function(liczba){
  
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

czy_podzielna35(15)
czy_podzielna35(17)
czy_podzielna35(12)
czy_podzielna35(10)


for(month in 1:length(month.name)){
  
  print(month.name[month])
  
}

seq_along(month.name)
1:length(month.name)

for(month in seq_along(month.name)){
  
  print(month.name[month])
  
}

for(month in month.name){
  
  print(month)
  
}

# rzut kostką

wynik_kostka <- numeric(1000000)

for(rzut in seq_along(wynik_kostka)){
  
  wynik_kostka[rzut] <- sample(x = 1:6, size = 1)
  
}

wynik_kostka
mean(wynik_kostka)
table(wynik_kostka)

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
