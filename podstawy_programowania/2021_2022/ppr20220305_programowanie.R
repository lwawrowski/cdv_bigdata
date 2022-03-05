rnorm(10)

dane <- data.frame(x1=rnorm(10), x2=rnorm(10), x3=rnorm(10), x4=rnorm(10))

dane$w1 <- (min(dane$x1)-max(dane$x1))/mean(dane$x1)
dane$w2 <- (min(dane$x2)-max(dane$x2))/mean(dane$x2)
dane$w3 <- (min(dane$x3)-max(dane$x3))/mean(dane$x3)
dane$w4 <- (min(dane$x4)-max(dane$x4))/mean(dane$x4)

# funkcje

oblicz_wskaznik <- function(x){
  
  wskaznik <- (min(x)-max(x))/mean(x)
  
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

dane$z1 <- przeskaluj01(dane$x1)
dane$z2 <- przeskaluj01(dane$x2)
dane$z3 <- przeskaluj01(dane$x3)
dane$z4 <- przeskaluj01(dane$x4)

plot(dane$x1, dane$z1)

# warunki

czy_jest0 <- function(liczba){
  
  if(is.character(liczba)){
    stop("Argument jest tekstem")
  }
  stopifnot(!is.na(liczba))
  
  if(liczba > 0){
    print("Liczba większa od 0")
  } else if(liczba < 0){
    print("Liczba mniejsza od 0")
  } else {
    print("Liczba równa 0")
  }
  
}

czy_jest0(10)
czy_jest0("abc")
czy_jest0(NA)

# pętle

month.name

for(month in 1:length(month.name)){
  
  print(month.name[month])
  
}

for(month in seq_along(month.name)){
  
  print(month.name[month])
  
}

for(month in month.name){
  
  print(month)
  
}


wynik_kostka <- numeric(1000)

for(rzut in seq_along(wynik_kostka)){
  
  wynik_kostka[rzut] <- sample(x = 1:6, size = 1)
  
}

mean(wynik_kostka)
table(wynik_kostka)





