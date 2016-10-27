rankhospital <- function(state, outcome, num="best")
{
if(num=="best") return(best(state,outcome))
if(num=="worst") return(worst(state,outcome))  
  
  pre(state,outcome)
  data <- subset(csv, State==state)
  num <- as.numeric(num)
  if(outcome=="heart attack")
  {
      rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      if(num>nrow(rows)) return(NA)
      else{
        m <- rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[num]
        rows <- subset(rows,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
        rows <- rows[order(rows$Hospital.Name)]
      return(rows$Hospital.Name[1])}
  }else if(outcome=="heart failure")
  {
    rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,na.last = NA),]
    if(num>nrow(rows)) return(NA)
    else{
      m <- rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure[num]
      rows <- subset(rows,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure==m)
      rows <- rows[order(rows$Hospital.Name)]
      return(rows$Hospital.Name[1])}
  }else if(outcome=="pneumonia")
  {
    rows <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,na.last = NA),]
    if(num>nrow(rows)) return(NA)
    else{
      m <- rows$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia[num]
      rows <- subset(rows,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia==m)
      rows <- rows[order(rows$Hospital.Name)]
      return(rows$Hospital.Name[1])}
  }
}

rankhospital("TX", "heart failure", 1)
rankhospital("TX", "heart failure", 2)
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)


