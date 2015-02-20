#Reads all the files associate with the training data set
x_train <- read.table("./X_train.txt")
y_train <- read.table("./y_train.txt")
names(y_train) <- "activity"
x_train <- cbind(x_train, y_train)
sub_train <- read.table("./subject_train.txt")
names(sub_train) <- "subject"
x_train <- cbind(x_train, sub_train)

#Reads all the files associate with the test data set
x_test <- read.table("./X_test.txt")
y_test <- read.table("./y_test.txt")
names(y_test) <- "activity"
x_test <- cbind(x_test, y_test)
sub_test <- read.table("./subject_test.txt")
names(sub_test) <- "subject"
x_test <- cbind(x_test, sub_test)

combined_data <- rbind(x_train, x_test)

features <- read.table("./features.txt")

n <- integer
for (n in 1:(ncol(combined_data)-2)){
 colnames(combined_data)[n] <- as.character(features[n,2])
}

filtered_data <- combined_data[grep ('(.*)[Mm]ean|std|activity|subject(.*)',colnames(combined_data))]

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

final_data <- ddply(filtered_data,.(activity,subject),colwise(mean,na.rm = TRUE))

write.table(final_data, "project_final_dataset.txt", row.name=FALSE)