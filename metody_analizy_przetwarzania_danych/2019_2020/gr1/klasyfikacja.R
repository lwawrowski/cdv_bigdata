library(tidyverse)
library(readxl)
library(janitor)

credit <- read_xlsx("data/german_credit_data.xlsx") %>%
  clean_names() %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(job=as.factor(job),
         installment=credit_amount/duration)

summary(credit)

library(rpart)
library(rpart.plot)

m1 <- rpart(formula = risk ~ ., data = credit)

rpart.plot(m1)

library(caret)

pred_risk_m1 <- predict(object = m1, newdata = credit, type = "class")

confusionMatrix(data = pred_risk_m1, reference = credit$risk, positive = "good", mode = "everything")

split <- createDataPartition(y = credit$risk, p = 0.8)

train_credit <- credit[split$Resample1,]
valid_credit <- credit[-split$Resample1,]

summary(train_credit)
summary(valid_credit)

m2 <- rpart(risk ~ ., data = train_credit)
rpart.plot(m2)

pred_risk_m2_train <- predict(object = m2, newdata = train_credit, type = "class")
pred_risk_m2_valid <- predict(object = m2, newdata = valid_credit, type = "class")

# dane train
confusionMatrix(data = pred_risk_m2_train, reference = train_credit$risk, 
                positive = "good", mode = "everything")

# dane valid
confusionMatrix(data = pred_risk_m2_valid, reference = valid_credit$risk, 
                positive = "good", mode = "everything")

# 18550
37*-(3500*0.5)+119*(3500*0.2)


library(h2o)

h2o.init()

# GUI
# h2o.flow()

train_credit_h2o <- as.h2o(train_credit)
valid_credit_h2o <- as.h2o(valid_credit)

y_var <- "risk"
x_var <- names(credit)[-10]

m3 <- h2o.gbm(x = x_var, 
              y = y_var, 
              training_frame = train_credit_h2o, 
              validation_frame = valid_credit_h2o, 
              seed = 1)

m3

pred_risk_m3_valid <- as.data.frame(h2o.predict(object = m3, newdata = valid_credit_h2o))

confusionMatrix(data = pred_risk_m3_valid$predict, reference = valid_credit$risk, 
                positive = "good", mode = "everything")

# 12950
47*-(3500*0.5)+136*(3500*0.2)

# optymalizacja hiperparametrów

gbm_params <- list(learn_rate = seq(0.01, 0.1, 0.01),
                   max_depth = seq(2, 10, 1),
                   sample_rate = seq(0.5, 1.0, 0.1),
                   col_sample_rate = seq(0.1, 1.0, 0.1),
                   ntrees = seq(50,150,10))

search_criteria <- list(strategy = "RandomDiscrete", max_models = 36, seed = 1)

gbm_grid <- h2o.grid(algorithm = "gbm", 
                     x = x_var, 
                     y = y_var,
                     grid_id = "gbm_grid1",
                     training_frame = train_credit_h2o,
                     validation_frame = valid_credit_h2o,
                     seed = 1,
                     hyper_params = gbm_params,
                     search_criteria = search_criteria)

gbm_gridperf <- h2o.getGrid(grid_id = "gbm_grid1",
                            sort_by = "auc",
                            decreasing = TRUE)

m4 <- h2o.getModel(gbm_gridperf@model_ids[[1]])

m4

pred_risk_m4_valid <- as.data.frame(h2o.predict(object = m4, newdata = valid_credit_h2o))

confusionMatrix(data = pred_risk_m4_valid$predict, reference = valid_credit$risk, 
                positive = "good", mode = "everything")

# 19950
43*-(3500*0.5)+136*(3500*0.2)

plot(h2o.performance(m4, valid = T), type = "roc")

h2o.varimp(m4)

h2o.partialPlot(m4, data = train_credit_h2o, cols = c("checking_account"))


