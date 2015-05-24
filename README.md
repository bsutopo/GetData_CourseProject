# Getting and Cleaning Data - Course Project

-----

## Running the Script

This file explains how the script **run_analysis.R** works.

  * Open up RStudio
  * Set working directory to the source file location
  * Run the script by typing the command **source("run_analysis.R")** in RStudio
  * The script will automatically download a zip file from the [course website](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), unzip the file and process the raw data.

## Handling the Output

The following output file will be generated in the current working directory:

  * **tidyDataSet.txt**
    * Size = 224 Kb
    * Dim = 180 x 68

To read and view the output data, use the following command in RStudio:

  * **data <- read.table("tidyDataSet.txt", header = TRUE)**
  * **view(data)**
