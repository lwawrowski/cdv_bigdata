temperatura <- c(10, 12, 9.5, 15, 12, NA, 4) # R
# temperatura <- [10, 12, 9.5, 15, 12, 9, 4] # python

mean(x = temperatura, na.rm = TRUE)

temperatura[1]

summary(temperatura)

# ramka danych

df <- data.frame(plec=c("m", "k", "k", "m", "k", "m", "m", "m"),
                 wzrost=c(173, 170, 163, 178, 169, 180, 175, NA),
                 wydatki=c(1200, 2340, 1900, 890, 1010, 3099, 1478, 2030),
                 pali=c(T, F, F, F, T, F, NA, T))

summary(df)

df[1,2]
df[1,]
df[,2]

srednie_wydatki <- mean(x = df$wydatki)

sredni_wzrost <- mean(x = df[,2], na.rm = TRUE)
sredni_wzrost <- mean(x = df[,"wzrost"], na.rm = TRUE)
sredni_wzrost <- mean(x = df$wzrost, na.rm = TRUE)

# lista

lista_obiektow <- list(df, temperatura, srednie_wydatki)

lista_obiektow[[1]]
lista_obiektow[[2]]
