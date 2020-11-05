---
title: "CodeBook"
author: "me"
date: "11/5/2020"
output: html_document
---


## Code book for CleanData Project analysis

### Prerequisites and the result

**Input:** 
input data is obtained from 
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
The zip archive must be unpacked to the working directorty along with the run_analysis.R script
THe detailed data ser description is available 
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

**Output:** 
run_analysis.R script provides the visual output as a dwo-dimensional
table in spreadsheet-style data viewer

**R-packages:**
the packages `dplyr` and `janitor` are required to run this script

### Data manipulation steps

1. Reading into R and merging data sets
**Goal:**  To combine multiple data sets within initial data
..1.1 Read all data sets to separate data frame objects with `read.table`
..1.2 using `cbind()`combine three data frames within *training* and *test* folders respectively to get only one data frame per folder
..1.3 using `rbind()` bind two data frames (output from 1.2) into a single data frame
**Output:** a single data frame containing all observations     
      

2.Assigning column names
**Goal:** To give data set the descriptive variable names for each column.
..2.1 Extract column names into vector from file "features".txt". 
....2.1.1 Additionally append two labels to the left "subject"" and "activity"
..2.2 Assign the output vector from 2.1.1 as column names to data frame with a`colnames()` method
..2.3 To ensure clean names use `janitor` package `clean_names()` method.
**Output:** Same as step 1 with descriptive column names

3. Subsetting data set
**Goal: ** To extract only the measurements on the *mean* and *standard deviation* for each measurement 
..3.1 Using regex match wit `grep` extract following columns by name:
....- subject 
....- activity
....- all columns that match "-mean()" in column names
....- all columns that match "-std()" in column names
**Output:** subset of initial data set containing only columns macthing the conditions in 3.1

4. Using `dplyr` package convert output from previous step to tbl class for further analysis  
**Output:** tbl class object 

5. Replace the activity indices with descriptive names
**Goal:** provide clear meaning to the observation values 
..5.1 Load a lookup table from file "activity_labels".txt
...5.2 mutate the output table from 4.to replace activity numerical values with respective character string from the lookup table 5.1.

6. From the step 5 output, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
**Goal:** provide the aggregated table with the results of the analysis.
..6.1 using `dplyr` package group the input data table by activity and then by subject
..6.2 summarize all numeric columns with function mean, disregarding all NA values
..6.3 store the output into the variable "result"

7. Output result to screen using `View()`
