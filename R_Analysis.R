## Getting & Cleaning Data - Project

setwd("~/Coursera/Data Science (Johns Hopkins)/3 - Getting & Cleaning Data/Project")
library(dplyr)


## SET UP DATA FOR ANALYSIS

## Read in data from test & train

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Read in activity labels & feature names

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F)
feature_names <- read.table("./UCI HAR Dataset/features.txt", header = F)

## Assign names/columns
colnames(subject_train) = "subjectId"
colnames(x_train) = feature_names[, 2]
colnames(y_train) = "activityId"

colnames(subject_test) = "subjectId"
colnames(x_test) = feature_names[, 2]
colnames(y_test) = "activityId"

colnames(activity_labels) <- c('activityId', 'activityType')


## 1. Merge train/test sets into new dataset

train_data <- cbind(subject_train, y_train, x_train)
test_data <- cbind(subject_test, y_test, x_test)
merged_data <- rbind(train_data, test_data)

## 2. Extract measurements on mean/std. dev. 

sub_feature_names <- colnames(merged_data)
mean_stddev = (grepl("activityId", sub_feature_names)| grepl("subjectId", sub_feature_names)| grepl("mean..", sub_feature_names)|grepl("std..", sub_feature_names))
set_mean_stddev <- merged_data[ , mean_stddev == TRUE]

## 3. Set descriptive ativity names to activities in dataset

set_activity_names = merge (set_mean_stddev, activity_labels, by = 'activityId', all.x = TRUE)
columns <- colnames(merged_data)

## 4. Label dataset w/ descriptive names

names(merged_data)<-gsub("^t", "time", names(merged_data))
names(merged_data)<-gsub("^f", "frequency", names(merged_data))
names(merged_data)<-gsub("Acc", "Accelerometer", names(merged_data))
names(merged_data)<-gsub("Gyro", "Gyroscope", names(merged_data))
names(merged_data)<-gsub("Mag", "Magnitude", names(merged_data))
names(merged_data)<-gsub("BodyBody", "Body", names(merged_data))

## 5. Create & save new tidy dataset

new_tidyset <- aggregate(. ~subjectId + activityId, set_activity_names, mean)
new_tidyset <- new_tidyset[order(new_tidyset$subjectId, new_tidyset$activityId),]
write.table(new_tidyset, "new_tidyset.txt", row.name = FALSE)
