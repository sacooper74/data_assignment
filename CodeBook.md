# CodeBook for the tidy dataset

## Data Source

The data for this project is available at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Files Required

The following files are required in the working directory:
1. activity_labels
2. features
3. subject_test
4. subject_train
5. X_test
6. X_train
7. y_test
8. y_train

## Selection

1. Both training and test data from the data source were consolidated
2. Only the measurements related to mean and standard deviation were selected, all other measurements were removed
3. Activity labels were substituted with descriptive names (from activity)
4. A final "tidy" dataset was created, grouped by activity and subject and averages of all other columns