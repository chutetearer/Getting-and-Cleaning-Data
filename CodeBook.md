### Codebook for tidyData.txt


#### Original data source:

The raw data for this assignment originated from:

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

**License:**
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the
authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

For additional information about the original data, please refer to:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

---

##### Summary of the original data:

| Content    |Columns     | Train Obs. | Test Obs.  | Total Obs. |
|:----------:|:----------:|:----------:|:----------:|:----------:|
|subject     |1           | 7352       | 2947       | 10299      |
|activity    |1           | 7352       | 2947       | 10299      |
|features    |561         | 7352       | 2947       | 10299      |
|**Total**   |563         | 7352       | 2947       | 10299      |

---  

** **

#### tidyData.txt columns/values:

For a detailed explanation of how the tidyData.txt data was extracted and processed, please refer to the README.md document available in this repository.

tidyData.txt is composed of 180 rows/observations and 68 columns/values.

The following column names were kept from the original data source except for "activity" and "subject", and the values represent the means of the original data grouped by "activity" and "subject".

##### Column name: **"activity"**
- Column number: 1
- Column type: Factor
- Values: "WALKING", "WALKING_UPSTAIRS" ,"WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"

##### Column name: **"subject"**
- Column number: 2
- Column type: Factor
- Values: 30 subjects enumerated from "1" to "30"

##### Column name: **"tBodyAcc-mean()-X"** to **"fBodyBodyGyroJerkMag-std()"**
- Column number: 3 to 68
- Column type: Numeric
- Values: Mean value of column grouped by "activity" and "subject"
- Units: Every original variable has been normalised into a -1 to 1 range, so the units are meaningless.
- Complete column names (1)(2):
  - [3] "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z"
  - [6] "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z"
  - [9] "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z"
  - [12] "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z"
  - [15] "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z" 
  - [18] "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z" 
  - [21] "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z" 
  - [24] "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z" 
  - [27] "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z" 
  - [30] "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z" 
  - [33] "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()" 
  - [36] "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()" 
  - [39] "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()" 
  - [42] "tBodyGyroJerkMag-std()"
  - [43] "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z" 
  - [46] "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z" 
  - [49] "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z" 
  - [52] "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z" 
  - [55] "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z" 
  - [58] "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z" 
  - [61] "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()" 
  - [64] "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()" 
  - [67] "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()"

(1) The "t" and "f" prefix of the column names specifies if the values were calculated
from the time or frequency domain.
(2) Only column names containing "std()" and "mean()" have been kept, following the assignment requirements.

