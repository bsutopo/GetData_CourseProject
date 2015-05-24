################################################
## Getting and Cleaning Data - Course Project ##
################################################

## 0. Obtaining raw data

# Download the zip file containing raw data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
fileName <- "Dataset.zip"
download.file(url, fileName, method = "curl")
# Unzip the file containing raw data into the folder "UCI HAR Dataset"
unzip("Dataset.zip")



## 1. Merge the training and the test sets to create one data set.

# Load training and test subjects
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")    
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# Merge training and test subjects
mergedSubject <- rbind(trainSubject, testSubject)

# Load training and test sets
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")       
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt") 
# Merge training and test sets
mergedSet <- rbind(trainSet, testSet)

# Load training and test labels
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")     
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
# Merge training and test labels
mergedLabel <- rbind(trainLabel, testLabel)



## 2. Extract only the measurements on the mean and standard deviation for each measurement.  

# Load features list
features <- read.table("./UCI HAR Dataset/features.txt")
# Find the indices of measurements containing the string "mean()" and "std()"
meanSTD <- grep("mean\\(\\)|std\\(\\)", features[, 2])
# Subset the columns of mergedSet to only contain measurements on the mean and std
mergedSet <- mergedSet[, meanSTD]



## 3. Use descriptive activity names to name the activities in the data set

# Load activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Convert the activity names to lower-case
activity[, 2] <- tolower(activity[, 2])
# Link the activity names to the mergedLabel data set
activityNames <- activity[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activityNames



## 4. Appropriately labels the data set with descriptive variable names. 

# Label the subject variable
names(mergedSubject) <- "subject"
# Label the activity variable
names(mergedLabel) <- "activity"
# Label the measurement variables
names(mergedSet) <- features[meanSTD, 2]
# Merge all variables into a single data set
step4Data <- cbind(mergedSubject, mergedLabel, mergedSet)



## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

# The number of rows will be equal to all permutations of subjects and activities
nSubject <- length(table(mergedSubject))
nActivity <- length(table(mergedLabel))
nRows <- nSubject * nActivity
# The number of columns will be equal to the number of variables in the first data set
nColumns <- ncol(step4Data)

# Create an empty data frame as a base for the independent tidy data set
df <- matrix(NA, nrow = nRows, ncol = nColumns) 
df <- as.data.frame(df)
# Label the new data set with the same descriptive variable names
colnames(df) <- colnames(step4Data)

# Update all the values in the new data set using for loops
row <- 1
for(i in 1:nSubject) {
        for(j in 1:nActivity) {
                df[row, 1] <- sort(unique(mergedSubject)[, 1])[i]
                df[row, 2] <- activity[j, 2]
                tmp <- step4Data[step4Data$subject == i & step4Data$activity == activity[j, 2], ]
                df[row, 3:nColumns] <- colMeans(tmp[, 3:nColumns])
                row <- row + 1
        }
}

# Create a txt file from the tidy data set
write.table(df, "tidyDataSet.txt", row.names = FALSE)



## Use the following commands to read and view the data

# data <- read.table("tidyDataSet.txt", header = TRUE)
# View(data)
