# How the script works

run_analysis.R processes data collected from the accelerometers of the Samsung Galaxy S Smartphone, which are 
available from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The script
assumes the data has been downloaded and extracted in a directory named "UCI HAR Dataset". You should set the current
directory to the parent directory of the "UCI HAR Dataset" before running run_analysis.R.

Based on the accelerometer data, the run_analysis.R script:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
each activity and each subject and exports this tidy data set to a text file called "summarized_dataset.txt" in the
current directory.
