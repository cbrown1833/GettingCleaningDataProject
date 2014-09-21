---
title: Codebook for Getting/Cleaning Data Project
---

### Variables used for data files

The "../data" directory contains several files utilized in the processing of this project.

    1) features.txt contains the column names for the data files
    2) activity_labels.txt contains the activities corresponding to the activity codes 1-6.
	3) train/X_train.txt - training measurement data file
	4) train/subject_train.txt - subject codes for training measurement data
	5) train/y_train.txt - activity codes for training measurement data
	6) test/X_test.txt  - test measurement data file
	7) test/subject_test.txt -  subject codes for test measurement data
	8) test/y_test.txt - activity codes for test measurement data

Each of these data files is assigned a variable name, and is read into a dataset, as follows:

       Dataset Name        File Variable Name      Filename
       ------------        ------------------      --------
    1) columnNames         <- columnNamesFile      <- features.txt
    2) activity_labels     <- activity_labelsFile  <- activity_labels.txt
	3) trainData           <- trainDataFile        <- train/X_train.txt
	4) train_subjects      <- subject_trainFile    <- train/subject_train.txt
	5) trainY              <- y_trainFile          <- train/y_train.txt
	6) testData            <- testDataFile         <- test/X_test.txt
	7) test_subjects       <- subject_testFile     <- test/subject_test.txt
	8) testY               <- y_testFile           <- test/y_test.txt
    
## Working with merged data

These files are assembled together into the 'allData' dataset, as described in the README.md file.

The 'subcols' variable is used to construct a list of columns to create the subset dataset that contains the mean and standard deviation measurements.

The 'subData' dataset contains the mean/standard deviation data subset.

The activity labels file was analyzed during the exploratory analysis and used to create the activity substitution code, but in this script it is only being displayed for clarity.

In order to clean up the column names for the measurements, and based on the exploratory analysis, a number of substitutions for the column names were established, as follows:

    Old String converts to New String
    ----------             ----------
    "tBody"                "TimeBody"
    "tGrav"                "TimeGrav"
    "fGrav"                "FrequencyGrav"
    "fGrav"                "FrequencyGrav"
    "fBody"                "FrequencyBody"
    "fBody"                "FrequencyBody"
    "Acc"                  "Accelerate"
    "Gyro"                 "Gyroscope"
    "std"                  "StdDev"
    "mean"                 "Mean"
    "BodyBody"             "Body"
    "\\."                  ""

##Results

The final dataset 'newData' is created with dplyr, by ordering by Subject and Activity, and calculating the mean for each Subject/Activity/measurement subset. The resulting 'newData' datset has 180 rows, which corresponds to 30 Subjects times 6 Activities.



