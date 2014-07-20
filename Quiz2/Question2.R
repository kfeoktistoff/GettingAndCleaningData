# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with 
# the dbSendQuery command in RMySQL. Download the American Community Survey 
# data and load it into an R object called
# 
# acs
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

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

sqldf("select pwgtp1 from acs where AGEP < 50")