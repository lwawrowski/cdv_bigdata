# zbiór danych

dane <- data.frame(x1=runif(10),
                   x2=runif(10),
                   x3=rnorm(10),
                   x4=rnorm(10))

w1 <- mean(dane$x1)/median(dane$x1)
w2 <- mean(dane$x2)/median(dane$x2)
w3 <- mean(dane$x3)/median(dane$x3)
w4 <- mean(dane$x4)/median(dane$x4)

oblicz_wskaznik <- function(x){
  
  wskaznik <- sd(x)/median(x)
  
  return(wskaznik)
  
}

w1 <- oblicz_wskaznik(dane$x1)
w2 <- oblicz_wskaznik(dane$x2)
w3 <- oblicz_wskaznik(dane$x3)
w4 <- oblicz_wskaznik(dane$x4)

# 1 sposób
normalizuj_dane <- function(x){
  
  return((x-min(x))/(max(x)-min(x)))
  
}

dane$z4 <- normalizuj_dane(dane$x4)

plot(dane$x4, dane$z4)

# 2 sposób
normalizuj_dane <- function(x){
  
  (x-min(x))/(max(x)-min(x))
  
}

# 3 sposób
normalizuj_dane <- function(x) (x-min(x))/(max(x)-min(x))

# 4 sposób
normalizuj_dane <- \(x) (x-min(x))/(max(x)-min(x))

# warunki

wartosc <- "abc"

if(wartosc > 0) {
  print("Wartość > 0")
} else if(wartosc < 0) {
  print("Wartość < 0")
} else {
  print("Wartość = 0")
}

# pętle

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

toupper(month.name)
