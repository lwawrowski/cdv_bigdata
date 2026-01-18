6/2*(2+1)

# pierwszy komentarz

# wprowadzenie ------------------------------------------------------------

# moja sekcja ----

Sys.sleep(time = 60)

log(x = 27) # logarytm naturalny - nie o to chodziło
log(x = 27, base = 3)
log(x=27,base=3)
log(base = 3, x = 27)
log(27, 3)

# zadanie
log(x = 100, base = 10) + sqrt(121)
log10(x = 100) + sqrt(x = 121)

# wartości nieliczbowe

0/0 # NaN
18/0 # Inf
-18/0 # -Inf

# obiekty -----------------------------------------------------------------

liczba <- 18 # tworzenie obiektu
liczba = 18
liczba # wypisanie obiektu w konsoli

sqrt(liczba)
log(liczba)

pi

pi <- 5
pi

rm(pi) # usunięcie obiektu
pi

# wektory

letters
LETTERS

month.abb
month.name

kto_ma_psa <- c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE)
kto_ma_psa <- c(T, T, F, T, F, F, F)
kto_ma_psa

oceny <- c(5, 4, 4.5, 3, 5, 4)

wakacje <- c("Rodos", "Korfu", "Łódź", "Malta", "Cypr", "Gran Canaria")
wakacje <- c('Rodos', 'Korfu', 'Łódź', 'Malta', 'Cypr', 'Gran Canaria')
wakacje

mieszanka1 <- c(TRUE, 5, "Rodos")
mieszanka2 <- c(TRUE, 5)
mieszanka3 <- c("1", 5)

length(wakacje)

is.character(wakacje)
is.numeric(mieszanka3)

as.numeric(mieszanka3)
as.logical(mieszanka2)
mieszanka1_num <- as.numeric(mieszanka1)

# ciągi wartości
1:49
18:31
-9:9
9:-9

# indeksowanie wektora

wakacje[2]
wakacje[2:4]
wakacje[c(1,3,5)]
wakacje[-3]

mean(x = oceny)

oceny_nowe <- c(oceny, 5)
oceny_nowe <- c(oceny_nowe, 4, 5)

mean(oceny_nowe)

summary(kto_ma_psa)
summary(oceny_nowe)
summary(wakacje)

summary(as.factor(wakacje))

# macierz

macierz <- matrix(data = 1:16, nrow = 4, byrow = TRUE)
macierz

macierz[1,]
macierz[,2]
macierz[3,4] <- 90
macierz[1:2,2:3]

# ramka danych
df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

summary(df)

mean(df[,3])
mean(df[,"wydatki"])
mean(df$wydatki)

mean(df$wydatki[df$plec=="m"])
mean(df$wydatki[df$plec=="k"])

# lista

roznosci <- list(wektor = oceny, ramka_danych = df, wartosc = 18)

roznosci
roznosci$wektor
roznosci[["wektor"]]
