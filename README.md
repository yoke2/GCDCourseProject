README
========================================================

This document describes the contents of this repository. It will also provide
instructions on how to run the R script to transform the raw data set dictated
in the Course Project into a tidy dataset.

__References:__

1. Getting and Cleaning Data Course Project [Assignment Page](https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions).
   
# Contents
This section describes the contents of this repository.

Filename       | Description
-------------  | -------------
README.md      | This File
CODEBOOK.md    | Describes the variables within the tidied dataset
run_analysis.R | Analysis function of the raw data

# Setup
Before running the script, the following has to be setup:

1. The R Environment is installed.
2. Data has been [downloaded](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
3. Data has already been extracted to the default working directory of your R environment.
4. It is assumed that the directory structure and file names of the extracted files follows that of the origin ZIP file. The only exception is that the parent directory name has been renamed to "UCI_HAR_Dataset".

# Steps
To get the tidied data, please follow the following steps:

1\. Source the analysis function into R and run the function.

```r
source('<your default R working directory>/run_analysis.R'))
run_analysis()
```
2\. Once the function has completed running, you will see two output files - "tidied_data.csv" and "tidied_data.txt" - in your working directory. These files contain the same data and are presented in CSV and TXT formats.

3\. To read the files into R, please use the following functions:

```r
# Read text file
read.table("tidied_data.txt", header=TRUE)
# Read csv file
read.csv("tidied_data.csv", header=TRUE)
```