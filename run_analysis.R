# This script is for producing a dataset with averaged Samsung data specified in the readme file.

# The initial working directory is supposed to be where the unzipped folder ("UCI HAR Dataset") can be found. 

# To read raw data:

setwd("./UCI HAR Dataset/train")

trainX = read.csv("X_train.txt", header=FALSE, sep="")
trainY = read.csv("y_train.txt", header=FALSE)
trainSubj = read.csv("subject_train.txt", header=FALSE)

setwd("./UCI HAR Dataset/test")

testX = read.csv("X_test.txt", header=FALSE, sep="")
testY = read.csv("y_test.txt", header=FALSE)
testSubj = read.csv("subject_test.txt", header=FALSE)

setwd("./UCI HAR Dataset/")

featureNames = read.table("features.txt", header=FALSE)
activityLabels = read.table("activity_labels.txt", head=FALSE)

# To combine training and test data:

feature <- rbind(trainX, testX)

# To read in feature names:

colnames(feature) <- featureNames[,2]

# To select features with mean and standard deviation data:

varNames <- as.character(names(feature))
meanStdCol <- c(which(grepl("mean()", varNames)), which(grepl("std()", varNames)))
feature_meanstd <- feature[,meanStdCol]

# To add a new varaible that indicates activity types:

activity <- rbind(trainY, testY)
feature_activity <- cbind(feature_meanstd, activity)
colnames(feature_activity)[ncol(feature_activity)] <- "activity"

# To add a new variable that indicates whether the data are from the training or test dataset:

feature_activity[1:nrow(trainX),ncol(feature_activity)+1] <- "train"
feature_activity[(nrow(feature_activity)-nrow(testX)+1):nrow(feature_activity),ncol(feature_activity)] <- "test"
colnames(feature_activity)[ncol(feature_activity)] <- "trainortest"

# To convert values of activity variable to character strings that describes the activity:

feature_activity$activity <- as.character(feature_activity$activity)
activityLabels[,3] <- tolower(as.character(activityLabels[,2]))
for (ii in 1:nrow(activityLabels)){
	feature_activity$activity[feature_activity$activity==ii] <- activityLabels[ii,3]
}
feature_activity$activity <- as.factor(feature_activity$activity)

# To add subject ID variable

subj = rbind(trainSubj, testSubj)
tidyData <- cbind(feature_activity,subj)
colnames(tidyData)[ncol(tidyData)] <- "subjectid"
tidyData <- tidyData[order(tidyData$subjectid),]

# To create a new data frame that contains the average of each variable for each activity and each subject:

count <- 0 
for (ww in seq(along=unique(tidyData$subjectid))){
	dumlist[[ww]] <- tidyData[which(tidyData$subjectid == ww),]
	for (iii in seq(along=unique(dumlist[[ww]]$activity))){
		for (uu in seq(along=colnames(feature_meanstd))){	
			count <- count + 1
		}
		count = count + 3
	}
}

dumlist = list()
dummatrix = matrix(1:count, nrow=count/ncol(tidyData), ncol=ncol(tidyData))
tidySet <- data.frame(dummatrix)

count2 = 0
for (ww in seq(along=unique(tidyData$subjectid))){
	dumlist[[ww]] <- tidyData[which(tidyData$subjectid == ww),]
	for (iii in seq(along=unique(dumlist[[ww]]$activity))){
		count2 = count2 + 1
		dumsubset <- dumlist[[ww]][dumlist[[ww]]$activity==unique(dumlist[[ww]]$activity)[iii],]
		for (uu in seq(along=colnames(feature_meanstd))){	
			tidySet[count2,uu] = mean(dumsubset[,uu])
		}
		tidySet[count2,80] <- as.character(unique(dumlist[[ww]]$activity)[iii])
		tidySet[count2,81] <- dumlist[[ww]][1,81]
		tidySet[count2,82] <- ww
	}
}

# To tidy up variable names:

varnames <- colnames(tidyData)
varnames <- gsub("-","",varnames)
varnames <- gsub("\\()","",varnames)
varnames <- tolower(varnames)
colnames(tidySet) <- varnames

# To export data frame as a comma delimited .txt file

write.table(tidySet, file="tidyset.txt", sep = ",")

