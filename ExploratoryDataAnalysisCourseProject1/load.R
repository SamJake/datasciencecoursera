library(data.table)
library(dplyr)
setwd("../Downloads/exdata")
f <- dir()[1]
dt1 <- as.Date("2007-02-01")
dt2 <- as.Date("2007-02-02")
df <- fread(f,header = T, sep=";", na.strings = "?")
df <- tbl_df(df)
df$Date <- as.Date(df$Date,"%d/%m/%Y")
names(df)[1] <- "date"
#df1 <- filter(df,df$Date=="2007-02-01"|df$Date=="2007-02-02")
df1 <- filter(df,date==dt1|date==dt2)