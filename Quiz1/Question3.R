## Download the Excel spreadsheet on Natural Gas Aquisition Program here:
##   
##   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
## 
## Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
##   
##   dat 
## 
## What is the value of:
##   
##   sum(dat$Zip*dat$Ext,na.rm=T) 
## 
## (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
downloadDir <- "./data"

if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

dataFile <- paste(downloadDir, "getdata_data_DATA.gov_NGAP.xlsx ", sep="/")
download.file(fileUrl, destfile=dataFile, method="curl", mode="wb")
dat <- read.xlsx(dataFile, sheetIndex=, colIndex=c(18:23), rowIndex=c(7:15))
sum(dat$Zip*dat$Ext,na.rm=T)