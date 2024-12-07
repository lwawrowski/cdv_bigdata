# treść komentarza

6/2*(2+1)

# sekcja 1 ----

# sekcja 2 ----

# funkcje ----------------------------------------------------------------

Sys.sleep(time = 300)

sqrt(x = 100)
sqrt(100)

log(100)
log(x = 27, base = 3)
log(base = 3, x = 27)
log(27, 3)
log(3, 27) # źle 

# wartości nieliczbowe

0/0
3/0

# obiekty ----

liczba <- 5
liczba = 5
liczba

liczba_pi <- pi

pi <- 5
pi
rm(pi)
pi

# wektory -----------------------------------------------------------------

letters
LETTERS

month.name
month.abb

length(letters)

samochod <- c(TRUE, TRUE, FALSE, TRUE, FALSE)
samochod <- c(True, True, False, True, False) # źle
samochod <- c(T, T, F, T, F)
samochod

oceny <- c(5,4,3,5,6)

ksiazki <- c("Pan Tadeusz", "Chłopi", "Krzyżacy")

mieszanka1 <- c(TRUE, 5, "Pan Tadeusz")
mieszanka2 <- c(T, 5)
mieszanka3 <- c("1", 5)

is.character(mieszanka1)
is.numeric(ksiazki)
is.logical(samochod)

mieszanka3_num <- as.numeric(mieszanka3)
mieszanka1_log <- as.logical(mieszanka1)


