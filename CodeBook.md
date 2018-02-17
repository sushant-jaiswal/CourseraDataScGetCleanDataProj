# Code book for Getting and Cleaning Data Project
This file contains the details about the data, variables and process used to clean the data to get tidy set.

## Data Source
* The data was obtained from-
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* The data set used for this project-
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## R Script to clean data
The run_analysis.R scripts has following steps to get and clean the data-

### Download the data
Function "download.file" used to download the data set .zip file from given URL.

### Unzip the downloaded file
Function "unzip" used to unzip the downloaded file "UCI HAR Dataset.zip" to folder UCI HAR Dataset.

### Files in folder "UCI HAR Dataset"-

* subject_train.txt: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in X_train.txt.
* subject_test.txt: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in X_test.txt.
* X_train.txt: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* y_train.txt: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in X_train.txt.
* X_test.txt: 2947 observations of the 561 features, for 9 of the 30 volunteers.
* y_test.txt: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in X_test.txt.
* activity_labels.txt: Names and IDs for each of the 6 activities.
* features.txt: Names of the 561 features.

### Files not used
This analysis was performed using only the files above, and did not use the raw signal data. Therefore, the data files in the "Inertial Signals" folders were ignored.

### Load required packages
Packages "dplyr", "tidyr" and "data.table" loaded to use in built functions to clean the data.

### Read the above files and create data tables
Above files have been read from disk and stored in following data frames-

* dataSubjectTrain
* dataSubjectTest
* dataActivityTrain
* dataActivityTest
* dataTrain
* dataTest
* dataFeatures
* activityLabels

### Merges Training and Test sets to create one data set
* The Subject data stored in data frame "dataSubject" after merging Training and Test data
* The Activity data stored in data frame "dataActivity" after merging Training and Test data
* The actual data stored in data frame "data" after merging Training and Test data

### Set the names for variables to appropriate one
* Variable name changed from "V1" to "subject" in dataSubject data frame
* Variable name chagned from "V1" to "activityNumber" in dataActivity data frame
* "featureNumber" and "featureName" variable names given to variables in data frame dataFeatures
* "activityNumber" and "activityName" variable names given to variables in data frame activityLabels
* Name variables in data frame "data" according to feature

### Merge columns to get data frame for all data
The data frames dataSubject and dataActivity have been merged to "data" to get all data

### Extracts only the measurements on the mean and standard deviation for each measurement
Taking only measurements for the mean and standard deviation and add "subject", "activityNumber"

###Uses descriptive activity names to name the activities in the data set
The descriptive activity names have been taken from data frame activityLabels and update the in the main data set

### Appropriately labels the data set with descriptive variable names
As part of cleaning, following values in variable names have been been changed to descriptive/meaningful values
* std() - SD
* mean() - Mean
* ^t - time
* ^f - frequency
* Acc - Accelerometer
* Gyro - Gyroscope
* Mag - Magnitude
* BodyBody - Body

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
* A new data frame "dataAggregate" has been created with average for each activity and subject
* The data frame "dataAggregate" has been arranged by subject and activity and put back to data frame "data"
* The content of data frame "data" then has been exported to "TidyData.txt"