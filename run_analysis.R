library(data.table)
library(dplyr)

features <- fread("UCI HAR Dataset/features.txt", sep=" ", header=FALSE, col.names=c("feature.num", "feature.name"));
labels <- fread("UCI HAR Dataset/activity_labels.txt", sep=" ", header=FALSE, col.names=c("label.num", "label.name"));

training.labels <- fread("UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("label"));
training.subjects <- fread("UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("subject"));
training.dataset <- fread("UCI HAR Dataset/train/X_train.txt", sep=" ", header=FALSE, col.names=features[[2]]);
training.dataset <- mutate(training.dataset,
  subject = select(training.subjects, subject),
  label = labels$label.name[match(training.labels$label, labels$label.num)]);

test.labels <- fread("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("label"));
test.subjects <- fread("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("subject"));
test.dataset <- fread("UCI HAR Dataset/test/X_test.txt", sep=" ", header=FALSE, col.names=features[[2]]);
test.dataset <- mutate(test.dataset,
  subject = select(test.subjects, subject),
  label = labels$label.name[match(test.labels$label, labels$label.num)]);