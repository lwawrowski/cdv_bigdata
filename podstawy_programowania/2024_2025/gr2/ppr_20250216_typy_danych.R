# mój pierwszy komentarz

# typy danych ----

# typy danych -------------------------------------------------------------

6/2*(2+1)

Sys.sleep(time = 90)

sqrt(x = 100)
sqrt(100)

log(x = 27)
log(x = 27, base = 3)
log(base = 3, x = 27)
log(27, 3)
log(3, 27) # źle 

# wartości nieliczbowe ----------------------------------------------------

0/0 # NaN
3/0 # Inf


# obiekty -----------------------------------------------------------------

liczba <- 5
liczba = 5
liczba

pi

pi <- 5
rm(pi)
pi

letters
LETTERS

month.name
month.abb

# wektory -----------------------------------------------------------------

samochod <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
samochod <- c(True, False) # źle
samochod <- c(T, F, T, T, F)
samochod

oceny <- c(5,4,3,5,5)

ksiazki <- c("Kwestia wyboru", "Wierna rzeka", 'Data science')
ksiazki

mieszanka1 <- c(T, 5, "Data science")
mieszanka2 <- c(T, 5)
mieszanka3 <- c("1", 5)

is.character(x = mieszanka1)
is.numeric(mieszanka2)
is.logical(samochod)

mieszanka3_num <- as.numeric(mieszanka3)
mieszanka1_log <- as.logical(mieszanka1)

oceny[3]
ksiazki[2]

rep(x = 5, times = 10)
rep(x = 5, length.out = 10)
rep(x = 5, each = 10)

rep(x = mieszanka1, times = 10)
rep(x = mieszanka1, length.out = 10)
rep(x = mieszanka1, each = 10)

rep(mieszanka1, 10) # times

seq(from = 1, to = 49, by = 1)
seq(from = 1, to = 49, length.out = 97)

seq(1,49)

1:49
5:10
10:5
9:-9

mean(x = oceny)

summary(oceny)
summary(samochod)
summary(ksiazki)

oceny_nowe <- c(oceny, 4.5)
oceny_nowe2 <- c(oceny_nowe, c(2,3,4))
oceny_nowe2 <- c(oceny_nowe2, 6)

oceny_nowe2[4:6]
oceny_nowe2[c(1,4:6)]
