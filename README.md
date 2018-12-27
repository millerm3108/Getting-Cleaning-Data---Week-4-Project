# Getting-Cleaning-Data---Week-4-Project

Source file: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Copy the "R_analysis.R" script into working directory. Make sure the following files are also in working directory:

features.txt
activity_labels.txt
X_train.txt
subject_train.txt
y_train.txt
X_test.txt
subject_test.txt
y_test.txt

Next, run the "R_analysis.R" script.

The main steps performed in the "run_analysis.R" script are the following:

1. Reading data from each single .txt file 
2. Merge train & test data with its subject and activity columns. 
3. Merge train and test data 
4. Assign activity names to their correspondent activity type and add the activity type column to the merged data set
5. Subset only measurement of the mean and standard deviation
6. Create a new idependent data set with the average of each variable for each activity and each subject, using the aggregate function.
7. Write the resulting data set into a .txt file 
