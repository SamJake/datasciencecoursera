pollutantmean <- function(directory, pollutant, id = 1:332)
{
  setwd(directory)
  temp <- numeric(length(id))
  id <- as.integer(id)
  
  k <- 1
  for(i in id)
  {
    f <- read.csv(file = paste(formatC(id[k],width = 3, flag="0"),".csv", sep = ""))
    f$sulfate <- as.numeric(f$sulfate)
    f$nitrate <- as.numeric(f$nitrate)
    temp[k] <- mean(f[[pollutant]],na.rm = TRUE)
    k <- k+1
  }
  mean(temp)
}

#pollutantmean("C:/Sammy/R/Coursera/specdata","sulfate",1:25)
#pollutantmean("C:/Sammy/R/Coursera/specdata","sulfate",325:332)