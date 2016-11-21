#run_analysis.R
library("data.table")

read_files <- function(directory)
{
  setwd(directory)
  for(f in dir())
  {
    assign(f,fread(f))
    assign(strsplit(f,".txt")[[1]], as.data.frame(get(f)), envir = .GlobalEnv)
    #rm(list=f)
  }
}

dir1 <- "C:/Users/sam.jacob/Documents/data/UCI HAR Dataset/train/Inertial Signals"
dir2 <- "C:/Users/sam.jacob/Documents/data/UCI HAR Dataset/test/Inertial Signals"

system.time(read_files(dir1))
system.time(read_files(dir2))

tr <- ls()[grepl("train",ls())]
ts <- ls()[grepl("test",ls())]

tr_sizes <- sapply(tr,function(x) {return(object.size(get(x)))})
ts_sizes <- sapply(ts,function(x) {return(object.size(get(x)))})

tr_ncol <- sapply(tr,function(x) {return(ncol(get(x)))})
ts_ncol <- sapply(ts,function(x) {return(ncol(get(x)))})

tr_nrow <- sapply(tr,function(x) {return(nrow(get(x)))})
ts_nrow <- sapply(ts,function(x) {return(nrow(get(x)))})


i <- 1
for(df in tr)
{
  assign(paste(strsplit(df,"train")[1],"_merge",sep = ""),rbind(get(df),ts[i]))
  i <- i+1
}

mapply(rbind,tr,ts)
