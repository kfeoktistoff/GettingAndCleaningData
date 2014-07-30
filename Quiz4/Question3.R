# In the data set from Question 2 what is a regular expression that would allow you to count the number of countries 
# whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United? 

downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
dataFile <- file.path(paste(downloadDir, "getdata_data_GDP.csv", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

gdpData <- read.csv(dataFile, stringsAsFactors = FALSE, skip=4, nrows=215, col.names=c("CountryCode", "Rank", "Empty1", "Fullname", "GDP", "Empty3", "Empty4", "Empty5", "Empty6", "Empty7"))
countryNames <- gdpData$Fullname
length(grep(pattern = "^United", gdpData$Fullname))