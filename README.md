#What this project do  
One of the most exciting areas in all of data science right now is wearable computing - see for example this [article ](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.   
This project will demonstrate how to collect, work with, and clean a data set by using the data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained:   
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#How this project do  
The R code file run_analysis.R is used to fulfil the purpose.   
In the run_analysis.R there are two functions, getdata() and run_analysis().  
  
getdata() is used to download the data needed for the analysis from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
and then unzip the data to a specific directory "getdataproj" and make the directory to be current working directory.

run_analysis() is used to read data from working directory to do processes below:  
  1. Merges the training and the test sets to create one data set.  
  - Extracts only the measurements on the mean and standard deviation for each measurement. 
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names. 
  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  
   It's assumed the data files needed are ready in the working directory. Otherwise, getdata() should be called first to get it ready.

run_analysis() does its job through serveral steps:  
* First it reads feature names from "features.txt" and activity names from "activity_labels.txt". These names will be used to make the data more readable as described as step 3 and 4 above.  
* Then it reads test data in "test" directory. There are 3 files to be read, "subject_test.txt" include only one column represent the subject of each test in the experiments, "y_test.txt" include one column represent the activity id of each test, "X_test.txt" include the test data of each test with 561 columns each represent a measure.  
* Then it bind these data together and select only subject, activity labels and needed measures - measures having a name with "mean()" or "std()" in it.  
* Then it does the same things to training data in "train" directory. And put the results of the two steps together.  
* After that steps 1 to 4 are done. The last thing it does is calculating the average of each measure for each activity and each subject to get a tiny dataset and output it to a text file named "output.tx".