liczba <- 0

if(liczba > 0){
  print("Wartość dodatnia")
} else if(liczba < 0){
  print("Wartość ujemna")
} else {
  print("Zero")
}

liczba <- 15

if(liczba %% 5 == 0 && liczba %% 3 == 0){
  print("podzielna przez 3 i 5")
} else if(liczba %% 5 == 0){
  print("podzielna przez 5")
} else if(liczba %% 3 == 0){
  print("podzielna przez 3")
} else {
  print("niepodzielna przez 3 i 5")
}


