# Load the Gross Domestic Product data for the 190 ranked countries in this data set:

#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 

# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table 

downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
dataFile <- file.path(paste(downloadDir, "getdata_data_GDP.csv", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

gdpData <- read.csv(dataFile, stringsAsFactors = FALSE, skip=4, nrows=215, col.names=c("CountryCode", "Rank", "Empty1", "Fullname", "GDP", "Empty3", "Empty4", "Empty5", "Empty6", "Empty7"))
gdpData$GDP <- gsub(x=gdpData$GDP, pattern = ",", replacement = "")
gdpData$GDP <- as.numeric(gdpData$GDP)
mean(gdpData$GDP, na.rm = TRUE)