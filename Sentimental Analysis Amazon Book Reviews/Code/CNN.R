install.packages("drat", repos="https://cran.rstudio.com")
drat:::addRepo("dmlc")

install.packages("deepnet")
install.packages("darch")
install.packages("read_csv")
install.packages("newDarch")
install.packages("matrixStats")
library(caret)
library(matrixStats)
library(mxnet)
library(darch)
library(deepnet)
library(read_csv)
#load input
setwd("C:/Users/Nimi/Downloads/r studio/final")
#setwd("C:/MY FILES/Data/MNIST/")
corpus <- read.csv("corpus.csv")
corpus <- corpus[-1]
#names(corpus[8593]) <- "Stars"

index <- sample(1:nrow(corpus),round(0.75*nrow(corpus)))
train <- corpus[index,]
test <- corpus[-index,]
dim(train)
#aa <- train[stars]
model_cnn <- darch(train.x,train.y,darch.fineTuneFunction = "minimizeClassifier",darch.batchSize = 50,darch.numEpochs = 10,dataSetValid = NULL)
#model_cnn <- darch(train[-(1:8591)] ~.,train[-8592]) 
nrow(test)
nrow(train)

#standardize

train.x <- data.matrix(train[-8591])
train.y <- data.matrix(train[-(1:8590)])


#predict
preds <- predict(model_cnn, test[-8591])
predictions <- unlist(preds)
cnn.out<-as.data.frame(preds)
nrow(cnn.out)

xtab <- table(unlist(test[8591]),unlist(round(preds)))
xtab




library(caret)
a <- confusionMatrix(unlist(round(preds)), unlist(test[8591]))
a
