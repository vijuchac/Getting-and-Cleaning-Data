library(dplyr)
library(data.table)
## STEP 1: Merges the training and the test sets to create one data set

featureNames <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)

## Reading the training data
sTrain <- read.table("train/subject_train.txt", header = FALSE)
aTrain <- read.table("train/y_train.txt", header = FALSE)
fTrain <- read.table("train/X_train.txt", header = FALSE)

## Reading the testing data

sTest <- read.table("test/subject_test.txt", header = FALSE)
aTest <- read.table("test/y_test.txt", header = FALSE)
fTest <- read.table("test/X_test.txt", header = FALSE)

## Merge both training and testing data
subject <- rbind(sTrain, sTest)
activity <- rbind(aTrain, aTest)
features <- rbind(fTrain, fTest)

#columns in the features data set can be named from the metadata in featureNames

colnames(features) <- t(featureNames[2])

# The data in features,activity and subject are merged and the complete data is now stored in completeData.

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

## STEP 2- Extracts only the measurements on the mean and standard deviation for each measurement

# Extract the column indices that have either mean or std in them
colsWithMeanSTDLabels <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

# Add activity and subject columns to the list and look at the dimension of completeData

requiredColumns <- c(colsWithMeanSTDLabels, 562, 563)

# Required columns are extracted to exData

exData <- completeData[,requiredColumns]

## STEP 3 - Descriptive activtiy names in the data sets

exData$Activity <- as.character(exData$Activity)
for (i in 1:6){
exData$Activity[exData$Activity == i] <- as.character(activityLabels[i,2])
}


exData$Activity <- as.factor(exData$Activity)

## STEP 4 -  Appropriately labels the data set with descriptive variable names


names(exData)<-gsub("BodyBody","Body",names(exData))
names(exData)<-gsub("tBodyAccJerkMag","TIME BODY ACCELEROMETER JERK MAGNITUDE",names(exData))
names(exData)<-gsub("fBodyGyroJerkMag","FREQUENCY BODY GYROSCOPE JERK MAGNITUDE",names(exData))
names(exData)<-gsub("fBodyAccJerkMag","FREQUENCY BODY ACCELEROMETER JERK MAGNITUDE",names(exData))
names(exData)<-gsub("fBodyAccMag","FREQUENCY BODY ACCELEROMETER MAGNITUDE",names(exData))
names(exData)<-gsub("fBodyGyroMag","FREQUENCY BODY GYROSCOPE MAGNITUDE",names(exData))
names(exData)<-gsub("tBodyAccMag","TIME BODY ACCELEROMETER MAGNITUDE",names(exData))
names(exData)<-gsub("tGravityAccMag","TIME GRAVITY ACCELEROMETER MAGNITUDE",names(exData))
names(exData)<-gsub("tBodyAccJerk", "TIME BODY ACCELEROMETER JERK", names(exData))
names(exData)<-gsub("tBodyGyroJerk","TIME BODY GYROSCOPE JERK",names(exData))
names(exData)<-gsub("tBodyGyroMag","TIME BODY GYROSCOPE MAGNITUDE",names(exData))
names(exData)<-gsub("tBodyGyroJerkMag","TIME BODY GYROSCOPE JERK MAGNITUDE",names(exData))
names(exData)<-gsub("fBodyAccJerk","FREQUENCY BODY ACCELEROMETER JERK",names(exData))
names(exData)<-gsub("tBodyAcc", "TIME BODY ACCELEROMETER", names(exData))
names(exData)<-gsub("tGravityAcc", "TIME GRAVITY ACCELEROMETER", names(exData))
names(exData)<-gsub("tBodyGyro","TIME BODY GYROSCOPE",names(exData))
names(exData)<-gsub("fBodyAcc","FREQUENCY BODY ACCELEROMETER",names(exData))
names(exData)<-gsub("fBodyGyro","FREQUENCY BODY GYROSCOPE",names(exData))

## STEP 5 - Extract out tidy data

exData$Subject <- as.factor(exData$Subject)
exData <- data.table(exData)

tidyData <- aggregate(. ~Subject + Activity, exData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
