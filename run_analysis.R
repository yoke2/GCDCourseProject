run_analysis <- function() {
    
    ## Reads list of features and remove illegal characters
    ## Referenced from ?make.names in R documentation
    features <- read.table("UCI_HAR_Dataset/features.txt", colClasses = "character")
    features[,2] <- gsub("\\(|\\)","",features[,2])
    features[,2] <- gsub("-|,","_", features[,2])
    features[,2] <- tolower(features[,2])
    
    
    
    ## Read in set of test dataset and merge
    raw_subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
    colnames(raw_subject_test) <- "subject_id"
    
    raw_activity_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")
    colnames(raw_activity_test) <- "activity_id"
    
    raw_data_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
    colnames(raw_data_test) <- features[,2]
    
    merged_data_test <- cbind(raw_subject_test,raw_activity_test,raw_data_test)
    
    ## Extract only mean and standard deviation measurements in test dataset
    required_data_test <- merged_data_test[,c(1,2,grep("_mean_|_mean$|_std_|_std$", names(merged_data_test)))]
    
    
    
    ## Read in set of train dataset and merge
    raw_subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
    colnames(raw_subject_train) <- "subject_id"
    
    raw_activity_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")
    colnames(raw_activity_train) <- "activity_id"
    
    raw_data_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
    colnames(raw_data_train) <- features[,2]
    
    merged_data_train <- cbind(raw_subject_train,raw_activity_train,raw_data_train)
    
    ## Extract only mean and standard deviation measurements in train dataset
    required_data_train <- merged_data_train[,c(1,2,grep("_mean_|_mean$|_std_|_std$", names(merged_data_train)))]
    
    
    
    ## Combine test and train dataset
    required_data <- rbind(required_data_test,required_data_train)
    
    
    
    ## Read in activity labels
    activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt", colClasses = "character")
    colnames(activity_labels) <- c("activity_id", "activity_name")
    
    ## Merge activity labels and the data to get meaningful activity names
    required_data <- merge(activity_labels, required_data)
    required_data$activity_name <- tolower(required_data$activity_name)
    
    ## Remove duplicate activity_id column
    temp <- names(required_data) %in% c("activity_id")
    required_data <- required_data[!temp]
    
    
    
    ## Creates tidy data set with the average of each variable
    ## for each activity and each subject
    tidied_data <- aggregate(required_data[,3:ncol(required_data)], by=list(subject_id=required_data$subject_id,activity_name=required_data$activity_name), FUN=mean, na.rm=TRUE)
    
    ## Cosmetics: adding "average" to data columns and ordering
    for (i in 3:ncol(tidied_data)) {
        colnames(tidied_data)[i] = paste("average_",colnames(tidied_data)[i], sep = "")
        
    }
    
    tidied_data <- tidied_data[order(tidied_data$subject_id,tidied_data$activity_name),]
    
    
    ## Output tidied data into TXT and CSV formats
    write.csv(tidied_data, "tidied_data.csv", row.names=FALSE)
    write.table(tidied_data, "tidied_data.txt", row.names=FALSE)
    
}