# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dataFile <- file.path(paste(downloadDir, "getdata_data_ss06hid.csv", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

data <- read.csv(dataFile)

strsplit(names(data), "wgtp")[123]