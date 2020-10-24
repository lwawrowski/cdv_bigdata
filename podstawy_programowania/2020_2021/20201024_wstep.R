# proste obliczenia

6/2*(2+1)

sqrt(x = 100)
sqrt(100)

Sys.sleep(time = 300)

# białe znaki nie mają znaczenia
5*log(x = 27, base = 3)
5*log(x=27,base=3)

# nowy obiekt
liczba <- sqrt(100)
liczba

pi

letters
month.name

# pi <- 5
# pi
# 
# rm(pi)

oceny <- c(4, 4.5, 5, 4, 3.5, 4)

length(x = oceny)
mean(x = oceny)

wykszt <- c("wyższe", "średnie", "ŚREDNIE", 7)

tak_nie <- c(TRUE, FALSE, TRUE)
tak_nie <- c(T, F, T, 2, "prawda")

rep("zdał", 100)

runif(100)

lotto <- seq(1,49)

set.seed(160)
sample(x = lotto, size = 6)

summary(oceny)
summary(wykszt)


# ramka danych

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

summary(df)

srednie_wydatki <- mean(df$wydatki)
sredni_wzrost <- mean(df[,"wzrost"])
sredni_wzrost <- mean(df$wzrost, na.rm = TRUE)

lista_obiektow <- list(df, liczba, oceny)





