6/2*(2+1)

# pierwszy komentarz

# 2*100


# pierwsza sekcja ---------------------------------------------------------



# druga sekcja ------------------------------------------------------------



# trzecia sekcja ----


# funkcje

Sys.sleep(time = 3)

log(100)

log(x = 27, base = 3)
log(x=27,base=3)
log(base = 3, x = 27)
log(27, 3)

# log(3,27)

# zadanie
log(x = 100, base = 10) + sqrt(x = 121)
log10(x = 100) + sqrt(x = 121)
log10(100) + sqrt(121)

# wartości nieliczbowe

0/0
9/0
-9/0

# obiekty

liczba <- 29 # tworzenie obiektu
liczba = 29
liczba # wyświetlanie obiektu w konsoli

sqrt(liczba)
log(liczba)

pi <- 5
rm(pi)

pi*32^2

# wektory

letters
LETTERS

month.name
month.abb

ma_kota <- c(TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE)
ma_kota <- c(T, F, T, T, F, F, F)
# ma_kota <- c(True, False)
ma_kota

oceny <- c(4, 5, 2, 3.5, 5, 4)

wakacje <- c("Korfu", "Gran Canaria", "Łódź", "Oslo", "Malta")
wakacje <- c('Korfu', 'Gran Canaria', 'Łódź', 'Oslo', 'Malta')
wakacje

mieszanka1 <- c(TRUE, 4, "Korfu")
mieszanka2 <- c(TRUE, 4)
mieszanka3 <- c("1", 4)

length(ma_kota)

is.character(wakacje)
is.numeric(oceny)
is.character(oceny)

mieszanka3_num <- as.numeric(mieszanka3)
ma_kota_num <- as.numeric(ma_kota)
mieszanka1_num <- as.numeric(mieszanka1)

# rep i seq

rep(x = 29, times = 11)
rep(x = 29, length.out = 11)
rep(x = 29, each = 11)

rep(x = mieszanka1, times = 11)
rep(x = mieszanka1, length.out = 11)
rep(x = mieszanka1, each = 11)
rep(mieszanka1, 11) # times

seq(from = 1, to = 49, by = 1)
seq(from = 1, to = 49, by = 0.5)
seq(from = 1, to = 49, length.out = 49)
seq(1, 49) # by = 1

1:49
5:10
-9:9
9:-9

# indeksowanie wektorów

wakacje
wakacje[1]
wakacje[1:3]

oceny
oceny[c(1:2,4:6)]
oceny[-3]

mean(x = oceny)

oceny_nowe <- c(oceny, 6)
oceny_nowe <- c(oceny_nowe, c(4,5))

mean(oceny_nowe)

summary(ma_kota)
summary(oceny_nowe)
summary(wakacje)

summary(as.factor(wakacje))

# macierz

macierz <- matrix(data = 1:16, nrow = 4, ncol = 4, byrow = T)
macierz

macierz[1,]
macierz[,2]
macierz[4,3]

# ramka danych

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

summary(df)

mean(df[,3])
mean(df[,"wydatki"])
mean(df$wydatki)

# lista

roznosci <- list(wektor = wakacje, zbior = df, wartosc = 16.43)

roznosci$wartosc
