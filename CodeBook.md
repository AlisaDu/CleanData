---
title: "CodeBook"
author: "me"
date: "11/5/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```


## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


1st step. Merging data sets to create one dataset
1. Combine three datasets within training and test folders to get only 1 dataset per folder
    read files into variables with read.table
    cbind data frames into one data frame
2. Combine train and test datasets into one with rbind

3.To give dataset the descriptive vatiable names extract column names into vector from file features.txt. 
Additionally append two labels to the left "subject"" and "activity"
    assign this vector as column names to data frame
    to ensure clean names use janitor library method clean_names() method.
  
  4. To  Extract only the measurements on the mean and standard deviation for 
   each measurement I am using regex match wit grep. ubset includes:
   columns Subject and activity and all columns that match either "-mean()" or "-std()" literals in their column names


3. using dplyr package Converts output from previous step to tbl class  

4. to replace the activity indices with descriptive names load a lookup table from "activity_labels".txt
    mutate the table to replace activity names with respective character string from the lookup table.

