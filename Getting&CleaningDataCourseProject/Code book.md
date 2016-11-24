CODE BOOK

Function "read_files" that will read all files in a directory that gave have a particular pattern.

Uses fread to quickly load all files within the passed directory and with pattern and saves them in .GlobalEnv


Read test/train, activity and labels files into memory using read_files()

Use cbind() to bind activity and labels indicator columns in test & train datasets and merge into 'total'

Removd unwanted characters like "(","-",")" using gsub() from features file and update row headers for total (test+train) dataset.

Merge labels & subjects to total dataset.

Using sqldf() to update labels like "WALKING", "STANDING" etc.

Select only required fields such as *mean* and *std* fields from total using grepl(). [Variable = selected]

Group by select data by activity/person and fetch mean of all *mean* and *std* fields. [Variable = by_person]

Write the summarized data into a text file using write.table()

