setwd("C:/Users/kelvi/OneDrive/Documents/Data Mining/Assignment Phase 3")

#Preprocessing:

#Please run this section of the code for every classifier
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Read txt file into Data Frame as table
df <- read.table("datatraining.txt", header = TRUE, sep = ",")

#Remove the date column as it is only used for index purposes
df$date <- NULL

#Create a new value to convert "Occupancy" attribute from int to factor
colTypes <- sapply(df, class)
colTypes[6] <- "factor"
df <- read.table("datatest.txt", header = TRUE, sep = ",", colClasses = colTypes, stringsAsFactors = FALSE)

#View attribute type
str(df)
View(df)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#DECISION TREE
#Call the tree Library
library(tree)
output.forest <- randomForest(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, data = df)
output.tree <- tree::tree(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, data = df)
output.tree

#Summary of Decision Tree
summary(output.tree)

#Plotting the Decision Tree
plot(output.tree)
text(output.tree,pretty=0)

#Creating a prediction value
output.tree.predict <- predict(output.tree, df, type="class")
output.tree.predict

#Creating the confusion Matrix
output.tree.conf <- table(output.tree.predict, df$Occupancy)

#Finding out the accuracy of the decision tree
output.tree.accuracy <- sum(diag(output.tree.conf))/ sum(output.tree.conf)
output.tree.accuracy
#Accuracy is 0.9789868668

#NAIVE BAYES
#Applying Naive Bayes using the e1071 library
library(e1071)
classifier <- naiveBayes(Occupancy ~ Temperature + Humidity + Light + CO2 + HumidityRatio, df)
classifier
prediction <- predict(classifier, df)
prediction

#Using Data Splitting to estimate Naive Bayes model accuracy
library(caret)
library(klaR)
split=0.70
trainIndex <- createDataPartition(df$Occupancy, p=split, list = FALSE)
data_train <- df[trainIndex,]
data_test <- df[-trainIndex,]
data_test
model <- NaiveBayes(Occupancy~.,data=data_train)
x_test <- data_test[,1:6]
y_test <- data_test[,7]
predictions <- predict(model, x_test)
confusionMatrix(predictions$class, y_test)
#Accuracy: 0.9686717

#ARTIFICIAL NEURAL NETWORK
library(neuralnet)
#Obtain Max and Min of columns in dataframe
maxs <- apply(df, 2, max)
maxs
mins <- apply(df, 2, min)
mins

#Scale data to normalize
scale(df, center = mins, scale = maxs - mins)
dfANN <- as.data.frame(scale(df, center = mins, scale = maxs - mins))
dfANN

#Creating the formula for ANN
feats <- names(dfANN)
#String Concatenate
f <- paste(feats[1:5], collapse = ' + ')
f <- paste(feats[6], ' ~ ', f)
f
f <- as.formula(f)

#Creating the Artificial Neural Network
neuralnetwork <- neuralnet(f, dfANN, hidden=c(10,10,10), linear.output = FALSE)
neuralnetwork
plot(neuralnetwork)
