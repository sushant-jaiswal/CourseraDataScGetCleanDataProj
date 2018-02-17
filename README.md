# Getting and Cleaning Data Project

### This file describes how run_analysis.R works-
* The data set "UCI HAR Dataset" gets downloaded from provided site link
* The downloaded zipped file gets unzipped
* Packages "dplyr", "tidyr" and "data.table" loaded to use in built functions to clean the data
* Following files have been worked upon for data cleaning and stored in data frames

1. subject_train.txt - dataSubjectTrain
2. subject_test.txt - dataSubjectTest
3. X_train.txt - dataTrain 
4. y_train.txt - dataActivityTrain
5. X_test.txt - dataTest
6. y_test.txt - dataActivityTest
7. activity_labels.txt - activityLabels
8. features.txt - dataFeatures

* Training and Test sets have been merged to create one data set
* Appropriate names have been given to variables
* Subject and Activity data have been merged to create data frame with all data
* Only measurements for the mean and standard deviation have been taken and added "subject", "activityNumber"
* Descriptive activity names have been added to name the activities in the data set
* Following values have been replaced with appropriate values to have descriptive variable names
1. std() - SD
2. mean() - Mean
3. ^t - time
4. ^f - frequency
5. Acc - Accelerometer
6. Gyro - Gyroscope
7. Mag - Magnitude
8. BodyBody - Body

* An independent data set has been created with average for each activity and subject
* This data set then is arranged by subject and activity before exported to file "TidyData.txt"