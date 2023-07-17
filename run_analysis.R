# Step 1: Merge the training and test sets
# Load required packages and data
required_packages <- c("data.table", "reshape2")
sapply(required_packages, require, character.only = TRUE, quietly = TRUE)
data_path <- getwd()
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, file.path(data_path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Load activity labels and features
activity_labels <- fread(file.path(data_path, "UCI HAR Dataset/activity_labels.txt"),
                         col.names = c("classLabels", "activityName"))
features <- fread(file.path(data_path, "UCI HAR Dataset/features.txt"),
                  col.names = c("index", "featureNames"))
features_wanted <- grep("(mean|std)\\(\\)", features[, featureNames])
selected_features <- features[features_wanted, featureNames]
selected_features <- gsub('[()]', '', selected_features)

# Load training datasets
train <- fread(file.path(data_path, "UCI HAR Dataset/train/X_train.txt"))[, features_wanted, with = FALSE]
data.table::setnames(train, colnames(train), selected_features)
train_activities <- fread(file.path(data_path, "UCI HAR Dataset/train/Y_train.txt"),
                          col.names = c("Activity"))
train_subjects <- fread(file.path(data_path, "UCI HAR Dataset/train/subject_train.txt"),
                        col.names = c("SubjectNum"))
train <- cbind(train_subjects, train_activities, train)

# Load test datasets
test <- fread(file.path(data_path, "UCI HAR Dataset/test/X_test.txt"))[, features_wanted, with = FALSE]
data.table::setnames(test, colnames(test), selected_features)
test_activities <- fread(file.path(data_path, "UCI HAR Dataset/test/Y_test.txt"),
                         col.names = c("Activity"))
test_subjects <- fread(file.path(data_path, "UCI HAR Dataset/test/subject_test.txt"),
                       col.names = c("SubjectNum"))
test <- cbind(test_subjects, test_activities, test)

# Merge the datasets
combined <- rbind(train, test)

# Step 2: Extract mean and standard deviation measurements
# Convert class labels to descriptive activity names
combined[["Activity"]] <- factor(combined[, Activity],
                                 levels = activity_labels[["classLabels"]],
                                 labels = activity_labels[["activityName"]])

# Convert subject numbers to factors
combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])

# Reshape the data and calculate the mean for each variable, activity, and subject
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

# Write the resulting tidy dataset to a file
data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)
