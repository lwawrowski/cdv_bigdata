# mój pierwszy komentarz

6/2*(2+1)

# różne funkcje ----

Sys.sleep(time = 3)

sqrt(x = 100)
sqrt(100)

log(x = 27, base = 3)
log(base = 3, x = 27)
log(27, 3)
log(3, 27) # źle

# obiekty ----

0/0 # NaN

3/0 # Inf

liczba <- 5
liczba

liczba_pi <- pi

pi <- 5
rm(pi)

letters
LETTERS

length(letters)

month.abb
month.name

# wektor ----

oceny <- c(5,4,5,3,4,5)

samochod <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
samochod <- c(True, False, True) # źle
samochod <- c(T, T, F, F, T)
samochod

ksiazki <- c("Pan Tadeusz", "Chłopi", "Nędznicy")

mieszanka <- c(5, "Pan Tadeusz", FALSE)
mieszanka2 <- c(5, F)
mieszanka3 <- c("4", 4)

is.character(mieszanka)
is.numeric(ksiazki)
is.numeric(samochod)

is.character(mieszanka3)

mieszanka3_num <- as.numeric(mieszanka3)

typeof(mieszanka)

rep(x = 6, times = 10)
rep(x = 6, length.out = 10)
rep(x = 6, each = 10)

rep(x = mieszanka, times = 10)
rep(x = mieszanka, length.out = 10)
rep(x = mieszanka, each = 10)

seq(from = 1, to = 49, by = 0.5)
seq(1,49)

1:49

mean(oceny)

summary(oceny)
summary(samochod)
summary(ksiazki)

summary(as.factor(ksiazki))

# dodawanie nowych elementów
oceny_nowe <- c(oceny, 6)
oceny_nowe2 <- c(oceny, c(6,4,3))

ksiazki[2]
ksiazki[2:3]

# macierz ----

macierz <- matrix(data = 1:9, nrow = 3, ncol = 3, byrow = T)
macierz[2,2]
macierz[1,]
macierz[,1]

# ramka danych ----

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

View(df)
df

summary(df)

mean(df[,3])
mean(df[,"wydatki"])
mean(df$wydatki)  

paste(mean(df$wydatki), "zł", sep = "")

# lista ----

list(wektor = mieszanka, zbior = df)
