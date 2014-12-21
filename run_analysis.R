## my analysis/cleaning script

train <- read.table("subject_train.txt")
names(train) <- "subject"
test <- read.table("subject_test.txt")
names(test) <- "subject"

trainY <- read.table("y_train.txt")
names(trainY) <- "activ"
testY <- read.table("y_test.txt")
names(testY) <- "activ"

train <- cbind(train, trainY)
test <- cbind(test, testY)

train["activity"] <- " "
test["activity"] <- " "

test$activity[test$activ == 1] <- "WALKING"
test$activity[test$activ == 2] <- "WALKING_UPSTAIRS"
test$activity[test$activ == 3] <- "WALKING_DOWNSTAIRS"
test$activity[test$activ == 4] <- "SITTING"
test$activity[test$activ == 5] <- "STANDING"
test$activity[test$activ == 6] <- "LAYING"

test$activity <- as.factor(test$activity)
test$subject <- as.factor(test$subject)
test$activ <- NULL

train$activity[train$activ == 1] <- "WALKING"
train$activity[train$activ == 2] <- "WALKING_UPSTAIRS"
train$activity[train$activ == 3] <- "WALKING_DOWNSTAIRS"
train$activity[train$activ == 4] <- "SITTING"
train$activity[train$activ == 5] <- "STANDING"
train$activity[train$activ == 6] <- "LAYING"

train$activity <- as.factor(train$activity)
train$subject <- as.factor(train$subject)
train$activ <- NULL

trainD <- read.table("X_train.txt")
testD <- read.table("X_test.txt")

feat <- read.table("features.txt")
colnames <- feat[,2]

names(trainD) <- colnames
names(testD) <- colnames

testD <- testD[,(grepl("mean\\(\\)", colnames(testD))) | (grepl("std\\(\\)", colnames(testD)))]
trainD <- trainD[,(grepl("mean\\(\\)", colnames(trainD))) | (grepl("std\\(\\)", colnames(trainD)))]

train <- cbind(train, trainD)
test <- cbind(test, testD)

allData <- rbind(test, train)

tidyData <- aggregate(allData[,3:68], by=list(activity=allData$activity, subject=allData$subject), mean)
tidyData <- tidyData[order(tidyData$activity, as.numeric(as.character(tidyData$subject))),]

write.table(tidyData, file="tidyData.txt", row.names=FALSE)
