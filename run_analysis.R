# Preparation

# P1: Load required library package "dplyr"
library(dplyr)

# P2. Create working directory

if(!file.exists("./GetAndCleanData")) {
  dir.create("./GetAndCleanData")
}
  
# P3. Download and unzip the dataset from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./GetAndCleanData/projectdataset.zip")

unzip(zipfile = "./GetAndCleanData/projectdataset.zip", exdir = "./GetAndCleanData")

# P4. Read data in activity labels and Features files 

# Activity labels is a list of six different activity names
activityLabels <- read.table("./GetAndCleanData/UCI HAR Dataset/activity_labels.txt")
# Assign column names to activity labels
colnames(activityLabels) <- c("activityID", "activityType")

# Features is a list of measurements recorded during each activity
features <- read.table("./GetAndCleanData/UCI HAR Dataset/features.txt")

# P5. Read three pairs of data (X, y and subject) and assign colnames in the training and test datasets

x_train <- read.table("./GetAndCleanData/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./GetAndCleanData/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./GetAndCleanData/UCI HAR Dataset/train/subject_train.txt")

colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

x_test <- read.table("./GetAndCleanData/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./GetAndCleanData/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./GetAndCleanData/UCI HAR Dataset/test/subject_test.txt")

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

#----------------------------------------------------------------------------------------------------

# Step 1: Merge the training (X) and the test (Y) sets to create one data set
X <- cbind(y_train, subject_train, x_train)
Y <- cbind(y_test, subject_test, x_test)
MergedData <- rbind(X,Y)

# Step 2: Extract only the measurements on the mean and sd for each measurement
# Identify the columns with the text "mean" and "std" in the MergedData file
mean_Std <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", colnames(MergedData))

# Extract subset of columns containing mean and std from the above mean_Std data
subset1_MeanStd <- MergedData[, mean_Std]

# Step 3: Use descriptive activity names to name the activities in the data set
subset2_activityNames <- merge(subset1_MeanStd, activityLabels, by = "activityID", all.x = TRUE)

# Step 4: Label the data set with descriptive variable names
# Describe some of the acronyms such as t, f Acc etc., in the columns in Step2 output  
names(subset1_MeanStd) [2] = "actvity"
names(subset1_MeanStd) <- gsub("^t", "Time", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("^f", "Frequency", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("tbody", "TimeBody", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("Acc", "Accelerometer", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("Gyro", "Gyroscope", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("BodyBody", "Body", names(subset1_MeanStd))
names(subset1_MeanStd) <- gsub("Mag", "Magnitude", names(subset1_MeanStd))

# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
# Obtain the average of each variable for each activity
TidyDataSet <- subset2_activityNames %>% group_by(subjectID, activityID, activityType) %>% summarise_all(mean)
# Create independent TidyDataSet file
write.table(TidyDataSet, "TidyDataSet.txt", row.names = FALSE)




