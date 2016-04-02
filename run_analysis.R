# STEP 1: Merges the training and the test sets to create one data set.
# build the test file, combining inputs from 3 source files
test = read.csv("X_test.txt", sep="", header=FALSE)
test[,562] = read.csv("y_test.txt", sep="", header=FALSE)
test[,563] = read.csv("subject_test.txt", sep="", header=FALSE)

# build the train file, combining inputs from 3 source files
train = read.csv("X_train.txt", sep="", header=FALSE)
train[,562] = read.csv("Y_train.txt", sep="", header=FALSE)
train[,563] = read.csv("subject_train.txt", sep="", header=FALSE)

# read activity labels
activityLabels = read.csv("activity_labels.txt", sep="", header=FALSE)

# read features
features = read.csv("features.txt", sep="", header=FALSE)

# STEP 4: Appropriately labels the data set with descriptive variable names.
# make features more readable
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

# combine training and testing datasets together
allData = rbind(train, test)

# STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement.
# Get only the data on mean and std. dev.
colsWeWant <- grep(".*Mean.*|.*Std.*", features[,2])
# First reduce the features table to what we want
features <- features[colsWeWant,]
colsWeWant <- c(colsWeWant, 562, 563)
allData <- allData[,colsWeWant]

# set the column names to the second variable in features, plus activity and subject
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))

# STEP 3: Uses descriptive activity names to name the activities in the data set
stepActivity = 1
for (stepActivityLabel in activityLabels$V2) {
  allData$activity <- gsub(stepActivity, stepActivityLabel, allData$activity)
  stepActivity <- stepActivity + 1
}

allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)

# STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
# activity and each subject.
require(dplyr)
tidy <- group_by(allData, activity, subject) %>% summarize_each(funs(mean))
write.csv(tidy, "tidy.csv")

# Thanks to eriky for sample script: https://github.com/eriky/coursera-getting-and-cleaning-data/blob/master/run_analysis.R