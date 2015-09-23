library(data.table)
library(dplyr)

# Load feature and label names into tables
features <- fread("UCI HAR Dataset/features.txt", sep=" ", header=FALSE, col.names=c("feature.num", "feature.name"));
labels <- fread("UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE, col.names=c("label.num", "label.name"));

# Load training and test data into tables
training.labels <- fread("UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("label"));
training.subjects <- fread("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("subject"));
training.dataset <- fread("UCI HAR Dataset/train/X_train.txt", sep=" ", header=FALSE, col.names=features[[2]]);
test.labels <- fread("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("label"));
test.subjects <- fread("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("subject"));
test.dataset <- fread("UCI HAR Dataset/test/X_test.txt", sep=" ", header=FALSE, col.names=features[[2]]);

# Extract only the measurements on the mean and standard deviation for each measurement
# Use descriptive activity names to name the activities in the data set
# Appropriately label the data set with descriptive variable names
training.dataset <- mutate(select(training.dataset, matches("mean\\(\\)|std\\(\\)")),
                          subject = select(training.subjects, subject),
                          label = labels$label.name[match(training.labels$label, labels$label.num)]);
test.dataset <- mutate(select(test.dataset, matches("mean\\(\\)|std\\(\\)")),
                      subject = select(test.subjects, subject),
                      label = labels$label.name[match(test.labels$label, labels$label.num)]);

# Merge the training and the test sets to create one data set
merged.dataset <- rbind(training.dataset, test.dataset);

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
merged.dataset.melt <- melt(merged.dataset, 
                            id=c("subject", "label"), 
                            measure.vars=setdiff(names(merged.dataset), c("subject", "label")));
summarized.dataset <- dcast(merged.dataset.melt, subject + label ~ variable, mean);

# Tidy up variable names some more
names(summarized.dataset) <- gsub("mean\\(\\)", "mean", names(summarized.dataset));
names(summarized.dataset) <- gsub("std\\(\\)", "std", names(summarized.dataset));

# Write the tidy dataset to a file
write.table(summarized.dataset, "summarized_dataset.txt", row.names=FALSE);