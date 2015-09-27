#Establish path of files
path <- "C:/Users/CHUN-JEN/Desktop/UCI HAR Dataset/"
path_train <- "C:/Users/CHUN-JEN/Desktop/UCI HAR Dataset/train/"
path_test <- "C:/Users/CHUN-JEN/Desktop/UCI HAR Dataset/test/"


#Load feature for column names
setwd(path)
feature <- read.table("features.txt", sep = "", stringsAsFactors = FALSE)

#Load training data
setwd(path_train)
x_train <- read.table("X_train.txt", sep = "", stringsAsFactors = FALSE)
y_train <- read.table("y_train.txt", sep = "", stringsAsFactors = FALSE)
sub_train <- read.table("subject_train.txt", sep = "", stringsAsFactors = FALSE)

#Load testing data
setwd(path_test)
x_test <- read.table("X_test.txt", sep = "", stringsAsFactors = FALSE)
y_test <- read.table("y_test.txt", sep = "", stringsAsFactors = FALSE)
sub_test <- read.table("subject_test.txt", sep = "", stringsAsFactors = FALSE)

#create y-label
y_index <- rbind(y_train, y_test)
colnames(y_index) <- "activity"
y_index$activity[y_index$activity == 1] <- "WALKING"
y_index$activity[y_index$activity == 2] <- "WALKING_UPSTAIRS"
y_index$activity[y_index$activity == 3] <- "WALKING_DOWNSTAIRS"
y_index$activity[y_index$activity == 4] <- "SITTING"
y_index$activity[y_index$activity == 5] <- "STANDING"
y_index$activity[y_index$activity == 6] <- "LAYING"


#Merge training and testing set
merge_file <- rbind(x_train, x_test)
colnames(merge_file) <- feature[,2]

#subset mean and std data
mean_subset <- merge_file[grep("mean",names(merge_file),value=TRUE)]
std_subset <- merge_file[grep("std",names(merge_file),value=TRUE)]

#combine index, mean, and std data in one file
combine_data <- cbind(y_index, mean_subset, std_subset)

#Calculate average of each variable for each activity
mean_group <- aggregate(combine_data[, 2:80], list(combine_data$activity), mean)
names(mean_group)[1] <- "Activity"
