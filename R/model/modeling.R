library(data.table)

library(car)
data(cars)
cor(cars$speed, cars$dist)^2
m1= lm(dist ~ speed, data= cars)

summary(m1)

names(m1)

m1$coefficients
coef(m1)

m1$fitted.values
predict(m1)

m1$residuals
resid(m1)

plot(predict(m1), residuals(m1))
abline(h=0, col= 'red', lwd= 3)



library(MASS)
data(Boston)
m4= lm(medv ~ lstat, data= Boston)
summary(m4)
plot(predict(m4), residuals(m4))
abline(h=0, col= 'red', lwd= 3)

m5= lm(medv ~ lstat+I(lstat^2), data= Boston)
summary(m5)
plot(predict(m5), residuals(m5))
abline(h=0, col= 'red', lwd= 3)

m6= lm(medv ~ . , data= Boston)
summary(m6)
vif(m6)
cor(Boston$tax, Boston$rad)
round(cor(Boston), 2)
ifelse(abs(cor(Boston)) > 0.6, 1, 0)

Boston= data.table(Boston)
set.seed(1010)
Boston[, rand:= runif(.N)]
Boston[, istrain:= ifelse(rand<=0.8, T, F)]

mypreds= c('lstat', 'rm', 'ptratio', 'rad', 'nox', 'black', 'zn') # 'I(lstat^2)')
expr= c('medv~', paste(mypreds, collapse = '+'))
form= as.formula(expr)
mm= lm(form, data= Boston[istrain==T])
plot(predict(mm), residuals(mm))
Boston$preds= predict(mm, newdata= Boston)
Boston[, cor(medv, preds)^2, by= 'istrain']



library(ISLR)
library(caTools)
data(Default)
Default= data.table(Default)
str(Default)

m7= glm(default ~ balance, data= Default, family= 'binomial')
summary(m7)
names(m7)

m8= glm(default ~ ., data= Default, family= 'binomial')
summary(m8)
coef(m8)
confint(m8)

set.seed(1100)
Default= data.table(Default)
Default[, rand:= runif(.N)]
Default[, istrain:= ifelse(rand <= 0.7, T, F)]

mm= glm(default ~ student+balance, data= Default[istrain==T], family= 'binomial')
summary(mm)

Default$scores= predict(mm, Default, type= 'response')
Default[, class.pred:= ifelse(scores > 0.5, 'Yes', 'No')]
  
Default[, colAUC(scores, default, plotROC = F, alg = "ROC"), by= istrain]
table(Default$class.pred, Default$default)


library(randomForest)

data(Caravan)
Caravan= data.table(Caravan)
str(Caravan)
dim(Caravan)
names(Caravan)

set.seed(1100)
Caravan[, rand:= runif(.N)]
Caravan[, istrain:= ifelse(rand <= 0.7, T, F)]
table(Caravan$istrain)

rf= randomForest(Purchase ~ .-istrain -rand, data= Caravan[istrain==T], 
                 ntree= 400, mtry= 8, nodesize= 20)
rf$importance

Caravan$scores= predict(rf, Caravan, type= 'prob')[,2]
Caravan[, mean(scores), by= 'Purchase']
Caravan[, colAUC(scores, Purchase, plotROC = F, alg = "ROC"), by= istrain]
Caravan[, scores:= NULL]


library(gbm)

gbm()

library(caret)
require(pROC)

ctrl= trainControl(method= 'repeatedcv', number= 5, repeats= 1, 
                   classProbs= T, summaryFunction= twoClassSummary)

gbm.grid= expand.grid(n.trees= c(200, 250, 300), 
                      interaction.depth= c(3,4), 
                      shrinkage= c(0.01,0.05),
                      n.minobsinnode= 20)

gbm.model= train(Purchase ~ . -rand -istrain, data= Caravan[istrain==T], 
                 method= 'gbm', trControl= ctrl,
                 tuneGrid= gbm.grid, distribution= 'bernoulli',
                 metric= 'ROC', preProc= c('center', 'scale'))

Caravan$scores= predict(gbm.model, Caravan, type= 'prob')$Yes
Caravan[, colAUC(scores, Purchase, F, 'ROC'), by= 'istrain']
Caravan[, scores:= NULL]
