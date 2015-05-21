library("dplyr")
run_analysis <- function (){
        
        # 
        X_train_test <- read.table("./UCI HAR Dataset/train/X_train.txt")
        X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        X_train_test <- rbind(X_train_test, X_test)
        rm("X_test")

        
        y_train_test <- read.table("./UCI HAR Dataset/train/y_train.txt")
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        y_train_test <- rbind(y_train_test, y_test)
        rm("y_test")

        
        subject_train_test <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        subject_train_test <- rbind(subject_train_test, subject_test)
        rm("subject_test")

        
        features <- read.table("./UCI HAR Dataset/features.txt")

        
        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        
        
        names(X_train_test) <- gsub("[[:punct:]]", "", features[,2])
        names(y_train_test) <- "activity_id"
        names(subject_train_test) <- "subject"
        
        activity_name <- data.frame( activity_name = character())
        for (i in y_train_test) {
                name=activity_labels[i,2]
                row_df <- data.frame(activity_name = name)
                activity_name <- rbind(activity_name, row_df)
        }
        
        m<-grep('mean', features$V2, ignore.case=F)
        mf<-grep('meanFreq', features$V2, ignore.case=F)
        s<-grep('std', features$V2, ignore.case=F)
        x_cols <- c(m,s)
        x_cols <- setdiff(x_cols, mf) ## Exclude all meanFreq Columns
        mean_std_col<-sort(x_cols)
        X_train_test <- X_train_test[,mean_std_col]
        
        
        mean_std_dataset <- cbind(subject_train_test, y_train_test)
        mean_std_dataset <- cbind(mean_std_dataset, activity_name)
        mean_std_dataset <- cbind(mean_std_dataset, X_train_test)
        rm("X_train_test")
        
        #return(mean_std_dataset) Part 4
        grouped<-group_by(mean_std_dataset, subject, activity_id, activity_name) 
        df<- summarise_each(grouped, funs(mean))
        write.table(df, file="mean_data.txt" ,row.name=FALSE, sep=" ")
        #return(df)
        
        
}


# part 5:
#         X <- run_analysis_v2()
#         grouped<-group_by(X2, subject, activity_id, activity_name)       
#         df<- summarise_each(grouped, funs(mean))
#         write.table(df, file="project4.txt" ,row.name=FALSE, sep=",")
#         Column names for codebook: as.data.frame(names(df))
# 1. Tidy Data Set
# 2. Link to Github with this script
# 3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
# 4. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  