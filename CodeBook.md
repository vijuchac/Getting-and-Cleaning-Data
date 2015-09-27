# Code Book

## Background
This Code book  describes the variables, the data, and transformations that are performed to clean up the data

### Overview

The source of this data, is from: The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 70% of the volunteers was selected for generating the training data and 30% the test data. 

The source data is available at 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Once the source data is unzipped into a specific folder; following describes the key files, within the source data:

* `features.txt`: Names of the 561 features.
* `activity_labels.txt`: Names and IDs for each of the 6 activities.

* `X_train.txt`: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* `subject_train.txt`: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in `X_train.txt`.
* `y_train.txt`: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in `X_train.txt`.

* `X_test.txt`: 2947 observations of the 561 features, for 9 of the 30 volunteers.
* `subject_test.txt`: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in `X_test.txt`.
* `y_test.txt`: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in `X_test.txt`.

More information about the files is available in `README.txt`. More information about the features is available in `features_info.txt`.

###  run_analysis.R 

 run_analysis.R available as part of this respository; would provide the required transformations to create a tidy data set. Tidy.txt

### How to execute run_analysis.R

The source data should be unzipped into a folder of choice; the same folder should be set as the working director within R
setwd("<Directory where zip file is extracted>/UCI HAR Dataset")
PS: After unzipping the working directory should be set to "UCI HAR Dataset", since R Script assumes that working directory is set at this level.

### Processing steps
 
 Following explains the setps carried out in run_analysis.R
 
* STEP 1: Merges the training and the test sets to create one data set
* STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement
* STEP 3: Descriptive activtiy names are set in the data sets
* STEP 4: Appropriately labels the data set with descriptive variable names
* STEP 5: Extract out tidy data
* Output to be available as Tidy.txt in the working directory
