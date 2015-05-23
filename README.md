# GCD_Project: Getting and Cleaning Data Course Project

Coursera - John Hopkins University: Getting and Cleaning Data
Student Name: Jose Carrasquero

There are two important files along with this one:

1. run_analysis.R: contains the function run_anaysis() which does the following:  
	* Reads X_train.txt and X_test.txt and merges (row binds) them together.
	* Reads y_train.txt and y_test.txt and merges (row binds) them together.
	* Reads subject_train.txt and subject_test.txt and merges (row binds) them together.
	* Reads features.txt which contains the column names of data in X_train.txt and X_test.txt.
	* Reads activity_labels which is used to provide appropriate descriptive labels for data in y_train and y_test.
	* Creates a one column data frame with the corresponding activity names of y_train and y_test.
	* Adds the appropriate column names (labels) to all the data. In the case of features all punctuation marks are removed from the names.
	* Subsets the X_train and X_test by only using the columns that have the mean and standard deviation (std) data. meanFreq columns are removed.
	* Merges (column binds) subject, activity (id and names) and X_train/X_test data as one data frame.
	* Creates a tidy data set (tidy_mean_data.txt) in the working directory with the average of each variable for each activity and each subject.
	Note: when run_analysis.R is sourced in R it will load dplyr package which is used in
	the function.
	
2. CodeBook.md: which describes the variables, the data, and any transformations or work 
performed to clean up the data.
	
IMPORTANT: It is required that the data for the course project (UCI HAR Dataset.zip) is unzipped and 
present in the working directory as a directory with the original name "UCI HAR Dataset" in
order for run_analysis() function to work properly and generate the tidy_mean_data.txt file.

	

