# Read this data set into R and report the sum of the numbers in the fourth column.
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# 
# (Hint this is a fixed width file format)

downloadDir <- './data'
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
dataFile <- file.path(paste(downloadDir, "getdata_Fwksst8110.for", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

data <- read.fwf(dataFile, skip = 4, widths=c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3))
sum(data[,8]) # 8 = 2 * 4