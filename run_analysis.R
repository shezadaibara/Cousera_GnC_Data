library("dplyr")

download_unzip_data <- function() {
  ## Download and unzip the dataset:
  filename <- "dataset.zip"
  if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
  }  
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
  }
}

#step1
merge_x_data <- function(){
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  # create 'x' data set
  x_data <- rbind(x_train, x_test)
  tbl_df(x_data)
}
merge_y_data <- function(){
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  # create 'y' data set
  y_data <- rbind(y_train, y_test)
  tbl_df(y_data)
}
merge_subject_data <- function(){
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  # create 'subject' data set
  subject_data <- rbind(subject_train, subject_test)
  # appropriate nameing of subject data
  names(subject_data) <- "subject"
  
  tbl_df(subject_data)
}

create_labelled_x_data_subset <- function(x_data){
  features <- tbl_df(read.table("UCI HAR Dataset/features.txt"))
  # filter mean and std features from complete set of filters
  mean_std_features <- filter(features, grepl("-(mean|std)\\(\\)", V2))
  # subsetting x bases on mean_std_features using select function  
  x_data_subset <- select(x_data, mean_std_features$V1)
  
  # using the standard make.names() to remove special characters from descriptive dataname 
  names(x_data_subset) <- make.names(mean_std_features$V2) 
  x_data_subset
}

create_labelled_y_data <- function(y_data){
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  y_data=mutate(y_data, V1 = activities[V1, 2])
  names(y_data) <- "activity"
  y_data
}

get_average_data <- function(all_data){
  all_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
}

download_unzip_data()
x_data <- merge_x_data()
y_data <- merge_y_data()
subjects <- merge_subject_data()
x_data_subset <- create_labelled_x_data_subset(x_data)
y_data <- create_labelled_y_data(y_data)


#merging all the data
all_data <- cbind(x_data_subset, y_data, subjects)

# avg data creation and write to a file
avg_data <- get_average_data(all_data)

write.table(avg_data, "UCI HAR Dataset/averages_data.txt", row.name=FALSE)


