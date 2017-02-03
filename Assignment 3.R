setwd("C:/Users/kelvi/OneDrive/Documents/Data Mining/Assignment Phase 3")
#Decision Trees
#Preprocessing:
#Read txt file into Data Frame as table
df <- read.table("datatest.txt", header = TRUE, sep = ",")
df2 <- read.table("datatest2.txt", header = TRUE, sep = ",")

#Remove the date column as it is only used for index purposes
df$date <- NULL
df2$date <- NULL
#Create a new value to convert "Occupancy" attribute from int to factor
colTypes <- sapply(df, class)
colTypes[6] <- "factor"
df <- read.table("datatest.txt", header = TRUE, sep = ",", colClasses = colTypes, stringsAsFactors = FALSE)
df2 <- read.table("datatest2.txt", header = TRUE, sep = ",", colClasses = colTypes, stringsAsFactors = FALSE)

#View attribute type
str(df)
str(df2)
View(df)
#Call the RandomForest Library
library(randomForest)
#Apply RandomForest to obtain decision trees on datatest.txt
output.forest <- randomForest(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, data = df)
print(output.forest)
print(importance(output.forest, type = 2))
#Apply RandomForest to obtain decision trees on datatest2.txt
output.forest2 <- randomForest(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, data = df2)
print(output.forest2)
print(importance(output.forest, type = 2))

#Naive Bayes
#Preprocessing
TrainData <- read.table("datatraining.txt", header = TRUE, sep = ",")
TrainData$date <- NULL
colTypes <- sapply(df, class)
print(colTypes)
colTypes[6] <- "factor"
TrainData <- read.table("datatraining.txt", header = TRUE, sep = ",", colClasses = colTypes, stringsAsFactors = FALSE)
train <- data.frame(TrainData)
str(train)
train$date <- NULL

#Applying Naive Bayes
library(e1071)
classifier <- naiveBayes(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, train)
classifier
prediction <- predict(classifier, train)
prediction

#Using Data Splitting to estimate Naive Bayes model accuracy
library(caret)
library(klaR)
split=0.70
trainIndex <- createDataPartition(df$Occupancy, p=split, list = FALSE)
data_train <- df[trainIndex,]
data_test <- df[-trainIndex,]
model <- NaiveBayes(Occupancy~.,data=data_train)
x_test <- data_test[,1:5]
y_test <- data_test[,6]
predictions <- predict(model, x_test)
confusionMatrix(predictions$class, y_test)
