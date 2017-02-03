# assignment-3
Data Mining Assignment Phase 3

1)  Exploratory Data Analysis
Further details regarding the Exploratory Data Analysis can be found in the PDF file in this repository.

Data Source
UCI Machine Learning Repository: Occupancy Detection Data set
http://archive.ics.uci.edu/ml/datasets/Occupancy+Detection+
Data attribute:
- date time year-month-day hour:minute:second
- Temperature, in Celsius
- Humidity, %
- Light, in Lux
- CO2, in ppm
- Humidity Ratio, Derived quantity from temperature and humidity
- Occupancy, 0 or 1, 0 for not occupied, 1 for occupied status

2) Data Pre-processing
- 6 of the variables in the dataset are important in determining if whether a room is occupied.

- We assume the variable date time year-month-day hour:minute:second is only a index
of the data, and does not have any dependent relationship with the final result. We did
not select it as a factor to build the model

3) Choice of performance measures
- We have decided on using data splitting to measure the accuracy ofr the Naive Bayes model. The data was split 70/30 in which 70% of the data was used as training data and 30% was used as test data. A Naive Bayes model was then created and trained. Results were then summarized in a Confusion Matrix. 

4) Naive Bayes performance is as follows 

Confusion Matrix and Statistics

          Reference
    Prediction   0   1
             0 473   6
             1  34 285
                                         
               Accuracy : 0.9499         
                 95% CI : (0.9324, 0.964)
    No Information Rate : 0.6353         
    P-Value [Acc > NIR] : < 2.2e-16      
                                         
                  Kappa : 0.894          
    Mcnemar's Test P-Value : 1.963e-05      
                                         
            Sensitivity : 0.9329         
            Specificity : 0.9794         
         Pos Pred Value : 0.9875         
         Neg Pred Value : 0.8934         
             Prevalence : 0.6353         
         Detection Rate : 0.5927         
    Detection Prevalence : 0.6003         
      Balanced Accuracy : 0.9562         
                                         
       'Positive' Class : 0  
