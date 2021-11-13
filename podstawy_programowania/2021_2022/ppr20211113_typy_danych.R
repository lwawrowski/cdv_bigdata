6/2*(2+1) # komentarz

# nowy komentarz


# funkcje -----------------------------------------------------------------

sqrt(x = 100)
sqrt(100)

Sys.sleep(300)

5 * log(x = 27, base = 3)

5*log(x=27,base=3)
5*log(base=3, x=27)
5*log(27,3)
5*log(3,27) # źle

log10(100) + sqrt(121)

1/0


# stałe wbudowane ---------------------------------------------------------

pi
letters
month.name

pi <- 5
pi

rm(pi) # usuwanie obiektu pi

pi

# obiekty -----------------------------------------------------------------

oceny <- c(5,5,5,4,3,2,5,3)
oceny

covid <- c("chory", "zdrowy", "szczepiony")
covid

logika <- c(TRUE, FALSE, TRUE)

wektor_mieszany <- c("abc", "xyz", 5, TRUE)
wektor_mieszany2 <- c(2, 35, TRUE)

mean(x = oceny)
length(x = oceny)

rep(5, 100)
seq(from = 1, to = 10, by = 1)

# lotto

pula <- seq(1, 49)

set.seed(123)
sample(x = pula, size = 6)

summary(oceny)



