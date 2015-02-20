# Please refer to the readme for details on the training and test data sets
# The run_analysis.R combines the training and test data sets, 
# extracts the mean and standard deviation columns into a new data frame.
# From this data frame, a tidy data set is generated which contains the average of each variable for each activity and each
# subject


# Reads all the files associated with the training data set and generate a combined data frame
# Reads the training set, training labels and the subjects who performed the activity
x_train <- read.table("./X_train.txt")
y_train <- read.table("./y_train.txt")

# Rename the column with a meaningful name
names(y_train) <- "activity"

# Add the training labels to the data frame
x_train <- cbind(x_train, y_train)

sub_train <- read.table("./subject_train.txt")

# Rename the column with a meaningful name  
names(sub_train) <- "subject"

# Add the subjects to the data frame generating the complete training data set 
x_train <- cbind(x_train, sub_train)

# Reads all the files associate with the test data set and generate a combined data frame
# Reads the test set, test labels and the subjects who performed the activity
x_test <- read.table("./X_test.txt")
y_test <- read.table("./y_test.txt")

# Rename the column with a meaningful name
names(y_test) <- "activity"

# Add the test labels to the data frame
x_test <- cbind(x_test, y_test)
sub_test <- read.table("./subject_test.txt")

# Rename the column with a meaningful name
names(sub_test) <- "subject"

# Add the test subjects to the data frame generating the complete test data set 
x_test <- cbind(x_test, sub_test)

# Combine the data from the complete training data set and test data sets
combined_data <- rbind(x_train, x_test)

# This section replaces the column names of the combined data set with meaningful names from features file
features <- read.table("./features.txt")

# Since the last 2 columns have the activity labels and the subjects only the columns from the training and test sets
# are renamed
n <- integer
for (n in 1:(ncol(combined_data)-2)){
 colnames(combined_data)[n] <- as.character(features[n,2])
}

# This extracts only measurements on the mean and standard deviation for each measurement along with the activity labels
# and subjects
filtered_data <- combined_data[grep ('(.*)[Mm]ean|std|activity|subject(.*)',colnames(combined_data))]

# This replaces the activity labels with the activity names
i <- integer
for (i in 1:nrow(filtered_data)){
 if (filtered_data$activity[i]=="1")
 {
 filtered_data$activity[i] <- "WALKING"
 }
 else if (filtered_data$activity[i]=="2")
 {
 filtered_data$activity[i] <- "WALKING_UPSTAIRS"
 }
 else if (filtered_data$activity[i]=="3")
 {
 filtered_data$activity[i] <- "WALKING_DOWNSTAIRS"
 }
 else if (filtered_data$activity[i]=="4")
 {
 filtered_data$activity[i] <- "SITTING"
 }
 else if (filtered_data$activity[i]=="5")
 {
 filtered_data$activity[i] <- "STANDING"
 }
 else if (filtered_data$activity[i]=="6")
 {
 filtered_data$activity[i] <- "LAYING"
 }
}

# This groups the data set by activty and subject and generates the mean for all the variable columns
final_data <- ddply(filtered_data,.(activity,subject),colwise(mean,na.rm = TRUE))

# Finally the tidy data set is written to a text file 
write.table(final_data, "project_final_dataset.txt", row.name=FALSE)
