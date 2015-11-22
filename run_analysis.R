# Data Science - Getting Data - Course Project
# Clean the data to analyze fitness tracker. See full description at
# "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"

library(data.table)
library(dplyr)

# The source of the data is noted here only as a reference.
# The actual data should already be in the working directory.
source_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
source_zip <- "samsung_data.zip"

# Unzip the samsung_data.zip file in the working directory. 
# It creates the directory "local_data_directory", which must be located in the working directory.
# All the data files are in this directory.
local_data_directory <- paste("UCI HAR Dataset", "/", sep = "")

# The local_data_directory contains two subdirectories, "train" and "test".
# Each of these directories has 3 text files:
#   subject_....txt = the id of the person observed, as a factor
#   y_....txt = the id of the activity done during the observation, as a factor
#   X_....txt = the measurements observed, as a row of 561 floats, delimited by spaces
# For this project, the ROWs of the corresponding 
# train and test files must be concatenated together.

# Read in the activity labels.
filePath <- paste(local_data_directory, "activity_labels.txt", sep="")
raw_activity_labels_df <- read.csv(filePath, header=FALSE, sep=" ")
activity_labels <- raw_activity_labels_df$V2

# The labels for the columns of the "X" file are contained in the file "features.txt",
# which has two columns: the column number and the column name.
# Only the columns with "mean" and "std" are needed. 

# The following code cleans up the column names, e.g.:
#   "tBodyAccMag-mean()"    becomes "timeBodyAccMagMean"
#   "tBodyAccJerk-mean()-X" becomes "timeBodyAccJerkXMean"
# The cleaned column names are stored as the vector column_names.

# Read in the column names.
filePath <- paste(local_data_directory, "features.txt", sep="")
raw_column_names_df <- read.csv(filePath, header=FALSE, sep=" ")
column_names1 <- raw_column_names_df$V2

# Select only the columns that are needed.
selected_column_indexes <- grep("-(mean|std)\\(\\)", raw_column_names_df$V2)
column_names2 <- column_names1[selected_column_indexes]

# Remove parentheses from column names
column_names3 <- sub("\\(\\)", "", column_names2)

# Change the t and f prefixes to time and freq.
column_names4 <- sub("^t", "time", column_names3)
column_names5 <- sub("^f", "freq", column_names4)

# Remove remaining punctuation, capitalize, and move any X, Y, or Z inside.
column_names6 <- sub("-mean-?", "Mean", column_names5)
column_names7 <- sub("-std-?", "Std", column_names6)
column_names <- sub("(Mean|Std)(X|Y|Z)$", "\\2\\1", column_names7)

# Define a function to get all the data from one of the text files.
#  Input:  
#       datum.name  -- Required. "X", "y", or "subject"
#       stage       -- Required. "train" or "test"
#  Output: 
#       datatable of numeric values
#  Example:
#       file_as_df("X", "train") reads the file <local_data_directory>/train/X_train.txt
#
read_text_file_as_dt <- function(datum.name=NULL, stage=NULL) {
        filePath <- paste(local_data_directory, stage, "/",
                          datum.name, "_", stage, ".txt", sep="")
        df <- read.table(filePath, colClasses=numeric())
        dt <- data.table(df)
}

# Define a function to combine the training and test data from the flat files
# with the specified name and return it as a datatable.
#  Input:  
#       datum.name       Required. "X", "y", or "subject"
#  Output: 
#       datatable of numeric values
get_train_plus_test_as_dt <- function(datum.name) {
        dt1 <- read_text_file_as_dt(datum.name, "train")
        dt2 <- read_text_file_as_dt(datum.name, "test")
        dt <- rbind(dt1, dt2)
}

## Combine all the data text files into one result datatable...
X_dt1 <- get_train_plus_test_as_dt("X")
X_dt <- select(X_dt1, selected_column_indexes)
setnames(X_dt, column_names)

y_dt <- get_train_plus_test_as_dt("y")
setnames(y_dt, "activity")
y_dt$activity <- activity_labels[y_dt$activity]

subject_dt <- get_train_plus_test_as_dt("subject")
setnames(subject_dt, "subject")

# This combined datatable is the required result for Step 4.
result_dt <- data.table(subject_dt, y_dt, X_dt)
   
# Use the above result to get the result for Step 5.     
result_dt2 <- aggregate(select(result_dt, -subject, -activity), 
                        by = list(Subject = result_dt$subject, 
                                  Activity = result_dt$activity), 
                        mean)
# end of script
