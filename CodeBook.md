## Code Book

This is a code book that describes the variables, the data, and any transformations performed to clean up the data

# The variables

When the script "run_analysis.R" has been executed in R the result is a data set called "MeanData".
The first column of the data set contain the "Activity". There are the following activities:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

The Second column contains the Subject indicator which represents a specific person executing the tests. They are numbered 1 to 30. All subjects have performed all activities. No missing data has been found.

The other columns contain the specific measurements performed. The column header indicates which is the measurement. From the original raw data only the Mean and Standard deviation data has been used. Selected by taking all columns that contained the text "mean" or "std". The full list can be found in the file "features.txt" of the original data set.


# The Raw Data

The raw data has been downloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This is also the location from where the script "run_analysis.R" will download the data. 

The raw data contains of two data sets, training data and test data. Alse for both there are files with activity data and subject data. In total the following files are used:
UCI HAR Dataset/train/X_train.txt - Train data
UCI HAR Dataset/train/y_train.txt - Train activities
UCI HAR Dataset/train/subject_train.txt - Train subjects
UCI HAR Dataset/test/X_test.txt - Test data
UCI HAR Dataset/test/y_test.txt - Test activities
UCI HAR Dataset/test/subject_test.txt - test subjects


# The script "run_analysis.R"

The script contains comments so it is more easy to follow what actions have been performend on the data. The five steps have been followed as given in the assignment.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Requirements:
- The script should be ran in R (via R studio is fine)
- The script requires an internet connection to be able to download the source data
- The script uses the R package "dplyr" so that should be installed. (This packes was used on various occasions during the course so if you followed that it should already be installed.


