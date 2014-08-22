#Download the data needed for the analysis from Internet and unzip the data to a specific directory
#then set work directory into the directory containing the data.
getdata<-function(){
        if(!file.exists("getdataproj")) dir.create("getdataproj")
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data.zip", mode="wb")
        unzip("getdataproj\\data.zip")
        setwd("getdataproj\\UCI HAR Dataset")
}

#run_analysis is used to read data from working directory to do cleanup steps below:
#  Merges the training and the test sets to create one data set.
#  Extracts only the measurements on the mean and standard deviation for each measurement. 
#  Uses descriptive activity names to name the activities in the data set
#  Appropriately labels the data set with descriptive variable names. 
#  Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#It's assumed the data files needed are ready in the working directory. 
#If not, please call getdata() to get it ready.
run_analysis <- function() {

        library(stringr) #get access of function str_detect
        
        #Read the features which contains names of measures in the second column.
        featurenames<-read.table("features.txt", col.names=c("label", "feature"), as.is=TRUE)
        #Read the activities which contains activity label in the first column and activity names
        #in the second column. It will be used to tranform activity labels to names later.
        activities <- read.table("activity_labels.txt", col.names=c("label", "activity"), as.is=TRUE)
        
        #As the training dataset and test dataset have the same structure and we will do the same
        #cleanup process to them, we don't want to write the almost same code twice, so we use a variable
        #to identify the dataset names and use a for loop to traverse the names.
        datasets <- c("test", "train")
        result <-data.frame() #used to store the result of every tiny datasets together
        for (dataset in datasets) {
                subject <- read.table(paste0(c(dataset, "\\subject_", dataset, ".txt"),collapse=""), col.names=c("subject"))
                actlabels <-read.table(paste0(c(dataset, "\\y_", dataset, ".txt"),collapse=""), col.names=c("label"))
                
                #read the datasets, use feature names from features.txt to be the column names
                data <- read.table(paste0(c(dataset, "\\x_", dataset, ".txt"),collapse=""), col.names=featurenames[,2])
                #Only mean the std measures needed. All these measures can be detected by their names
                #which has a "mean()" or "std()" in it. There are some measures like "angle(X,gravityMean)"
                #which are not a mean of any measures but a measure about mean of one measure, so they have
                #to be exclude carefully. We can do this by detect "mean()" or "std()" in the feature names,
                #or column names of the data frame.
                #R automatically transforms "(" and ")" to "." when it be used as column name of data frame,
                #so we have to read feature names back from the column names before we detect.
                features <- colnames(data)
                selcols <- features[str_detect(features,"*(mean|std)\\.\\.*")]
                data <- subset.data.frame(data, select=selcols)
                
                #now we bind subjects and activity labels to the measure data
                data <- cbind.data.frame(subject,actlabels,data)
                
                #As the activicty labels are not readable names, we need to replace them with activity names.
                #We can do this by merge the activities and measure data, then subset it by omit the activity
                #labels.
                data <- merge(data, activities,  ALL=TRUE)
                data <- data[, c(2, 69, 3:68)]
                
                #As the data is tiny now, we put it into the final result.
                result <- rbind(result, data)
        }
        
        library(reshape2) #get access for function melt and dcast
        #transform the data into an easy way to calc average of every measures
        mdata<-melt(data, id.vars=c("subject","activity"), measure.vars=3:68)
        #reshape the tiny data into a wide form
        tdata<-dcast(mdata, subject + activity ~ variable, mean)
        
        #output the data into a text file
        write.table(tdata, file="output.txt", row.names=F)
}