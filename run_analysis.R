#reading all data in
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#renaming columns
names(x_test) <- features[,2]
names(x_train) <- features[,2]
y_test <- rename(y_test, activity = V1)
y_train <- rename(y_train, activity = V1)
subject_test <- rename(subject_test, subject = V1)
subject_train <- rename(subject_train, subject = V1)

#removing columns with duplicate name for easing later selection
x_test <- x_test[, !duplicated(colnames(x_test))]
x_train <- x_train[, !duplicated(colnames(x_train))]

#select only columns containing -mean() or -std()
selected_test <- select(x_test, contains("-mean()"), contains("-std()"))
selected_train <- select(x_train, contains("-mean()"), contains("-std()"))

#changing number code of activity_label to meaningful name
y_test[,"activity"]<-labels[y_test[,"activity"],2]
y_train[,"activity"]<-labels[y_train[,"activity"],2]

#merging data into one tidy dataset containing only the requested columns
combined_test <- cbind(subject_test, y_test, selected_test)
combined_train <- cbind(subject_train, y_train, selected_train)
data <- rbind(combined_test, combined_train)

#creating a new data set with averages for every subject-activity combination
avgs <- ddply(data, c("subject", "activity"), summarise_each,funs(mean))

#changing number code of activity_label to meaningful name again, 
#summarising somehow converted the names back
avgs[,"activity"]<-labels[avgs[,"activity"],2]

#writing final tidy dataset to output file
write.table(avgs, file = "averages.txt", row.names = FALSE)
