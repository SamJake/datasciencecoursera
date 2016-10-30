rankall <- function(outcome, num="best")
{
  setwd("C:/Users/Sam/Downloads/rp")
  out <- c("heart attack", "heart failure", "pneumonia")
  if(sum(is.element(out,outcome))==0)
    stop("invalid outcome")
  csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  if(outcome=="heart attack") 
    {csv <- csv[,c(2,7,11)]
    }else if(outcome=="heart failure") 
    {csv <- csv[,c(2,7,17)]
    }else csv <- csv[,c(2,7,23)]
  names(csv)[3] <- "outcome"
  csv$outcome <- as.numeric(csv$outcome)
  csv$State <- as.factor(csv$State)
  csv_split <- split(csv,csv$State)
  
  processed <- lapply(csv_split,function(x,num) 
  {
    if(num=="best"){
      #x <- x[order(x$outcome,x$Hospital.Name,na.last = NA),]
      x <- x[order(x$outcome,na.last = NA),]
      return(x$Hospital.Name[1])
    }else if(num=="worst"){
      x <- x[order(x$outcome,na.last = NA),]
      #m <- x[nrow(x),2]
      #x <- subset(x,outcome==m)
      return(x$Hospital.Name[nrow(x)])
    }else
    {#Handle NAs here
      x <- x[order(x$outcome,x$Hospital.Name,na.last = NA),]
      if(nrow(x)==0 | num >nrow(x)) return(NA)
      return(x$Hospital.Name[num])
    }
    },num
                      )
  df <- data.frame(unlist(processed),names(processed))
  names(df) <- c("hospital","state")
  df
}



a <- rankall("heart attack","best")
head(a)
b <- rankall("heart failure","worst")
head(b)
b <- rankall("pneumonia","worst")
head(b)
c <- rankall("heart attack",50)
head(c)


head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)


