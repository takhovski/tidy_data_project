setwd("c:/Users/Shobeir/Desktop/data/assignment")
library(dplyr) # load dplyr library
########## Initial cleaning of the test set
test_main <- read.table(file="./test/X_test.txt") # Read the test data
test_subj <- read.table(file="./test/subject_test.txt") #test subject
test_activity <- read.table(file="./test/y_test.txt") # test activity
test_main <- tbl_df(test_main) 
test_subj <- tbl_df(test_subj)
test_activity <- tbl_df(test_activity)
### Define test and add the subjects and activities to the data_frame
test <- mutate(test_main,subject=as.numeric(test_subj$V1),activity = as.numeric(test_activity$V1))
### remove the temps and free up memory
rm(test_activity)
rm(test_main)
rm(test_subj)

################## Initial Cleaning of the Train set
train_main <- read.table(file="./train/X_train.txt") # Read the train data
train_subj <- read.table(file="./train/subject_train.txt") #train subject
train_activity <- read.table(file="./train/y_train.txt") # train activity
train_main <- tbl_df(train_main) 
train_subj <- tbl_df(train_subj)
train_activity <- tbl_df(train_activity)
### Define train and add the subjects and activities to the data_frame
train<- mutate(train_main,subject=as.numeric(train_subj$V1),activity = as.numeric(train_activity$V1))
### remove the temps and free up memory
rm(train_activity)
rm(train_main)
rm(train_subj)
### Bind the two data sets to form a final one named merged_data
merged_data <- rbind(test,train)
### remove the temps and free up memory
rm(test)
rm(train)
### Add Descriptive Variable Names to the columns
col_name <- read.table(file="./features.txt",as.is = TRUE)
col_name <- rbind(col_name,c(as.character(562),"subject"))
col_name<- rbind(col_name,c(as.character(563),"activity"))
names(merged_data) <- as.character(col_name$V2) #name all the columns
merged_data <- merged_data[,!duplicated(names(merged_data))]
### Add Descriptive names to the activities
merged_data$activity<-gsub(1,"WALKING",merged_data$activity)
merged_data$activity<-gsub(2,"WALKING_UPSTAIRS",merged_data$activity)
merged_data$activity<-gsub(3,"WALKING_DOWNSTAIRS",merged_data$activity)
merged_data$activity<-gsub(4,"SITTING",merged_data$activity)
merged_data$activity<-gsub(5,"STANDING",merged_data$activity)
merged_data$activity<-gsub(6,"LAYING",merged_data$activity)
### subsetting only the columns that contain "mean" or "std" + subject + activity
tidy_dataset <-select(merged_data,contains("mean()"), contains("std()"),contains("subject"),contains("activity"))
###  tidy data set with the average of each variable for each activity and each subject
melted = melt(tidy_dataset, id.var = c("subject", "activity"))
means = dcast(melted , subject + activity ~ variable, mean)
### Writing into a text file
write.table(means, file="tidy_data_project/tidy_data_means.txt")
