for(i in 1:10){
  liczba <- i^2
  print(liczba)
}

potega <- 0
m <- 0

while(potega < 50){
  m <- m + 1
  potega <- m^2
  print(potega)
}


potega_liczby <- function(liczba, potega=2){
  wynik <- liczba^potega
  return(wynik)
}

potega_liczby(5,2)
potega_liczby(10,5)

# funkcja wykres osypiska

wykres_osypiska <- function(zbior_wejsciowy, grupy=15){
  
  if(!is.numeric(zbior_wejsciowy)){
    stop("Zbiór wejściowy nie jest numeryczny")
  } else {
    if(!is.numeric(grupy)){
      stop("Liczba grup musi być liczbą całkowitą")
    } else {
      zmiennosc_grup <- numeric(grupy)
      indeksCH <- numeric(grupy)
      
      for(liczba_grup in 1:length(zmiennosc_grup)){
        grupowanie <- kmeans(zbior_wejsciowy, centers = liczba_grup)
        zmiennosc_grup[liczba_grup] <- grupowanie$tot.withinss
        indeksCH[liczba_grup] <- intCriteria(zbior_wejsciowy,
                                             grupowanie$cluster, "cal")[[1]]
      }
      
      plot(x = 1:grupy, y = zmiennosc_grup, 
           type = "b", xlab = "Liczba grup")
    }
  }
}























