# load required libraries
library(dplyr)
library(janitor)

#  1. Merge the training and the test sets to create one data set.

train.folder = "./UCI HAR Dataset/train/"
test.folder = "./UCI HAR Dataset/test/"
train.subject <-read.table(paste(train.folder, "subject_train.txt", sep = "" ), 
                         header = FALSE)
test.subject <-read.table(paste(test.folder, "subject_test.txt" , sep = "" ), 
                         header = FALSE)
train.x <-read.table(paste(train.folder, "X_train.txt" , sep = "" ), 
                         header = FALSE)
test.x <-read.table(paste(test.folder, "X_test.txt" , sep = "" ), 
                        header = FALSE)
train.y <-read.table(paste(train.folder, "Y_train.txt" , sep = "" ), 
                   header = FALSE)
test.y <-read.table(paste(test.folder, "Y_test.txt" , sep = "" ), 
                  header = FALSE)

train <- cbind(train.subject, train.y, train.x)
test <- cbind(test.subject, test.y, test.x )
df <- rbind(train, test)


# 4. Appropriately label the data set with descriptive variable names.
# load variable names from a lookup file features.txt 
# and assign as column names to df
features  <- read.table("./UCI HAR Dataset/features.txt",header = FALSE)

colnames <- unlist(c("subject", 
                     "activity",
                     features[,2]
                    ))

colnames(df) <- colnames

# clean column names using a method from janitor library
clean_names(df)

#  2. Extract only the measurements on the mean and standard deviation for 
#     each measurement.
dataset <- df[,c(1,
                 2,
                grep("-mean()", colnames(df)), 
                grep("-std()", colnames(df))
                )
              ]

# convert to tbl class
 dt <- tbl_df(dataset)


# 3. Use descriptive activity names to name the activities in the data set
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",
                          header = FALSE)
 
# replace indices with descriptive names
dt<- mutate(dt, activity = activities[activity,2])
 

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

result <- dt %>% 
    group_by(activity, subject) %>% 
    summarize_if(is.numeric,mean, na.rm = TRUE)

View(result)