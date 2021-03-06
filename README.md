# GettingAndCleaningData
GettingAndCleaningData Final Project Assignment

The run_analysis.R - 
	- analyzes the sets files corresponding to training and test sets
	- manipulates them and combines them
	- extracts the variables related to mean and standard deviation
	- generates a tidy data set with the mean of all the variables for each activity and subject
	
The following steps were applied to the datasets -

Step 1: Combining the data files corresponding to the training data set

- Used the read.table function to read the 3 files: training set, training labels and subject train
- Used names function to rename the columns of the training labels to activity and subject train to subject for traceability
- Merged the files using the cbind function to generate a complete training data set

Step 2: Combining the data files corresponding to the test data set

- Used the read.table function to read the 3 files: test set, test labels and subject test
- Used names function rename the columns of the test labels to activity and subject test to subject for traceability
- Merged the files using the cbind function to generate a complete test data set

Step 3: Combining the training and test data sets

- Combined the final outputs of steps 1 and 2 x_train and x_test data frames using the rbind function 
- Stored this in a data frame called combined_data

Step 4: Replacing the columns of the combined_data data frame with readable names from the features.txt file

- Extracted the variable names into features using the read.table function
- Assigned each value from features sequentially to the column names of the combined_data data frame using a for loop
- Since the last 2 columns already correspond to activity and subject, these are excluded

Step 5: Extracting only measurements on the mean and standard deviation for each measurement

- Extracted only those measurements corresponding to mean and standard deviation from the combined_data data frame using the grep function 
- Stored this in the filtered_data data frame
- This data frame also includes activity and subject columns

Step 6: Renaming the activity codes with the labels

- For every row in the filetered_data data frame, the activity code is replaced with the activity labels. 
- This is done using a for loop

Step 7: Creating the tidy data set with the mean of all the variables for each activity and subject

- Used the ddply function to group the data based on activity and subject and summarized using mean function
- ddply function needs the plyr package

Step 8: Creating a txt file for the tidy data set

- Used the write.table function to generate the project_final_dataset.txt file

The dataset provided had the following files - 

- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
