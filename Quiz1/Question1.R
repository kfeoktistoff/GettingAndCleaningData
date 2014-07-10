## The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
##  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
##
## and load the data into R. The code book, describing the variable names is here:
##  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
##
## How many housing units in this survey were worth more than $1,000,000? 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
downloadDir <- "./data"

if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

dataFile <- paste(downloadDir, "getdata_data_ss06hid.csv", sep="/")
download.file(fileUrl, destfile=dataFile, method="curl")
data <- read.csv(dataFile, colClasses="character")
data[,VAL] <- suppressWarnings(as.numeric(data[,VAL]))
nrow(subset(data, data$VAL==24))