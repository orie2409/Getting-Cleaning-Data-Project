# Getting-Cleaning-Data-Project
Coursera - Getting & Cleaning Data - Week 3 Project

The original data consisted of 10299 observations collected from the accelerometers from the Samsung Galaxy S smartphone.
This data was observed from 30 different participants performing 6 differnet activities, and the data was split into a training
dataset and a test datatset.

The aim of the project is to produce a tidy dataset with one observation for each combination of participant and activity,
taking the averages of observation within each 'bucket'.

Below I outline the steps taken to achieve this:

1) Read in all relevant datasets
2) Merge the train and test datasets together and add column headings 
3) Merge the train and test datasets for subjects and activities together, join activity labels and add to main dataset from 1) 
4) Keep variables that measure the mean and standard deviation for each measurement
5) Use dplyr package to summarise by Subject and Activity
