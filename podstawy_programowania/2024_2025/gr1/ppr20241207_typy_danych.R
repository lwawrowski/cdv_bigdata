# treść komentarza

6/2*(2+1)

# sekcja 1 ----

# sekcja 2 ----

# funkcje ----------------------------------------------------------------

Sys.sleep(time = 3)

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

typeof(mieszanka3)
typeof(oceny)

rep(x = 8, times = 10)
rep(x = 8, length.out = 10)
rep(x = 8, each = 10)

rep(x = mieszanka1, times = 10)
rep(x = mieszanka1, length.out = 10)
rep(x = mieszanka1, each = 10)
rep(mieszanka1, 10) # times = 10

seq(from = 1, to = 49, by = 1)
seq(from = 1, to = 49, length.out = 97)
seq(1,49)

1:49
3:9
9:3
9:-9

mean(x = oceny)

summary(oceny)
summary(samochod)
summary(ksiazki)

summary(as.factor(ksiazki))

ksiazka1 <- ksiazki[2]
ksiazka2 <- ksiazki[2:3]

oceny_nowe <- c(oceny, 3)
oceny_nowe2 <- c(oceny, c(2,3,4))

# macierze ----------------------------------------------------------------

macierz <- matrix(data = 1:9, nrow = 3, ncol = 3, byrow = TRUE)
macierz

macierz[2,2]
macierz[,1]
macierz[1,]

# ramka danych ------------------------------------------------------------

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

View(df)

summary(df)

mean(df[,3])
mean(df[,"wydatki"])
mean(df$wydatki)

# lista -------------------------------------------------------------------

roznosci <- list(wektor = ksiazki, zbior = df, liczba = 2024)

roznosci$wektor
roznosci$zbior$plec
roznosci[[1]]
roznosci[["wektor"]]
