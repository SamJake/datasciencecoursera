pre <- function(state,outcome)
{
  setwd("C:/Users/sam.jacob/Downloads/rprog3")
  csv <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  csv <- csv[,c(2,7,11,17,23)]
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(csv$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
  out <- c("heart attack", "heart failure", "pneumonia")
  
  if(sum(is.element(unique(csv[,2]),state))==0)
    stop("invalid state")
  if(sum(is.element(out,outcome))==0)
    stop("invalid outcome")
  
  csv <<- csv
}

best <- function(state, outcome)
{

  pre(state,outcome)
  data <- subset(csv, State==state)
  
  if(outcome=="heart attack")
  {
    m <- min(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }else if(outcome=="heart failure")
  {
    m <- min(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }else if(outcome=="pneumonia")
  {
    m <- min(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }
}

worst <- function(state, outcome)
{
  pre(state,outcome)
    data <- subset(csv, State==state)
  
  if(outcome=="heart attack")
  {
    m <- max(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }else if(outcome=="heart failure")
  {
    m <- max(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }else if(outcome=="pneumonia")
  {
    m <- max(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,na.rm = TRUE)
    rows <- subset(data,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia==m)
    if(nrow(rows)==1) return(rows$Hospital.Name)
    else{
      rows <- rows[order(rows$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,na.last = NA),]
      return(rows$Hospital.Name[1])
    }
  }
}


best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")
