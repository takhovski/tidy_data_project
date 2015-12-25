# CookBook

# Input

The script assumes the UCI dataset is extracted directly into `./data/`. See the [README.md](README.md) for further details.

# Output Data

The resulting `./data/tidy_data.txt` dataset includes mean and standard deviation variables for the following original variables,

tBodyAcc, tGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk, tBodyAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc, fBodyAccJerk, fBodyGyro, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroMag, fBodyBodyGyroJerkMag. All three X, Y, Z directions are included.

The above variables where chosen as they included either _mean_ or _std_ in their original names.

# Transformations

The script, `run_analysis.R`, does the following,

* Reads the test dataset and adds the subject and activity columns
* Reads the train dataset and adds the subject and activity columns
* Merges the `test` and `train` datasets into a single data table
* Adds Descriptive names and labels to the dataset
* Creates the second dataset that contains only mean and std variables
* Computes the means of this secondary dataset, group by subject+activity.
* Saves this last dataset into a file "tidy_data_mean.txt"