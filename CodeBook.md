# CodeBook.md
A Code Book that describes:
* the variables, 
* the data, 
* and any transformations or work that you performed to clean up the data

# Variables

features <- takes in the features.txt
activity_lables <- tales in the file content of activity_labels.txt

The following are variables used for test data
subject_test <- contents of subject_test.txt
y_test <- contents of Activity - test
X_test <- contents of Features - test

The following are variables used for training data
subject_train <- contents of subject_test.txt
y_train <- contents of Activity - training
X_train <- contents of Features - training

subject <- binded/combined subjects of training and test data
y <- binded/combined activities of training and test data
X <- binded/combined features of training and test data

training_and_test <- combined test and training data

measurements <- extracted measurements on mean and standard deviation for each measurements

mean_and_std and reqCol <- required column extraction to attain the final measurements

TidyData <- Tidy data extracted from the average of each activity and subject.

# Data

When it comes to data, it is highly important in understanding the components of the raw data, cleansing the raw data and then processing the requirements. If we do not parse or process the raw data in order to clean them appropriately, merging would lead to issues and hence the end result of attaining TidyData becomes almost impossible.

# Transformations

Transformations happen in many places including the colnames and names being cleaned up in order to perform a good merger and also ensure that we attain the end results.
