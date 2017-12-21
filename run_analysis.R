### Getting and Cleaning Data Course Project
# By Jeroen Broekhuisen, December 2017


## Merges the training and the test sets to create one data set.
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir = "./data/GADC")

TrainData <- read.table("./data/GADC/UCI HAR Dataset/train/X_train.txt", header = FALSE)
TrainActivityData <- read.table("./data/GADC/UCI HAR Dataset/train/y_train.txt", header = FALSE)
TrainSubjectData <- read.table("./data/GADC/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

colnames(TrainActivityData) <- "Activity"
colnames(TrainSubjectData) <- "Subject"

# Combine train data
TrainDataComplete <- cbind(TrainSubjectData, TrainActivityData, TrainData)

TestData <- read.table("./data/GADC/UCI HAR Dataset/test/X_test.txt", header = FALSE)
TestActivityData <- read.table("./data/GADC/UCI HAR Dataset/test/y_test.txt", header = FALSE)
TestSubjectData <- read.table("./data/GADC/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

colnames(TestActivityData) <- "Activity"
colnames(TestSubjectData) <- "Subject"

# Combine test data
TestDataComplete <- cbind(TestSubjectData, TestActivityData, TestData)


CombinedData <- rbind(TrainDataComplete, TestDataComplete)

#Remove data from memory
rm(TrainData)
rm(TestData)
rm(TrainDataComplete)
rm(TestDataComplete)
rm(TrainActivityData)
rm(TrainSubjectData)
rm(TestActivityData)
rm(TestSubjectData)


## Extracts only the measurements on the mean and standard deviation for each measurement.
ColumnNames <- read.table("./data/GADC/UCI HAR Dataset/features.txt", header = FALSE)
DesiredValues <- paste("V", grep("std|mean", ColumnNames$V2), sep = "")
DesiredValues <- c("Subject", "Activity", DesiredValues)

library(dplyr)
CombinedDataSmall <- select(CombinedData, DesiredValues)

#Remove data from memory
rm(CombinedData)


## Uses descriptive activity names to name the activities in the data set
ActivityNames <- read.table("./data/GADC/UCI HAR Dataset/activity_labels.txt", header = FALSE)
class(CombinedDataSmall$Activity) <- "character"
NumberOfRecords <- nrow(CombinedDataSmall)

for(i in 1:NumberOfRecords) {
  if (CombinedDataSmall$Activity[i] == "1") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[1])}
  if (CombinedDataSmall$Activity[i] == "2") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[2])}
  if (CombinedDataSmall$Activity[i] == "3") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[3])}
  if (CombinedDataSmall$Activity[i] == "4") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[4])}
  if (CombinedDataSmall$Activity[i] == "5") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[5])}
  if (CombinedDataSmall$Activity[i] == "6") {CombinedDataSmall$Activity[i] <- as.character(ActivityNames$V2[6])}

}
## Appropriately labels the data set with descriptive variable names.
DesiredNames <- as.character(ColumnNames$V2[grep("std|mean", ColumnNames$V2)])
DesiredNames <- c("Subject", "Activity", DesiredNames)

names(CombinedDataSmall) <- DesiredNames

#Remove data from memory
rm(ColumnNames)
rm(ActivityNames)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# First create an empty data frame of the right size
MeanData2 <- summarise(group_by(CombinedDataSmall, Activity, Subject))
MeanData2 <- as.data.frame(MeanData2)

MeanData1 <- matrix(data = NA, nrow = 180, ncol =  (length(DesiredNames)-2), byrow = FALSE, dimnames = NULL)
MeanData1 <- as.data.frame(MeanData1)
MeanData <- cbind(MeanData2, MeanData1)

# Swap names of first two columns
TextName <- DesiredNames[1]
DesiredNames[1] <- DesiredNames[2]
DesiredNames[2] <- TextName

names(MeanData) <- DesiredNames

#Remove data from memory
rm(MeanData1)
rm(MeanData2)

NumberRows <- nrow(MeanData)

for (iTest in (3:ncol(MeanData))) {
    TempData <- select(CombinedDataSmall, "Activity", "Subject", DesiredNames[iTest])
    TestName <- DesiredNames[iTest]
    for (iRow in (1:NumberRows)) {
        ActSubData <- filter(TempData, Activity == MeanData$Activity[iRow] & Subject == MeanData$Subject[iRow])
        MeanData[[TestName]][iRow] <- mean(ActSubData[[TestName]])      
          
    }      
}

#Remove data from memory
rm(ActSubData)
rm(TempData)

