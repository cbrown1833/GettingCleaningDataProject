## run_analysis.R - script for Getting and Cleaning Data course project
##
## The data files have been unzipped into a parallel directory, "../data"
##
columnNamesFile <- "../data/features.txt"
activity_labelsFile <- "../data/activity_labels.txt"
#
trainDataFile     <- "../data/train/X_train.txt"
subject_trainFile <- "../data/train/subject_train.txt"
y_trainFile       <- "../data/train/y_train.txt"
#
testDataFile      <- "../data/test/X_test.txt"
subject_testFile  <- "../data/test/subject_test.txt"
y_testFile        <- "../data/test/y_test.txt"

## Get the column names into a vector named cNames
##
columnNames <- read.table(columnNamesFile, stringsAsFactors=FALSE,
	header=FALSE)
cNames <- columnNames$V2

## Load the train data and the test data and append test to train with rbind()
##
trainData <- read.table(trainDataFile, stringsAsFactors=FALSE,
	col.names=cNames,header=FALSE)
testData <- read.table(testDataFile, stringsAsFactors=FALSE,
	col.names=cNames,header=FALSE)
allData <- rbind(trainData,testData)

## Load the activity data (y_train/y_test) and append, then cbind() to allData
##
trainY <- read.table(y_trainFile, stringsAsFactors=FALSE,
	col.names="Activity",header=FALSE)
testY <- read.table(y_testFile, stringsAsFactors=FALSE,
	col.names="Activity",header=FALSE)
allY <- rbind(trainY,testY)
allData <- cbind(allY, allData)

## Load the subject data (subject_train/subject_test) and append, then cbind() to allData
##
train_subjects <- read.table(subject_trainFile, stringsAsFactors=FALSE,
	col.names="Subject",header=FALSE)
test_subjects <- read.table(subject_testFile, stringsAsFactors=FALSE,
	col.names="Subject",header=FALSE)
all_subjects <- rbind(train_subjects,test_subjects)
allData <- cbind(all_subjects, allData)

## Get a list of colums containing means or standard deviations, sort them, add 2 and include
##	1 and 2 to leave room for the Subject and Activity columns
##
subcols <- c(grep("mean",columnNames$V2),grep("std",columnNames$V2),grep("Mean",columnNames$V2))
subcols <- sort(subcols)
subcols <- subcols+2
subcols <- c(1,2,subcols)

## create the subData dataset, with the subset of columns
##
subData <- allData[ ,subcols]

#change the activity labels
# Reviewed contents of activity_labels file to determine replacement
#	names for Activity column values
activity_labels<- read.table(activity_labelsFile, stringsAsFactors=FALSE,
      header=FALSE)
activity_labels
subData$Activity <- as.character(subData$Activity)
subData$Activity <- ifelse(subData$Activity == "1", "Walking", subData$Activity)
subData$Activity <- ifelse(subData$Activity == "2", "Walking Up", subData$Activity)
subData$Activity <- ifelse(subData$Activity == "3", "Walking Down", subData$Activity)
subData$Activity <- ifelse(subData$Activity == "4", "Sitting", subData$Activity)
subData$Activity <- ifelse(subData$Activity == "5", "Standing", subData$Activity)
subData$Activity <- ifelse(subData$Activity == "6", "Laying", subData$Activity)

# Clean up the column headings
colnames(subData) <- gsub("tBody","TimeBody", colnames(subData))
colnames(subData) <- gsub("tGrav","TimeGrav", colnames(subData))
colnames(subData) <- gsub("fGrav","FrequencyGrav", colnames(subData))
colnames(subData) <- gsub("fGrav","FrequencyGrav", colnames(subData))
colnames(subData) <- gsub("fBody","FrequencyBody", colnames(subData))
colnames(subData) <- gsub("fBody","FrequencyBody", colnames(subData))
colnames(subData) <- gsub("Acc","Accelerate", colnames(subData))
colnames(subData) <- gsub("Gyro","Gyroscope", colnames(subData))
colnames(subData) <- gsub("std","StdDev", colnames(subData))
colnames(subData) <- gsub("mean","Mean", colnames(subData))
colnames(subData) <- gsub("BodyBody","Body", colnames(subData))
colnames(subData) <- gsub("\\.", "", colnames(subData))

# Create the newData dataset, grouping by Subject and Activity,
#	and calculating the mean of each measurement for each
#	Subject/Activity subset. newData has 180 rows/observations,
#	which is based on 30 Subjects times 6 Activities = 180
library(dplyr)
newData <- select(subData, Subject:FrequencyBodyGyroscopeJerkMagMeanFreq) %>%
	group_by(Subject, Activity) %>%
	summarise_each(funs(mean))

write.table(newData, file="GetCleanDataProject.txt",row.name=FALSE)

