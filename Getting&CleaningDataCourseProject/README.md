Step 1: Create a function "read_files" that will read all files in a directory that gave have a particular pattern.

Step 2: Reading all the training and test files into R memory as data.table objects using fread and then converting them into data.frames,
naming them like "body_acc_x_train", "body_acc_x_test", without any extension.

Step 3: Merging corresponding train & test files into *merge files like "body_acc_x_merge" using rbind function [Train first and then test data].

Step 4: Creating vectors like tr_sizes, tr_ncol, tr_nrow etc to hold sizes, nrows and ncols of training, test and merged data.

Step 5: Creating a data frame "df_objects" with all these vectors, so identify sizes, ncols and nrows of all data. Meaningful row names are given.

df_objects
            Tr_Size Ts_Size  Tm_Size Tr_Ncols Ts_Ncols Tm_Ncols Tr_Nrows Ts_Nrows Tm_Nrows
body_acc_x  7542328 3031608 10560056      128      128      128     7352     2947    10299
body_acc_y  7542328 3031608 10560056      128      128      128     7352     2947    10299
body_acc_z  7542328 3031608 10560056      128      128      128     7352     2947    10299
body_gyro_x 7542328 3031608 10560056      128      128      128     7352     2947    10299
body_gyro_y 7542328 3031608 10560056      128      128      128     7352     2947    10299
body_gyro_z 7542328 3031608 10560056      128      128      128     7352     2947    10299
total_acc_x 7542328 3031608 10560056      128      128      128     7352     2947    10299
total_acc_y 7542328 3031608 10560056      128      128      128     7352     2947    10299
total_acc_z 7542328 3031608 10560056      128      128      128     7352     2947    10299

Step 6: Reading test/train, activity and labels files into memory using read_files()

Step 7: Using cbind() to bind activity and labels indicator columns in test & train datasets and merge into 'total'

Step 8: Removing unwanted characters like "(","-",")" using gsub() from features file and update row headers for total (test+train) dataset.

Step 9: Using sqldf() to update labels like "WALKING", "STANDING" etc.

Step 10: Select only required fields such as *mean* and *std* fields from total using grepl().

Step 11: Group by select data by activity/person and fetch mean of all *mean* and *std* fields.

Step 12: Write the summarized data into a text file using write.table()

