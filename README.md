### README.md - Getting-and-Cleaning-Data

Included files in this repository are:

- README.md - script description (this file)
- CodeBook.md - tidyData.txt data set description
- run_analysis.R - collection of R commands


#### Applied procedure to generate tidyData.txt

The file "getdata-projectfiles-UCI HAR Dataset.zip" was unzipped with the archive manager "Engrampa 1.6.0".

The directory "UCI HAR Dataset" is considered the working directory as of now. This directory should at least contain following files:

- "test/subject_test.txt" - Identifies the subject who performed the activity. Ranges from 1 to 30.
- "test/X_test.txt" - Test data set.
- "test/y_test.txt" - Test labels.
- "train/subject_train.txt" - Identifies the subject who performed the activity. Ranges from 1 to 30.
- "train/X_train.txt" - Training data set.
- "train/y_train.txt" - Training labels.
- "activity_labels.txt" - Links the class labels with their activity name.
- "features.txt" - List of all features.
- "features_info.txt" - Shows information about the variables used on the feature vector.

Other files and directories will be present but are not needed for the present assignment.

**The recommended order of steps for generating the tidyData.txt file were:**
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


**A slightly different order has been applied here:**
- Training and test data sets were kept separate for as long as possible.
- Descriptive names for the activities were applied separately to both data sets before any merging with the feature data sets were done.
- Subject and activity columns were cast to factors.
- Feature data sets were treated apart. The column names were added to both data sets and subsequently the non-desired columns were removed from both data sets.
- The training and test feature data sets were merged with the corresponding subject/activity data sets.
- And finally the training data set was merged with the test data set.
- The tidy data set with the average of each variable for each activity and each subject was then derived from the merged data set.


**Below follows a more detailed description of the merge operation:**
- Read **subject_train** and **subject_test** data.
  - train <- read.table("train/subject_train.txt")
  - test <- read.table("test/subject_test.txt")
- Add column names to **train** and **test** data frames.
  - names(train) <- "subject"
  - names(test) <- "subject"
- Read **y_train** and **y_test** activity data.
  - trainY <- read.table("train/y_train.txt")
  - testY <- read.table("test/y_test.txt")
- Add column names to **trainY** and **testY** data frames.
  - names(trainY) <- "activ"
  - names(testY) <- "activ"
- Column merge **subject** and **activity** data frames for **train** and **test** data.
  - train <- cbind(train, trainY)
  - test <- cbind(test, testY)
- Create **new column** in **train** and **test** data frames.
  - train["activity"] <- " "
  - test["activity"] <- " "
- Replace test **activity code** with **descriptive label**.
  - test$activity[test$activ == 1] <- "WALKING"
  - test$activity[test$activ == 2] <- "WALKING_UPSTAIRS"
  - test$activity[test$activ == 3] <- "WALKING_DOWNSTAIRS"
  - test$activity[test$activ == 4] <- "SITTING"
  - test$activity[test$activ == 5] <- "STANDING"
  - test$activity[test$activ == 6] <- "LAYING"
- Change column types of **activity** and **subject** to **factors** and delete column activ, as not needed anymore.
  - test$activity <- as.factor(test$activity)
  - test$subject <- as.factor(test$subject)
  - test$activ <- NULL
- Replace train **activity code** with **descriptive label**.
  - train$activity[train$activ == 1] <- "WALKING"
  - train$activity[train$activ == 2] <- "WALKING_UPSTAIRS"
  - train$activity[train$activ == 3] <- "WALKING_DOWNSTAIRS"
  - train$activity[train$activ == 4] <- "SITTING"
  - train$activity[train$activ == 5] <- "STANDING"
  - train$activity[train$activ == 6] <- "LAYING"
- Change column types of **activity** and **subject** to **factors** and delete column activ, as not needed anymore.
  - train$activity <- as.factor(train$activity)
  - train$subject <- as.factor(train$subject)
  - train$activ <- NULL
- Read **X_train** and **X_test** feature data.
  - trainD <- read.table("train/X_train.txt")
  - testD <- read.table("test/X_test.txt")
- Extract column names from **features.txt**.
  - feat <- read.table("features.txt")
  - colnames <- feat[,2]
- Add column names to **trainD** and **testD** data frames.
  - names(trainD) <- colnames
  - names(testD) <- colnames
- Only keep columns with **mean()** and **std()** in column names.
  - testD <- testD[,(grepl("mean\\(\\)", colnames(testD))) | (grepl("std\\(\\)", colnames(testD)))]
  - trainD <- trainD[,(grepl("mean\\(\\)", colnames(trainD))) | (grepl("std\\(\\)", colnames(trainD)))]
- Column merge **subject/activity** with **X feature** data frames for train and test data.
  - train <- cbind(train, trainD)
  - test <- cbind(test, testD)
- Row merge **train** and **test** data frames into **allData** data frame.
  - allData <- rbind(test, train)
- Calculate **means grouped by activity and subject** and sort the result by activity and subject.
  - tidyData <- aggregate(allData[,3:68], by=list(activity=allData$activity, subject=allData$subject), mean)
  - tidyData <- tidyData[order(tidyData$activity, as.numeric(as.character(tidyData$subject))),]
- Write resulting data frame to **tidyData.txt**.
  - write.table(tidyData, file="tidyData.txt", row.names=FALSE)


**In order to easily visualize tidyData.txt, it is suggested to follow the procedure described below:**
- data <- read.table("tidyData.txt", header = TRUE)
- View(data)

Please consult run_analysis.R in this repository for the complete source code of the R script.

#### Choices made while treating/analyzing the data:
- Only columns from the X_train and X_test data that contained **"std()"** and **"mean()"** in their column names were included.
- The sorting and display order was chosen to be:
  - "activity" as first criteria.
  - "subject" as second criteria.
- Column names were kept the same as in the original data, as they describe the values the way the original researchers/authors saw them fit.
- The command **"cbind"** was preferred to **"merge"** so as not to risk a row order mutation before all data frames were merged.
- Some optimizations could have been applied, but due to the lack of experience with R, the modest size of the data and a desire to keep the data manipulation script clear and understandable, a slower and slightly longer script was chosen.
- The original feature columns included dashes is their names. No attempt was made to correct this.
