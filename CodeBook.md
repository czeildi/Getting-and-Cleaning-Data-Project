#CodeBook describing the data in averages.txt
 
## Project Description
Creating a tidy dataset providing the average of each measurement
in the Samsung data set for a specific person(subject), and activity, e.g. walking.
 
## Steps taken
- reading the data in
- renaming columns and activity_labels
- subsetting the measurements only for those containing mean() or std() in their names
- merging the test and train sets containing measurements for different people
- creating a new dataset by averaging every measurement groupped by a given person and activity

## Describing the averages data set
- each row corresponds to a specific person and activity
- the first two columns (subject, activity) identify the row
- the subsequent columns each describe the average of a given measurement,
keeping the same names as described in features_info.txt
- the data set has 180 rows describing 6 different activities of 30 different person
- the data set has 68 columns, the last 66 each describing a different measurement
- the units are kept as original, for more info please the description in the Samsung data set
 
