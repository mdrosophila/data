## Downlod the zip file from web, named it to hw3.zip


downloadfile<-function(){
  if (!file.exists("./data")) dir.create("./data") 
  myurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(myurl,"./data/hw3.zip",mode="wb")
  
}

run_analysis<-function(){
        
        ## Unzip the downloaded file. The names files are stored in filenames
        filenames<-unzip("./data/hw3.zip")
        
        ## 1. Merges the training and the test sets to create one data set.
        
        ## Read in files from "test" folder
        ## combine them toghether into "test" file with cbind function
        doc1<-read.table(filenames[14])
        doc2<-read.table(filenames[15])
        doc3<-read.table(filenames[16])
        test<-cbind(doc1,doc3,doc2)
        ## Read in files from "train" folder
        ## combine them toghether into "train" file with cbind fucntion
        doc4<-read.table(filenames[26])
        doc5<-read.table(filenames[27])
        doc6<-read.table(filenames[28])
        train<-cbind(doc4,doc6,doc5)
        ## Merge "test" and "train" file into one "mergefile" file 
        ## Using the rbind fucntion
        mergefile<-rbind(test,train)
        ## The column names of "mergefile" are replaced with descriptive names,
        ## with test subject with "subject",
        ## activity names (i.e.walking...) with "activity" or its code "activitycode"
        ## Measurement names extracted from feature.txt file
        feature<-read.table(filenames[2],colClasses="character")
        feature<-feature[[2]]
        names(mergefile)<-c("subject","activitycode",feature)
        
        ## 2. Extracts only the measurements on the mean and 
        ##standard deviation for each measurement. 
        
        mergefile2<-mergefile[,c(1,2,grep("mean",names(mergefile)),grep("std",names(mergefile)))]
        
        ## 3.Uses descriptive activity names to name the activities 
        ## in the data set.The activity names are extracted from 
        ## activity_labels.txt file.
        activity<-read.table(filenames[1])
        mergefile3<-merge(activity,mergefile2,by.x=1,by.y="activitycode")
        names(mergefile3)<-c("activitycode","activity",names(mergefile3)[3:length(mergefile3)])
        mergefile3$activitycode<-NULL
        ## 4. Appropriately labels the data set with descriptive variable names. 
        ## Remove '-',"()"from column names, make names readable
        ## Replace Cap letters with lower letters
        names(mergefile3)<-gsub("-","",names(mergefile3))
        names(mergefile3)<-gsub("\\()","",names(mergefile3))
        names(mergefile3)<-tolower(names(mergefile3))
        
        ##Creates a second, independent tidy data set with the average of 
        ##each variable for each activity and each subject. 
        ##Melt data based on activity and subject
        ##caculate mean of other variables based on activity and subject
        library(reshape2)
        meltfile<-melt(mergefile3,id=c("activity","subject"))
        file2<-dcast(meltfile,activity+subject~variable, mean)
        file2       
              
}


