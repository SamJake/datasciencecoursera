rankall <- function(outcome, num="best")
{
  setwd("C:/Users/sam.jacob/Downloads/rprog3")
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
  processed <- lapply(csv_split,function(x=as.data.frame(),num) 
  {
    x <- x[order(x[3],na.last = NA)]
    if(num=="best"){
      m <- x[1,3]
      x <- subset(x,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
      x <- x[order(Hospital.Name)]
      temp <- data.frame(hospital <- x$Hospital.Name, state <- names(x))
      return(temp)
    }else if(num=="worst"){
      
    }else
    {
      
    }
    }
                      )
}

