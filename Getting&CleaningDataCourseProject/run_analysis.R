#run_analysis.R
library("data.table")
library("sqldf")
library("dplyr")

#reading all training & test files into memory
read_files <- function(directory,pattern="")
{
  setwd(directory)
  for(f in dir(pattern = pattern))
  {
    assign(f,fread(f))
    assign(strsplit(f,".txt")[[1]], as.data.frame(get(f)), envir = .GlobalEnv)
    #rm(list=f)
  }
}

dir1 <- "C:/Users/Sam/Downloads/UCI HAR Dataset/train/Inertial Signals"
dir2 <- "C:/Users/Sam/Downloads/UCI HAR Dataset/test/Inertial Signals"

system.time(read_files(dir1))
system.time(read_files(dir2))

tr <- ls()[grepl("train",ls())]
ts <- ls()[grepl("test",ls())]

#merging all training and test files into *merge files
mapply(function(x,y) {assign(paste(strsplit(x,"train")[1],"merge",sep=""),rbind(get(x),get(y)),envir = .GlobalEnv)},as.list(tr),as.list(ts))

#saving dimensions of all training, test and merge objects and storing them in data.frame for easy view
tm <- ls()[grepl("merge",ls())]

tr_sizes <- sapply(tr,function(x) {return(object.size(get(x)))})
ts_sizes <- sapply(ts,function(x) {return(object.size(get(x)))})
tm_sizes <- sapply(tm,function(x) {return(object.size(get(x)))})

tr_ncol <- sapply(tr,function(x) {return(ncol(get(x)))})
ts_ncol <- sapply(ts,function(x) {return(ncol(get(x)))})
tm_ncol <- sapply(tm,function(x) {return(ncol(get(x)))})

tr_nrow <- sapply(tr,function(x) {return(nrow(get(x)))})
ts_nrow <- sapply(ts,function(x) {return(nrow(get(x)))})
tm_nrow <- sapply(tm,function(x) {return(nrow(get(x)))})

df_objects <- data.frame(Tr_Size=tr_sizes,Ts_Size=ts_sizes,Tm_Size=tm_sizes,Tr_Ncols=tr_ncol,Ts_Ncols=ts_ncol,Tm_Ncols=tm_ncol,Tr_Nrows=tr_nrow,Ts_Nrows=ts_nrow,Tm_Nrows=tm_nrow)

dir3 <- "C:/Users/Sam/Downloads/UCI HAR Dataset/train"
dir4 <- "C:/Users/Sam/Downloads/UCI HAR Dataset/test"

system.time(read_files(dir3,"train"))
system.time(read_files(dir4,"test"))


test <- cbind(subject_test,y_test,X_test)
names(test)[1:2] <- c("Subject","labels")

train <- cbind(subject_train,y_train,X_train)
names(train)[1:2] <- c("Subject","labels")

setwd("C:/Users/Sam/Downloads/UCI HAR Dataset")
features <- fread("features.txt")
features <- as.data.frame(features)
labels <- fread("activity_labels.txt")
labels <- as.data.frame(labels)

#Removing -,(,) and comma from features
features$V2 <- gsub("[-(),]","",features$V2)

names(train)[3:563] <- features$V2
names(test)[3:563] <- features$V2

total <- rbind(train,test)

t <- data.frame(labels = total$labels)

l <- sqldf("select labels.V2 from t,labels where t.labels=labels.V1")
total$labels <- as.character(l$V2)

cols <- grepl("mean",names(total),ignore.case = T) | grepl("std",names(total),ignore.case = T)
cols[1:2] <- TRUE
selected <- total[,cols]
names(selected) 

selected2 <- tbl_df(selected)
by_person <- group_by(selected2,labels,Subject)
summarize(by_person,sapply(names(by_person)[3:88],function(x) {paste0("mean(",x,")")}))
sapply(names(by_person)[3:88])
