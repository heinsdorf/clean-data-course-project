# Raw Data
- Zip file URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
- Zip file name = "samsung_data.zip"

The following files were used to obtain the results for this project. 
All of these files reside in the "UCI HAR Dataset" directory that is
exported from the zip file.

The X, y, and subject text files all have the same number of rows. These are meant to be used as one table.
The matching train and test data files are identical in structure, so they can be concatenated together.
- 'features.txt': List of all 561 features. This contains the column names for the X_....txt files.
- 'activity_labels.txt': This gives activity names for the 6 factors in the activity column.
- 'train/X_train.txt': Training set. 561 columns of measurements
- 'train/y_train.txt': Training activity for the measurements.
- 'test/X_test.txt': Test set. Similar to train/X_train.txt.
- 'test/y_test.txt': Test activity. Similar to train/y_train.txt.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.

# Columns of the result_dt2 datatable
For each subject and each of the 6 activities, the means of each of the measurements taken for that subject+activity combination.

## measurements (columns 3 - 66) datatype: float
The abbreviations that comprise each column name tell the meaning of the data in that column: 
* time - this is a time-domain measurement; freq = this is a frequency-domain measurement (Hz)
* Body - a measurement of the person's body movement; Gravity - a measurement of the Earth's gravity
* Acc, Jerk, Gyro - acceleration, jerk, or gyroscopic angle - all in device units, normalized to the range [-1 : +1]
* X, Y, Z, Mag - 3D coordinate projections, or Magnitude
* Mean, Std - mean or standard deviation

# Complete listing of the columns

Column  Name
* 1. Subject = The person who was wearing the device while doing the activity. Identified only by integer ID, 1-30.
* 2. Activity = 6-way factor = WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* 3. timeBodyAccXMean - float, in range [-1 : +1]; See the abbreviation meanings above. Likewise for all measurements.
* 4. timeBodyAccYMean
* 5. timeBodyAccZMean
* 6. timeBodyAccXStd
* 7. timeBodyAccYStd
* 8. timeBodyAccZStd
* 9. timeGravityAccXMean
* 10. timeGravityAccYMean
* 11. timeGravityAccZMean
* 12. timeGravityAccXStd
* 13. timeGravityAccYStd
* 14. timeGravityAccZStd
* 15. timeBodyAccJerkXMean
* 16. timeBodyAccJerkYMean
* 17. timeBodyAccJerkZMean
* 18. timeBodyAccJerkXStd
* 19. timeBodyAccJerkYStd
* 20. timeBodyAccJerkZStd
* 21. timeBodyGyroXMean
* 22. timeBodyGyroYMean
* 23. timeBodyGyroZMean
* 24. timeBodyGyroXStd
* 25. timeBodyGyroYStd
* 26. timeBodyGyroZStd
* 27. timeBodyGyroJerkXMean
* 28. timeBodyGyroJerkYMean
* 29. timeBodyGyroJerkZMean
* 30. timeBodyGyroJerkXStd
* 31. timeBodyGyroJerkYStd
* 32. timeBodyGyroJerkZStd
* 33. timeBodyAccMagMean
* 34. timeBodyAccMagStd
* 35. timeGravityAccMagMean
* 36. timeGravityAccMagStd
* 37. timeBodyAccJerkMagMean
* 38. timeBodyAccJerkMagStd
* 39. timeBodyGyroMagMean
* 40. timeBodyGyroMagStd
* 41. timeBodyGyroJerkMagMean
* 42. timeBodyGyroJerkMagStd
* 43. freqBodyAccXMean
* 44. freqBodyAccYMean
* 45. freqBodyAccZMean
* 46. freqBodyAccXStd
* 47. freqBodyAccYStd
* 48. freqBodyAccZStd
* 49. freqBodyAccJerkXMean
* 50. freqBodyAccJerkYMean
* 51. freqBodyAccJerkZMean
* 52. freqBodyAccJerkXStd
* 53. freqBodyAccJerkYStd
* 54. freqBodyAccJerkZStd
* 55. freqBodyGyroXMean
* 56. freqBodyGyroYMean
* 57. freqBodyGyroZMean
* 58. freqBodyGyroXStd
* 59. freqBodyGyroYStd
* 60. freqBodyGyroZStd
* 61. freqBodyAccMagMean
* 62. freqBodyAccMagStd
* 63. freqBodyBodyAccJerkMagMean
* 64. freqBodyBodyAccJerkMagStd
* 65. freqBodyBodyGyroMagMean
* 66. freqBodyBodyGyroMagStd
* 67. freqBodyBodyGyroJerkMagMean
* 68. freqBodyBodyGyroJerkMagStd

# How the raw data was transformed to get the result_dt and result_dt2 tidy data tables
- Read in the column names.
- Select only those columns that are needed (the ones with mean or std in their names).
- Using regular expressions, clean up the measurement column names by removing parentheses, 
changing the "t" and "f" prefix to "time" and "freq", removing punctuation characters, 
capitalizing, and moving the coordinates X, Y, or Z before the Mean or Std.

For example, "tBodyAccMag-mean()" becomes "timeBodyAccMagMean"
and "tBodyAccJerk-mean()-X" becomes "timeBodyAccJerkXMean".

As the test and train files were read in, a special function combined them by appending one to the other,
yielding the three datatables subject_dt, y_dt, and X_dt.

All these data text files were combined to create the result_dt datatable.

From this datatable, the mean of the data grouped by subject and activity 
"result_dt2" was easily calculated with one statement using the aggregate function.


