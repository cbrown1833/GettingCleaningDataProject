---
title: README.md for Getting and Cleaning Data Project
---

With this project, we will collect, work with, and clean a data set.

We will utilize data collected from the accelerometers from the Samsung Galaxy S smartphone.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

We downloaded the file and unzipped it into a parallel directory to the code directory. (i.e.: programs in the code directory access the data using the "../data" directory prefix)

The "../data" directory contains several files utilized in the processing of this project.

	1) features.txt contains the column names for the data files
	2) activity_labels.txt contains the activities corresponding to the activity codes 1-6.
	3) train/X_train.txt - training measurement data file
	4) train/subject_train.txt - subject codes for training measurement data
	5) train/y_train.txt - activity codes for training measurement data
	6) test/X_test.txt  - test measurement data file
	7) test/subject_test.txt -  subject codes for test measurement data
	8) test/y_test.txt - activity codes for test measurement data

There are separate sets of data for both training and test, and we will be merging those two datasets.

## Processing

Column names were actually the first file read (features.txt), and the column name list
was used when loading the measurement data.

Merging the data was kind of like building blocks. It proceeded in several steps.

	1) Read the X_train.txt and X_test.txt data files and append them (rbind) together
	2) Read the activity code files, y_train.txt and y_test.txt, append (rbind)
		them together, then cbind the dataframe with the measurement data to it.
	3) Read the subject code files, subject_train.txt and subject_test.txt, 
		append (rbind) them together, then cbind the combined dataframe 
		from step 2) to it.
In summary, the subject code files from step 3) become the first column, the activity
codes from step 2) become the second column, and the measurement data from step 1 is 
the rest of the dataset.

Once the files have been assembled into a complete dataset, we then want to subset out the columns that contain a mean or standard deviation value. We identify those columns, and include columns 1 and 2 (Subject and Activity) into the list, and create the subset based on that column list.

We then change the activity labels from numbers to text, based on the contents of the activity_labels.txt file.

We then change the measurement labels (column headings) to make them clearer by completing abbreviations and removing redundant information and extra characters to complete the cleanup of the original datset.

The next step is to create a new dataset that for each type of measurement (column) contains a single measurement for each Subject/Activity pair that is the average for that pair for that measurement type. This is done using dplyr.

## Results

The resulting tidy datafile named GetCleanDataProject.txt was created according to the project instructions. 

That tidy data file can be read with:
data <- read.table("GetCleanDataProject.txt", header = TRUE)



