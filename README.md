# clean-data-course-project
Course project for the Coursera "Getting and Cleaning Data" course.
# Description of the original data
This data set is based on the accelerometer and gyroscope readings from a Samsung device worn by a "subject" while doing several different kinds of "activities". The raw readings are taken 50 times per second, but these raw readings are not used. Instead, 561 measurements have been derived from the raw readings, and this is used as the raw data. Most of these measurements retain the same time period as the raw device readings, but others have been transformed into the frequency domain (measured in hertz).
# Additional data modifications required by the instructors
* The 561 measurements are whittled down to 66. Only those that measure mean or std are used.
* The original measurement names are prettified into a standard format. (CamelCase is used.)
* The rows from the observations have been divided into training stage and testing stage directories. This distinction isn't needed, so the rows of these separate files must be combined.

# Collection of the raw data
All the data is contained in the zip file "samsung_data.zip", which was downloaded from
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". 
This file must be unzipped into the working directory where run_analysis.R is executed.
It will create a directory called "UCI HAR Dataset" and export all the necessary data into it.
# Creating the tidy datafiles
* Download the zip file mentioned above.
* Unzip it into the R working directory.
* Run the script run_analysis.R, which is given in this repo.
* The results will be in the datatables result_dt and result_dt2, for steps 4 and 5, respectively, of the project instructions.

# Cleaning the data
* The result for Step 4 is a datatable that combines the columns of the "subject" (subject_....txt), "activity" (y_....txt), and "measurements" (X_....txt) datatables.
* The "train" and "test" parts of these files are concatenated together right after they are read.
* The "activity" file contains an integer factor which is translated to the text given in the "activity_labels.txt" file.
* Labels for the columns of the "measurements" file are found in the "features.txt" file. Regular expressions are used to limit these labels to those having "mean" or "std", and to mutate the labels to make them more readable.
* The subject, activity, and measurements datatables columns are concatenated, and renamed where needed, to form the result datatables.

# Description of result_dt2 (result of Step 5)
* 180 observations of 68 variables
* Columns: subject (integer 1-30), activity (6 factors), measurements (66 columns of floats)

## subject (1 column with integer factor 1-30)
The person who was wearing the device while doing the activity. Identified only by integer ID, 1-30.

## activity factor (1 column with 6-way factor)
WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

## measurements (66 columns of float)
The abbreviations that comprise each column name tell the meaning of the data in that column: 
* time - this is a time-domain measurement; freq = this is a frequency-domain measurement (Hz)
* Body - a measurement of the person's body movement; Gravity - a measurement of the Earth's gravity
* Acc, Jerk, Gyro - acceleration, jerk, or gyroscopic angle - all in device units normalized to the range [-1 : +1]
* X, Y, Z, Mag - 3D coordinate projections, or Magnitude
* Mean, Std - mean or standard deviation

