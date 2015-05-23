library("dplyr")
run_analysis <- function (){
        
        # Read X_train.txt and X_test.txt and merge (rbind) them together as X_train_test (convention: train data will always go first) 
        X_train_test <- read.table("./UCI HAR Dataset/train/X_train.txt")
        X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        X_train_test <- rbind(X_train_test, X_test)
        rm("X_test")

        # Read y_train.txt and y_test.txt and merge (rbind) them together as y_train_test (convention: train data will always go first) 
        y_train_test <- read.table("./UCI HAR Dataset/train/y_train.txt")
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        y_train_test <- rbind(y_train_test, y_test)
        rm("y_test")

        # Read subject_train.txt and subject_test.txt and merge (rbind) them together as subject_train_test (convention: train data will always go first) 
        subject_train_test <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        subject_train_test <- rbind(subject_train_test, subject_test)
        rm("subject_test")

        # Read features.txt which is the column names for data in X_train_test
        features <- read.table("./UCI HAR Dataset/features.txt")

        # Read the activity_labels which will be used to provide appropriate labels for data in y_train_test
        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        
        # Names the columns of X_train_test using features data. It removes all punctuation from the names
        names(X_train_test) <- gsub("[[:punct:]]", "", features[,2])
        
        # Give the column name activity_id to y_train_test. In out tidy data set we will show both the activity_id and activity_name
        names(y_train_test) <- "activity_id"
        
        # Give the column name subject to subject_train_test
        names(subject_train_test) <- "subject"
        
        # Create activity_name which will contain same data as y_train_test but with descriptive names
        activity_name <- data.frame( activity_name = character())
        for (i in y_train_test) {
                name=activity_labels[i,2]
                row_df <- data.frame(activity_name = name)
                activity_name <- rbind(activity_name, row_df)
        }
        
        # Select the subset of columns from X_train_test that we will use (mean and std data). We exclude meanFreq Columns.
        m<-grep('mean', features$V2, ignore.case=F)
        mf<-grep('meanFreq', features$V2, ignore.case=F)
        s<-grep('std', features$V2, ignore.case=F)
        x_cols <- c(m,s)
        x_cols <- setdiff(x_cols, mf) ## Exclude all meanFreq Columns
        mean_std_col<-sort(x_cols)
        X_train_test <- X_train_test[,mean_std_col]
        
        # Merge (cbind) data that in the following order: subject, activity_id, activity_name, mean and std X_train_test data
        mean_std_dataset <- cbind(subject_train_test, y_train_test)
        mean_std_dataset <- cbind(mean_std_dataset, activity_name)
        mean_std_dataset <- cbind(mean_std_dataset, X_train_test)
        rm("X_train_test")
        
        # Use dplyr to group by subject and activity (in this case I used activity_id and activity_name) and submarise_each to calculate the means on every column
        grouped<-group_by(mean_std_dataset, subject, activity_id, activity_name) 
        df<- summarise_each(grouped, funs(mean))
        
        # write tidy data set to "tidy_mean_data.txt" 
        write.table(df, file="tidy_mean_data.txt" ,row.name=FALSE, sep=" ")
        
}

# after running run_analysis() following can be executed in R command line to red the tidy_mean_data.txt file
#data<- read.table("tidy_mean_data.txt", header=TRUE)
