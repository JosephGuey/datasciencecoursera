#About the data  
##Raw data
The dataset used in this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained:   
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  
The dataset includes the following files:
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

Our purpose is:
  1. Merges the training and the test sets to create one data set.  
  - Extracts only the measurements on the mean and standard deviation for each measurement. 
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names. 
  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  
##Tiny data  
There are 68 variables in the tiny data. 
* subject : identifies the subject who performed the activity to be measured. Its range is from 1 to 30. 
* activity : the six activities performed by the subject
	* WALKING
	* WALKING_UPSTAIRS
	* WALKING_DOWNSTAIRS
	* ITTING
	* STANDING
	* LAYING
* other variables represent average of the mean(with 'mean' in their names) or standard deviation(with 'std' in their names) for each measurement.

#Processes of Transformation
There is a run_analysis.R file with a run_analysis() function to do the processes.
* First it reads feature names from "features.txt" and activity names from "activity_labels.txt". These names will be used to make the data more readable as described as step 3 and 4 above.  
* Then it reads test data in "test" directory. There are 3 files to be read, "subject_test.txt" include only one column represent the subject of each test in the experiments, "y_test.txt" include one column represent the activity id of each test, "X_test.txt" include the test data of each test with 561 columns each represent a measure.  
* Then it bind these data together and select only subject, activity labels and needed measures - measures having a name with "mean()" or "std()" in it. There are some measures like "angle(X,gravityMean)" which are not a mean of any measures but a measure about mean of one measure, so they have to be exclude. 
* Then it does the same things to training data in "train" directory. And put the results together.  
* After that steps 1 to 4 are done. The last thing it does is calculating the average of each measure for each activity and each subject to get a tiny dataset and output it to a text file named "output.tx".