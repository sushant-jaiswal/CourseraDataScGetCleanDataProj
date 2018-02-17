
#Load packages
library(dplyr)
library(tidyr)
library(data.table)

#Set working directory
filesPath <- "C:/Data/MyLearn/DataScienceCoursera/Files/ProgrammingAssignment4"
setwd(filesPath)

#Download .zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./UCI HAR Dataset.zip",)

#Unzip the downloaded .zip file
unzip(zipfile="./UCI HAR Dataset.zip",exdir=".")

#Set the path for data
filesPath <- "C:/Data/MyLearn/DataScienceCoursera/Files/ProgrammingAssignment4/UCI HAR Dataset"

#Read files
dataSubjectTrain <- read.table(file.path(filesPath, "train", "subject_train.txt"), header = FALSE)
dataSubjectTest <- read.table(file.path(filesPath, "test" , "subject_test.txt"), header = FALSE)

dataActivityTrain <- read.table(file.path(filesPath, "train", "Y_train.txt"), header = FALSE)
dataActivityTest <- read.table(file.path(filesPath, "test" , "Y_test.txt" ), header = FALSE)

dataTrain <- read.table(file.path(filesPath, "train", "X_train.txt"), header = FALSE)
dataTest <- read.table(file.path(filesPath, "test" , "X_test.txt" ), header = FALSE)

dataFeatures <- read.table(file.path(filesPath, "features.txt"), head = FALSE)
activityLabels <- read.table(file.path(filesPath, "activity_labels.txt"), head = FALSE)

# 1. Merges the training and the test sets to create one data set.

#Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity <- rbind(dataActivityTrain, dataActivityTest)
data <- rbind(dataTrain, dataTest)

#Set names to variables
setnames(dataSubject, "V1", "subject")
setnames(dataActivity, "V1", "activityNumber")
setnames(dataFeatures, names(dataFeatures), c("featureNumber", "featureName"))
setnames(activityLabels, names(activityLabels), c("activityNumber","activityName"))

colnames(data) <- dataFeatures$featureName

#Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
data <- cbind(dataCombine, data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
featuresMeanSD <- grep("mean\\(\\)|std\\(\\)", dataFeatures$featureName, value = TRUE)

featuresMeanSD <- c(as.character(featuresMeanSD), "subject", "activityNumber" )
data <- subset(data, select = featuresMeanSD)

# 3. Uses descriptive activity names to name the activities in the data set
data <- merge(activityLabels, data, by = "activityNumber", all.x=TRUE)
data$activityName <- as.character(data$activityName)

dataAggregate <- aggregate(. ~ subject - activityName, data = data, mean) 
data <- tbl_df(arrange(dataAggregate, subject, activityName))


# 4. Appropriately labels the data set with descriptive variable names.
names(data) <- gsub("std()", "SD", names(data))
names(data) <- gsub("mean()", "Mean", names(data))
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
write.table(data, "TidyData.txt", row.name=FALSE)
