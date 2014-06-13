# Code Book

##a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
 
### Downlod the zip file from web, named it to hw3.zip

### Unzip the downloaded file. The names files are stored in filenames
* The filenames viriable stores directory and file names of the data set.
* Access specific files can be doned by subsetting it such as filenames[1]

### Read in files from "test" folder, combine them toghether into "test" file with cbind function

* The files are subject_test.txt, X_test.txt,Y_test.txt
* Store in variable doc1,doc2,doc3
* The data in doc1 doc2 doc3 mean subject id,  measurement data,and activities tested(i.e.walking...)
* The three files are combined into one file called "test"
			
### Read in files from "train" folder and combine them toghether into "train" file with cbind fucntion

* The files are subject_test.txt, X_test.txt,Y_test.txt
* Store in variable doc4,doc5,doc6
* The data in doc4 doc5 doc6 mean subject id,  measurement data,and activities tested(i.e.walking...)
* The three files are combined into one file called "train"
			
### 1. Merges the training and the test sets to create one data set.

* Merge "test" and "train" file into one "mergefile" file using the rbind fucntion
* The column names of "mergefile" are replaced with descriptive names,test subject with "subject", activity names (i.e.walking...) with "activity" or its code "activitycode".
* Measurement data names are extracted from feature.txt file
   
### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* Using grep function to search "mean" and "std" in the column names of mergefile
* The new files are named "mergefile2"
			
### 3.Uses descriptive activity names to name the activities in the data set.
		
* The activity names are extracted from activity_labels.txt file. The activity integer number
* are replaced with activity names in the activity_label.txt file.
* This creates the new file "mergefile3"
		
### 4. Appropriately labels the data set with descriptive variable names. 

* Remove '-',"()"from column names, make names readable using gsub()
* The first character t are replaced with time using gsub()
* The first character f with frequency using gsub()
* Replace Cap letters with lower letters using tolower()
			
###5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. * * * Melt data based on activity and subject
* Caculate mean of other variables based on activity and subject
* The melt and dcast functions require install reshape2 package
