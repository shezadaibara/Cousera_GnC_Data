#CodeBook

<hr>
### Variables
<hr>
__x_data :__ dataframe reprisanting Combined data of `X_train` and `X_test` files

__y_data :__ dataframe reprisanting Combined data of `y_train` and `y_test` files

__subjects :__ dataframe reprisanting Combined data of `subject_train` and `subject_test` files

__x_data_subset :__ dataframe reprisanting subset of x_data dataframe containing only cols with `mean()` or `std()` tag

__all_data :__ dataframe reprisanting Combined data of `x_data_subset`, `y_data` and `subjects`

__avg_data :__ dataframe reprisanting average of each variable for each activity and each subject

<hr>
### Output file
<hr>

__averages_data.txt : __ 
    Output Text file reprisanting independent tidy data set with the average of each variable for each activity and each subject.




<hr>
### Transformation
<hr>
Each function found in `run_analysis.R`

__merge_x_data()__ : __merge_y_data()__ : __merge_subject_data()__:
  
 - These functions fetch the corresponding train and test data from its respective files and rbinds the data into a single dataframe
  
__create_labelled_x_data_subset(x_data)__ :
 
 - This function takes `x_data` as input and provides `x_data_subset` as output, it internally fetches `features_list` : all the features from `features.txt` file.
 - we require only `std()` or `mean()` features  hence using `filter()` and `grepl()` we filter `x_data` dataframe to give there required output `x_data_subset`.
 - __NOTE:__ modified the `x_data_subset` dataframe to have correct names
 
__create_labelled_y_data(y_data)__ :

  - this function takes `y_data` as its input 
  - Internally fetches `activity_list` : all the activities from `activities.txt` file.
  - Mutates `y_data$activity` to have correct activity name rather than just a number  
  - __NOTE:__ modified the `y_data` dataframe to have correct names

__get_average_date(all_data)__ :

  - this function takes `all_data` as its input and gives `avg_data` as output
  - using `group_by()` all_data  is grouped using `subject and activity`
  - then using `summarise_each()` and `mean()` we calculate `avg_data`
