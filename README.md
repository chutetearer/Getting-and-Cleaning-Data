### Getting-and-Cleaning-Data

Included files in this repository are:

- README.md - script description (this file)
- CodeBook.md - tidyData.txt data set description
- run_analysis.R - collection of R commands


#### Applied procedure to generate tidyData.txt

The file "getdata-projectfiles-UCI HAR Dataset.zip" was unzipped with the archive manager "Engrampa 1.6.0".

The directory "UCI HAR Dataset" will be considered the working directory as of now. The content of this directory should at least be as follows:

- "UCI HAR Dataset/test/subject_test.txt" - Identifies the subject who performed the activity. Ranges from 1 to 30.
- "UCI HAR Dataset/test/X_test.txt" - Test data set.
- "UCI HAR Dataset/test/y_test.txt" - Test labels.
- "UCI HAR Dataset/train/subject_train.txt" - Identifies the subject who performed the activity. Ranges from 1 to 30.
- "UCI HAR Dataset/train/X_train.txt" - Training data set.
- "UCI HAR Dataset/train/y_train.txt" - Training labels.
- "UCI HAR Dataset/activity_labels.txt" - Links the class labels with their activity name.
- "UCI HAR Dataset/features.txt" - List of all features.
- "UCI HAR Dataset/features_info.txt" - Shows information about the variables used on the feature vector.
- "UCI HAR Dataset/README.txt"

Other files and directories will be present but are not needed for the present assignment.



You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## This run_analysis.R script merges and cleans the
## "Human Activity Recognition Using Smartphones Dataset"
## and generates a summary data frame with means of
## selected columns by activity and subject.
## See README.md and CodeBook.md for more details.


## read subject_train and subject_test data
train <- read.table("train/subject_train.txt")
test <- read.table("test/subject_test.txt")

## add column names to train and test data frames
names(train) <- "subject"
names(test) <- "subject"

## read y_train and y_test activity data
trainY <- read.table("train/y_train.txt")
testY <- read.table("test/y_test.txt")

## add column names to trainY and testY data frames
names(trainY) <- "activ"
names(testY) <- "activ"

## column merge subject and activity data
## frames for train and test data
train <- cbind(train, trainY)
test <- cbind(test, testY)

## create new column in train and test data frames
train["activity"] <- " "
test["activity"] <- " "

## replace test activity code with descriptive label
test$activity[test$activ == 1] <- "WALKING"
test$activity[test$activ == 2] <- "WALKING_UPSTAIRS"
test$activity[test$activ == 3] <- "WALKING_DOWNSTAIRS"
test$activity[test$activ == 4] <- "SITTING"
test$activity[test$activ == 5] <- "STANDING"
test$activity[test$activ == 6] <- "LAYING"

## change column types of activity and subject to factors
## and delete column activ, as not needed anymore
test$activity <- as.factor(test$activity)
test$subject <- as.factor(test$subject)
test$activ <- NULL

## replace train activity code with descriptive label
train$activity[train$activ == 1] <- "WALKING"
train$activity[train$activ == 2] <- "WALKING_UPSTAIRS"
train$activity[train$activ == 3] <- "WALKING_DOWNSTAIRS"
train$activity[train$activ == 4] <- "SITTING"
train$activity[train$activ == 5] <- "STANDING"
train$activity[train$activ == 6] <- "LAYING"

## change column types of activity and subject to factors
## and delete column activ, as not needed anymore
train$activity <- as.factor(train$activity)
train$subject <- as.factor(train$subject)
train$activ <- NULL

## read X_train and X_test activity data
trainD <- read.table("train/X_train.txt")
testD <- read.table("test/X_test.txt")

## extract column names from features.txt
feat <- read.table("features.txt")
colnames <- feat[,2]

## add column names to trainD and testD data frames
names(trainD) <- colnames
names(testD) <- colnames

## only keep columns with mean() and std() in column names
testD <- testD[,(grepl("mean\\(\\)", colnames(testD))) | (grepl("std\\(\\)", colnames(testD)))]
trainD <- trainD[,(grepl("mean\\(\\)", colnames(trainD))) | (grepl("std\\(\\)", colnames(trainD)))]

## column merge subject/activity with X data
## frames for train and test data
train <- cbind(train, trainD)
test <- cbind(test, testD)

## row merge train and test data frames
## into allData data frame
allData <- rbind(test, train)

## calculate means grouped by activity and subject
## and sort the result by activity and subject
tidyData <- aggregate(allData[,3:68], by=list(activity=allData$activity, subject=allData$subject), mean)
tidyData <- tidyData[order(tidyData$activity, as.numeric(as.character(tidyData$subject))),]

## write resulting data frame to tidyData.txt
write.table(tidyData, file="tidyData.txt", row.names=FALSE)

## EOF run_analysis.R
