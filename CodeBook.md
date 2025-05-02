# **Code Book: Description of Coursera - Getting and Cleaning Data project on sourcing and tidying a data set using the R script.**

## **Purpose**
The purpose of the project is to describe the sourced data, assigned variables to read the data, any transformations to clean up generate a tidy data set using R script.

## **Original Data and sourcing**

Original data used in the project is sourced from [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

Complete description of the dataset is available at [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones). Briefly, the database is built using recordings of activities of daily living by 30 subjects. Examples of the activities include walking, walking upstairs, walking downstairs, sitting, standing, laying. The recordings were collected in a smartphone worn by the subjects using its embedded accelerometer and gyroscope. About 70% subjects were used for generating training dataset and 30% for the test data set.  

## **R script**

The original data is sourced and transformed into a tidy data set as described in the file "run_analysis.R" which performs the following functions.

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

The script is divided into preparation (P1 to P5) to assign variables to and Steps 1-5 performing the above tasks. 

## **Variables used to read data from original files**
- 'x_train', 'y_train', 'subject_train', 'x_test', 'y_test', 'subject_test' to read original data from the downloaded files. 
- 'X' and 'Y' merge the above datasets into their respective train and test groups.
- 'activityLabels' and 'features' is the kind of activities performed and the list of measurements recorded during each activity.

