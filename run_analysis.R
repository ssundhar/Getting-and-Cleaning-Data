#prepare the required packages
#data.table package
if (!require("data.table")) {
        install.packages("data.table")
}
#dplyr package
if (!require("dplyr")) {
        install.packages("dplyr")
}

#initialize the packages (after installation/checking its existence)
library(data.table)
library(dplyr)

## reading meta information 
## defining variables to match file_names
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)


##1. Merges the training and the test sets to create one data set.
## In order to merge test and training dataset, we would have to format the data

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## Also, notice that y_test is using small letter y and X_test is utilizing caps X.
## This is data as is from the UCI HAR Dataset.
## y -> Activity, X -> Features
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

## Also, notice that y_train is using small letter y and X_train is utilizing caps X.
## This is data as is from the UCI HAR Dataset.
## y -> Activity, X -> Features
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

## Here is where we merge the test and training records/data.
## y -> Activity, X -> Features
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)
X <- rbind(X_train, X_test)

colnames(subject) <- "Subject"
colnames(y) <- "Activity"
colnames(X) <- t(features[2])

#This is where we merge test and training datasets.
training_and_test <- cbind(X,y,subject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_and_std <- grep(".*Mean.*|.*Std.*", names(training_and_test), ignore.case=TRUE)

reqCol <- c(mean_and_std, 562, 563)
## dim(reqCol) would be:  [1] 10299   563

measurements <- training_and_test[,reqCol]
## dim(measurements) would be: [1] 10299    88

## 3. Uses descriptive activity names to name the activities in the data set
measurements$Activity <- as.character(measurements$Activity)
for (iterator in 1:6){
        measurements$Activity[measurements$Activity == iterator] <- as.character(activity_labels[iterator,2])
}
measurements$Activity <- as.factor(measurements$Activity)


## 4. Appropriately labels the data set with descriptive variable names. 
## There are other names that has small vs. capital letters, but it did not make much of a difference.
## In here, I have only chosen the ones that only made a huge difference.
## Gyro
names(measurements)<-gsub("Gyro", "Gyroscope", names(measurements), ignore.case = TRUE)
## BodyBody
names(measurements)<-gsub("BodyBody", "Body", names(measurements), ignore.case = TRUE)  
## freq
names(measurements)<-gsub("-freq()", "Frequency", names(measurements), ignore.case = TRUE)
## tBody
names(measurements)<-gsub("tBody", "TimeBody", names(measurements), ignore.case = TRUE)
## Acc
names(measurements)<-gsub("Acc", "Accelerometer", names(measurements), ignore.case = TRUE)
## Mag
names(measurements)<-gsub("Mag", "Magnitude", names(measurements), ignore.case = TRUE)
## std
names(measurements)<-gsub("-std()", "STD", names(measurements), ignore.case = TRUE)
## ^t
names(measurements) <- gsub("^t", "time", names(measurements), ignore.case = TRUE)
## ^f
names(measurements) <- gsub("^f", "frequency", names(measurements), ignore.case = TRUE)
## mean
names(measurements)<-gsub("-mean()", "Mean", names(measurements), ignore.case = TRUE)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

measurements$Subject <- as.factor(measurements$Subject)
measurements <- data.table(measurements)
##TidyData <- average of each variable for each activity and each subject
TidyData <- aggregate(. ~Subject + Activity, measurements, mean)
TidyData <- TidyData[order(TidyData$Subject,TidyData$Activity),]
## Writing TidyData to a text file
write.table(TidyData, file = "TidyData.txt", row.names = FALSE)
