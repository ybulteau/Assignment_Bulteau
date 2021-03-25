The run_analysis.R script starts by reading the test and training data sets in the \UCI HAR Datase\test\X_test.txt and \UCI HAR Datase\test\X_train.txt files.

The corresponding activities and subject vectors are read respectivly from the y_test.txt and y_train.txt files and from the subject_test.txt and subject_train.txt files.

The test and train data sets are then merged.

The feature labels are read from the \UCI HAR Datase\features.txt file and only the labels containing the "mean()" or "std()" sequence of characters are kept. Only the corresponding data vectors from the data set are kept. The data vectors are named after the feature labels.

The values of the activity vector take the names obtained from the activity_label.txt file.

The data frame is sorted by activity and by subject.

A summary is made by calculating the mean value of each features for each combination of activity and subject, and is printed in the data_summary.txt file. The first vector is the name vector, with the name of the activity and subject vector, as well as the name of the features. The rest of the file is made of vectors of each combination of activity and subject, and corresponding mean feature values.

More info on the features can be found in the \UCI HAR Datase\features_info.txt file.