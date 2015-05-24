# Getting and Cleaning Data - Course Project

-----

## CodeBook

This file describes the variables, the data, and any transformations or work that were performed to clean up the data

Data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Full descriptions of the data:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

-----

The **run_analysis.R** script performed the following steps to clean up the data:

 1. Merges the training and the test sets to create one data set.
    + Use rbind to merge the following sets:
    + **mergedSubject** _(10299 x 1)_ = **subject_train.txt** + **subject_test.txt**
    + **mergedLabel** _(10299 x 1)_ = **y_train.txt** + **y_test.txt**
    + **mergedSet** _(10299 x 561)_ = **X_train.txt** + **X_test.txt**
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    + Read **features.txt**
    + Extract the indices of measurements containing "mean()" and "std()"
    + There resulting 66 indices are used to subset **mergedSet** _(10299 x 66)_
 3. Uses descriptive activity names to name the activities in the data set
    + Read **activity_labels.txt**
    + Convert the activity names to lowercase
    + Transform the values of **mergedLabel** according to the activity names
 4. Appropriately labels the data set with descriptive variable names.
    + Label **mergedSubject** as "subject" variable
    + Label **mergedLabel** as "activity" variable
    + Label **mergedSet** as the different measurements containing "mean()" and "std()"
    + Use cbind to combine the following variables:
    + **step4Data** _(10299 x 68)_ = **mergedSubject** + **mergedLabel** + **mergedSet**
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + There are 30 unique subjects and 6 unique activities.
    + Perform a nested for-loop to compute the mean of each measurement for each combination of subjects and activities
    + The resulting data set **df** will have a dimension of _180 x 68_
    + Write **df** into a txt file called **tidyDataSet.xtx**
    
-----
    
    
    