##Step 1. Read in all relevant data ##

##Column headings - 561 headings
col_head<-read.table("./UCI HAR Dataset/features.txt")

##Activity Labels -
activity_labs<-read.table("./UCI HAR Dataset/activity_labels.txt")
 
##xtrain dataset has 561 columns and 7352 rows
##ytrain dataset is a vector of 7352 numbers 1:6 (representing the 6 activities)
##subject_train dataset is a vector of 7352 numbers 1:30 (representing the 30 participants)
xtrain_data<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain_data<-read.table("./UCI HAR Dataset/train/y_train.txt")
subtrain_data<-read.table("./UCI HAR Dataset/train/subject_train.txt")

##xtest dataset has 561 columns and 2947 rows
##ytest dataset is a vector of 2947 numbers 1:6 (representing the 6 activities)
##subject_test dataset is a vector of 2947 numbers 1:30 (representing the 30 participants)
xtest_data<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest_data<-read.table("./UCI HAR Dataset/test/y_test.txt")
subtest_data<-read.table("./UCI HAR Dataset/test/subject_test.txt")


##Step 2: Rbind train and test data & add headings ##

data1<-rbind(xtrain_data,xtest_data)
col_head2<-make.names(col_head$V2,unique=TRUE)
colnames(data1)<-col_head2


##Step 3: Left join Activity Labels to Y data and Cbind this + subject data to main body of data##

library(plyr)
subjects<-rbind(subtrain_data,subtest_data)
colnames(subjects)<-c("Subject")

activities<-rbind(ytrain_data,ytest_data)
activities2<- join(activities,activity_labs,type="left")
colnames(activities2)<-c("Activity_Code","Activity")

data2<-cbind(subjects,activities2,data1)

##Step 4: Use grep to extract columns concerning mean and std##

data3<-data2[,grep("Subject|Activity|.mean|.Mean|.std",colnames(data2),value=TRUE)]

##Step 5: Summarise by subject and activity## 

data3$Subject<-as.factor(data3$Subject)
data3$Activity<-as.factor(data3$Activity)

data4<-data3 %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
data5<-subset(data4,select=-Activity_Code)

 write.table(data5,"tidydata.txt",row.name=FALSE)

