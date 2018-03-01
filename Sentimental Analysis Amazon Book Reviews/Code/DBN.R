#install.packages("deepnet")
library(deepnet)

show.digit <- function(arr784, col=gray(12:1/12), ...) {
  image(matrix(arr784, nrow=28)[,28:1], col=col, ...)
}
setwd("C:/Users/Nimi/Downloads/r studio/final")
corpus <- read.csv("corpus.csv")
corpus <- corpus[-1]

index <- sample(1:nrow(corpus),round(0.75*nrow(corpus)))
train <- corpus[index,]
test <- corpus[-index,]
dim(train)

train.x <- data.matrix(train[-8591])
train.y <- data.matrix(train[-(1:8590)])
#nn <- nn.train(mnist$train$x, mnist$train$yy, hidden = c(30, 20), numepochs = 25)
#err.nn <- nn.test(nn, mnist$test$x, mnist$test$yy)
#yy.nn <- nn.predict(nn, mnist$test$x)

dnn <- dbn.dnn.train(train.x, train.y, hidden = c(300,300), numepochs = 10, cd=2)
err.dnn <- nn.test(dnn, train.x, train.y)
yy.dnn <- nn.predict(dnn, test[-8591])
#show.digit(mnist$test$x[99,])

#predict

predictions <- unlist(yy.dnn)
dbn.out<-as.data.frame(predictions)
nrow(dbn.out)

xtab <- table(unlist(test[8591]),unlist(round(yy.dnn)))
xtab




library(caret)
a <- confusionMatrix(unlist(round(yy.dnn)), unlist(test[8591]))
a
