The project titled "Getting and Cleaning Data" aims to provide additional information regarding the variables, data, and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course. The project focuses on processing a dataset obtained from the UCI Machine Learning Repository.

The dataset consists of experiments conducted on a group of 30 volunteers within the age range of 19-48 years. Each participant performed six activities while wearing a smartphone equipped with an accelerometer and gyroscope. The activities include WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING. The sensor signals captured the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The data was manually labeled based on video recordings of the experiments. The dataset was divided randomly into training and test sets, with 70% of the volunteers used for training and 30% for testing.

To preprocess the sensor signals, noise filters were applied, and the data was sampled using fixed-width sliding windows of 2.56 seconds with a 50% overlap (128 readings per window). The acceleration signal was separated into total acceleration and estimated body acceleration, while the angular velocity was captured from the gyroscope. Features were extracted from the time and frequency domains, resulting in a 561-feature vector for each data record.

The dataset includes information for each record such as triaxial acceleration from the accelerometer, triaxial angular velocity from the gyroscope, a 561-feature vector with time and frequency domain variables, activity labels, and identifiers for the subjects who carried out the experiments.

The project instructions, outlined in the README.md file, involve the following steps:

Merging the training and test sets to create a single dataset.
Extracting only the measurements related to the mean and standard deviation for each measurement.
Assigning descriptive activity names to label the activities in the dataset.
Appropriately labeling the dataset with descriptive variable names.
Creating a second independent tidy data set that calculates the average of each variable for each activity and subject.
For detailed implementation of these steps, please refer to the README.md file.
