complete <- function(directory, id = 1:332)
{
  setwd(directory)
  temp <- length(id)
  id <- as.integer(id)
  df <- data.frame(id=vector(mode="character",length=temp),nobs=numeric(temp))
  df$id <- as.character(df$id)
  
  if(temp==1)
  {
    f_name <- paste(sprintf("%03d",id),".csv", sep = "")
    f <- read.csv(file = f_name)
    df$id[1] <- f_name
    df$nobs[1] <- sum(complete.cases(f[,1:4]))
  }else
  {
    k <- 1
    for(i in id)
    {
      #f_name <- paste(sprintf("%03d",id[i]),".csv", sep = "")
      f_name <- paste(formatC(id[k],width=3,format="d",flag="0"),".csv", sep="")
      print(f_name)
      f <- read.csv(file = f_name)
      df$id[k] <- f_name
      df$nobs[k] <- sum(complete.cases(f[,1:4]))
      k <- k+1  
    }
  }
  df
}

#complete("C:/Sammy/R/Coursera/specdata",1:10)
#complete("C:/Sammy/R/Coursera/specdata",325:330)
#complete("C:/Sammy/R/Coursera/specdata",325)
#complete("C:/Sammy/R/Coursera/specdata",c(44, 331))