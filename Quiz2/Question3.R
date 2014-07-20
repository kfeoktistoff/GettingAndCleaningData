# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

library(sqldf)
library(data.table)
library(tcltk)

downloadDir <- './data'
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
dataFile <- file.path(paste(downloadDir, "getdata_data_ss06pid.csv", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

acs <- data.table(read.csv(dataFile))

sqldf("select distinct AGEP from acs")