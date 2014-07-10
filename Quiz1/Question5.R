## The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
##   
##   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
## 
## using the fread() command load the data into an R object
## 
## DT 
## 
## Which of the following is the fastest way to calculate the average value of the variable
## 
## pwgtp15 
## 
## broken down by sex using the data.table package? 

library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
downloadDir <- "./data"

if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

dataFile <- paste(downloadDir, "getdata_data_ss06pid.csv", sep="/")
download.file(fileUrl, destfile=dataFile, method="curl")
DT <- fread(dataFile)
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}) ## Timing stopped at: 0.563 0.006 0.57 
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time((tapply(DT$pwgtp15,DT$SEX,mean)))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(DT[,mean(pwgtp15),by=SEX])