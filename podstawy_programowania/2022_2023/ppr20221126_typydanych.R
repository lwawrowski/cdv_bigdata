# mój pierwszy komentarz


# funkcje -----------------------------------------------------------------

6/2*(2+1)

Sys.sleep(time = 300)

sqrt(x = 100)
sqrt(100)

5*log(x = 27, base = 3)
5*log(27, 3)
5*log(base = 3, x = 27)
5*log(3,27) # źle


# stałe wbudowane ---------------------------------------------------------

liczba_pi <- 3.14

pi <- 5

2*10*pi

rm(pi)

2*10*pi

letters
LETTERS

month.abb
month.name

# wektor ----

oceny <- c(5,4,5,4,3,6,6,6)
oceny

telefon <- c("nokia", "samsung", "iphone", "samsung")
telefon <- c('nokia', 'samsung', 'iphone', 'samsung')
telefon

wakacje <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
wakacje <- c(True, False, True, False) # nie działa
wakacje <- c(T, F, T, T, F)
wakacje

wszystko1 <- c(5, "nokia", TRUE)
wszystko2 <- c(5, TRUE)

length(oceny)
typeof(telefon)
is.numeric(wakacje)

rep(x = 6, times = 10)
rep(x = 6, length.out = 10)

seq(1, 49, by = 1)
seq(1, 49, length.out = 49)

telefon[1] # pierwszy element
telefon[0]

mean(oceny)

summary(oceny)
summary(telefon)
summary(wakacje)

summary(factor(telefon))

# ramka danych ----

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

summary(df)

mean(df$wydatki)
mean(df[,3])
mean(df[,"wydatki"])

# lista -------------------------------------------------------------------

list(wektor = telefon, ramka = df)

# bardzo długa i ważna sekcja ---------------------------------------------

