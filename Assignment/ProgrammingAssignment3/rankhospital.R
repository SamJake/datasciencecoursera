rankhospital <- function(state, outcome, num="best")
{
if(num=="best") return(best(state,outcome))
if(num=="worst") return(worst(state,outcome))  
  
  pre(state,outcome)
  data <- subset(csv, State==state)
  num <- as.numeric(num)
  if(outcome=="heart attack")
  {
      rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,data$Hospital.Name,na.last = NA),]
      if(num>nrow(rows)) return(NA)
      else{
      return(rows$Hospital.Name[num])}
  }else if(outcome=="heart failure")
  {
    rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,data$Hospital.Name,na.last = NA),]
    if(num>nrow(rows)) return(NA)
    else{
      return(rows$Hospital.Name[num])}
  }else if(outcome=="pneumonia")
  {
    rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,data$Hospital.Name,na.last = NA),]
    if(num>nrow(rows)) return(NA)
    else{
      return(rows$Hospital.Name[num])}
  }
}

rankhospital("TX", "heart failure", 1)
rankhospital("TX", "heart failure", 2)
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)


