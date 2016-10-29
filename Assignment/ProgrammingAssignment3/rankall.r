rankall <- function(outcome, num="best")
{
  setwd("C:/Users/Sam/Downloads/rp")
  csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  csv <- csv[,c(2,7,11,17,23)]
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
  out <- c("heart attack", "heart failure", "pneumonia")
  
  if(sum(is.element(out,outcome))==0)
    stop("invalid outcome")
  
  df <- data.frame(hospital <- as.character(), state <- as.character())
  csv$State <- as.factor(csv$State)
  csv_split <- split(csv,csv$State)
  processed <- lapply(csv_split,function(x,num) 
  {
    if(num=="best"){
      x <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      m <- x[1,3]
      x <- subset(x,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
      x <- x[order(x$Hospital.Name),]
      temp <- x$Hospital.Name[1]
      return(temp)
    }else if(num=="worst"){
      x <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      m <- x[nrow(x),3]
      x <- subset(x,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
      x <- x[order(x$Hospital.Name),]
      temp <- x$Hospital.Name[nrow(x)]
      return(temp)
    }else
    {#Handle NAs here
      x <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      m <- x[as.numeric(num),3]
      x <- subset(x,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
      x <- x[order(x$Hospital.Name),]
      temp <- x$Hospital.Name[1]
      return(temp)
    }
    },num
                      )
processed
}



a <- rankall("heart attack","best")
df <- data.frame(st <- names(a), hosp <- unlist(a))
b <- rankall("","worst")
c <- rankall("heart attack",5)


