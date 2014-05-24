CODECOOK FOR THE SCRIPT THAT PRODUCES A TIDY DATASET OF THE ACCELEROMETER AND GYROSCOPE DATA FROM THE SMARTLAB 

- Data -

The data are sourced from the SmartLab of the Università degli Studi di Genova.
They are experimental data of human activities collected from the Samsung Galaxy S smartphone. The following introduction is directly quoted from the readme file accompanied by the original dataset:

""The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.""

- Variables -  

The original dataset that contains accelerometer and gyroscope data has 561 variables. However, the dataset produced by the script in this repo will include 79 of these variables. The selection criterion is that the variable name contains either the character string "mean" or "std" (standard deviation). 

""For these variables, the first letter in the variable names is either "t" or "f": "t" denotes time domain signals and "f" represent signals with Fast Fourier Transform (FFT) applied. The first letter is followed by either "body" or "gravity", which is then followed by either "acc", "gyro", "jerk", "mag" or a combination of these. The ending of the variable name consists of either "mean" or "std" (standard deviation) and "X", "Y" or "Z" that denotes the one of the 3-axial directions.

The following explanations are reproduced from the explanations provided by the original dataset: 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.""

In addition to accelerometer and gyroscope data, the cleaned dataset contains a variable named "activity" that shows the activity type of the data: "standing", "sitting", "laying",   "walking", "walking_downstairs", or "walking_upstairs". The "trainortest" variable indicates whether the observation is from the "train" or "test" dataset. The "subjectid" indicates the subject ID of the observation (from 1 to 30).

The variables of the cleaned dataset (a total of 82) are as follows:

 [1] "tbodyaccmeanx"                "tbodyaccmeany"                "tbodyaccmeanz"                "tgravityaccmeanx"             "tgravityaccmeany"             "tgravityaccmeanz"            
 [7] "tbodyaccjerkmeanx"            "tbodyaccjerkmeany"            "tbodyaccjerkmeanz"            "tbodygyromeanx"               "tbodygyromeany"               "tbodygyromeanz"              
[13] "tbodygyrojerkmeanx"           "tbodygyrojerkmeany"           "tbodygyrojerkmeanz"           "tbodyaccmagmean"              "tgravityaccmagmean"           "tbodyaccjerkmagmean"         
[19] "tbodygyromagmean"             "tbodygyrojerkmagmean"         "fbodyaccmeanx"                "fbodyaccmeany"                "fbodyaccmeanz"                "fbodyaccmeanfreqx"           
[25] "fbodyaccmeanfreqy"            "fbodyaccmeanfreqz"            "fbodyaccjerkmeanx"            "fbodyaccjerkmeany"            "fbodyaccjerkmeanz"            "fbodyaccjerkmeanfreqx"       
[31] "fbodyaccjerkmeanfreqy"        "fbodyaccjerkmeanfreqz"        "fbodygyromeanx"               "fbodygyromeany"               "fbodygyromeanz"               "fbodygyromeanfreqx"          
[37] "fbodygyromeanfreqy"           "fbodygyromeanfreqz"           "fbodyaccmagmean"              "fbodyaccmagmeanfreq"          "fbodybodyaccjerkmagmean"      "fbodybodyaccjerkmagmeanfreq" 
[43] "fbodybodygyromagmean"         "fbodybodygyromagmeanfreq"     "fbodybodygyrojerkmagmean"     "fbodybodygyrojerkmagmeanfreq" "tbodyaccstdx"                 "tbodyaccstdy"                
[49] "tbodyaccstdz"                 "tgravityaccstdx"              "tgravityaccstdy"              "tgravityaccstdz"              "tbodyaccjerkstdx"             "tbodyaccjerkstdy"            
[55] "tbodyaccjerkstdz"             "tbodygyrostdx"                "tbodygyrostdy"                "tbodygyrostdz"                "tbodygyrojerkstdx"            "tbodygyrojerkstdy"           
[61] "tbodygyrojerkstdz"            "tbodyaccmagstd"               "tgravityaccmagstd"            "tbodyaccjerkmagstd"           "tbodygyromagstd"              "tbodygyrojerkmagstd"         
[67] "fbodyaccstdx"                 "fbodyaccstdy"                 "fbodyaccstdz"                 "fbodyaccjerkstdx"             "fbodyaccjerkstdy"             "fbodyaccjerkstdz"            
[73] "fbodygyrostdx"                "fbodygyrostdy"                "fbodygyrostdz"                "fbodyaccmagstd"               "fbodybodyaccjerkmagstd"       "fbodybodygyromagstd"         
[79] "fbodybodygyrojerkmagstd"      "activity"                     "trainortest"                  "subjectid"   

- Transformations involved -

To produce the cleaned dataset, the script reads in the accelerator and gyroscope raw data from both the training and test datasets and form a data frame. The subject ID, dataset source (training or test) and activity type data are then combined with the above data frame. Afterwards, means of each accelerator and gyroscope variable from each subject ID and each activity type are calculated to produce the slimer, final dataset. 