## Manually download the zip file and unzip it into the default working directory
## Change the working directory
setwd("UCI HAR Dataset")

## Read in the test files
x_test<-read.table("test/x_test.txt")
y_test<-read.table("test/y_test.txt")
subject_test<-read.table("test/subject_test.txt")

x_train<-read.table("train/x_train.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.table("train/subject_train.txt")

features<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

## Merge the data
data<-rbind(x_test,x_train)

## Extract the wanted features
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
data<-data[,featuresWanted]
colnames(data) <- c(featuresWanted.names)

## Add the subject and the activity
test<-cbind(subject_test,y_test)
train<-cbind(subject_train,y_train)
data1<-rbind(test,train)
colnames(data1)<-c("subject","activity")

## Combine all the data
alldata<-cbind(data1,data)

## Turn activities & subjects into factors
alldata$activity <- factor(alldata$activity, levels = activity_labels[,1], labels = activity_labels[,2])
alldata$subject <- as.factor(alldata$subject)

## Create a tidy data set
write.table(alldata, "tidy.txt", row.names = FALSE, quote = FALSE)
