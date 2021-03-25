library("dplyr")

#Extraction of the test dataset
subject_test = read.csv("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test = read.csv("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test = read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
X_test = strsplit(X_test$V1, " ")
X_test = lapply(X_test, function(x) x[!x == ""])
X_test = lapply(X_test, as.numeric)

#Extraction of the test dataset
subject_train = read.csv("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train = read.csv("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train = read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_train = strsplit(X_train$V1, " ")
X_train = lapply(X_train, function(x) x[!x == ""])
X_train = lapply(X_train, as.numeric)

# Test data: conversion from list to data frame
test_data = data.frame(X_test)
test_data = as.data.frame(t(test_data))

# Test data: naming the rows and columns
rownames(test_data) = paste0("V", seq(1:length(X_test)))
names(subject_test) = "subject"
names(y_test) = "activity"

# Binding the subject and activity columns to the variable columns
test_data = cbind(subject_test, y_test, test_data)

# Training data: conversion from list to data frame
train_data = data.frame(X_train)
train_data = as.data.frame(t(train_data))

# Training data: naming the rows and columns
rownames(train_data) = paste0("V", seq(1:length(X_train)))
names(subject_train) = "subject"
names(y_train) = "activity"

# Binding the subject and activity columns to the variable columns
train_data = cbind(subject_train, y_train, train_data)

# Merging test and training data
full_data = rbind(test_data, train_data)
full_data = arrange(full_data, subject, activity)

# Extracting feature labels
features = read.table("./UCI HAR Dataset/features.txt")

# Selecting only mean() and std() feature labels
i_extract = grep("mean\\(\\)|std\\(\\)", features$V2)
feature_extract = features$V2[i_extract]

# Selecting only mean() and std() feature data
full_data = select(full_data, 1,2, 2+i_extract)

# Naming the features in the data frame
colnames(full_data)[3:68] = feature_extract

# Extracting the activity labels
activities = read.table("./UCI HAR Dataset/activity_labels.txt")

# Merging the activity labels with the main data frame
full_data = merge(activities, full_data, by.x = "V1", by.y = "activity")

# Deleting redundant activity number vector
full_data = select(full_data, -V1)

# Renaming new activity vector
full_data = rename(full_data, activity = V2)

# Grouping and summarising data by activity and subject. A mean value is calculated for each activity-subject combination.
full_data = group_by(full_data, activity, subject)
data_summary = summarise_all(full_data, mean)

write.table(data_summary, "data_summary.txt", row.name=FALSE)
