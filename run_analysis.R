#Load feature.txt in /UCI HAR Dataset/ folder for column names
#Make sure using correct working directory (./UCI HAR Dataset/) with features.txt in it
feature <- read.table("./UCI HAR Dataset/features.txt", sep = "", stringsAsFactors = FALSE)

#Load training data from /UCI HAR Dataset/train/ folder
#Make sure using correct working directory (./UCI HAR Dataset/train/) with "X_train.txt", "y_train.txt", and "subject_train.txt" in it
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", stringsAsFactors = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = "", stringsAsFactors = FALSE)
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "", stringsAsFactors = FALSE)

#Load testing data from UCI HAR Dataset/test/ folder
#Make sure using correct working directory (./UCI HAR Dataset/test/) with "X_test.txt", "y_test.txt", and "subject_test.txt" in it
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "", stringsAsFactors = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = "", stringsAsFactors = FALSE)
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "", stringsAsFactors = FALSE)

#create y-label based on the six activities
y_index <- rbind(y_train, y_test)
colnames(y_index) <- "activity"
y_index$activity[y_index$activity == 1] <- "WALKING"
y_index$activity[y_index$activity == 2] <- "WALKING_UPSTAIRS"
y_index$activity[y_index$activity == 3] <- "WALKING_DOWNSTAIRS"
y_index$activity[y_index$activity == 4] <- "SITTING"
y_index$activity[y_index$activity == 5] <- "STANDING"
y_index$activity[y_index$activity == 6] <- "LAYING"


#Merges the training and the test sets to create one data set (Step 1) 
merge_file <- rbind(x_train, x_test)
colnames(merge_file) <- feature[,2]

#Extracts only the measurements on the mean and standard deviation for each measurement (Step 2)
mean_subset <- merge_file[grep("mean",names(merge_file),value=TRUE)]
std_subset <- merge_file[grep("std",names(merge_file),value=TRUE)]

#Uses descriptive activity names to name the activities in the data set (Step 3)
#Appropriately labels the data set with descriptive variable names (Step 4)
combine_data <- cbind(y_index, mean_subset, std_subset)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject (Step 5)
mean_group <- aggregate(combine_data[, 2:80], list(combine_data$activity), mean)
names(mean_group)[1] <- "Activity"

#for creating txt file
#write.table(mean_group, file = "mean_group.txt", sep = "\t", row.name=FALSE) 

#for testing whether the second data is clean expressed
#test <- read.table("mean_group.txt", sep = "", stringsAsFactors = FALSE, header = TRUE)
