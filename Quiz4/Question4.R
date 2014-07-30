#  Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# 
#  Load the educational data from this data set:
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# 
#  Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
# 
#  Original data sources:
#   http://data.worldbank.org/data-catalog/GDP-ranking-table
#  http://data.worldbank.org/data-catalog/ed-stats

downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

gdpFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdpDataFile <- file.path(paste(downloadDir, "getdata_data_GDP.csv", sep="/"))
download.file(gdpFileUrl, destfile=gdpDataFile, method="curl")
gdpData <- read.csv(gdpDataFile, stringsAsFactors = FALSE, skip=4, nrows=215, col.names=c("CountryCode", "Rank", "Empty1", "Fullname", "GDP", "Empty3", "Empty4", "Empty5", "Empty6", "Empty7"))

educationFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
educationDataFile <- file.path(paste(downloadDir, "getdata_data_GDP.csv", sep="/"))
download.file(educationFileUrl, destfile=educationDataFile, method="curl")
educationData <- read.csv(educationDataFile, stringsAsFactors = FALSE)

mergedData <- merge(gdpData, educationData, by.x="CountryCode", by.y="CountryCode", all=FALSE)

length(mergedData$Special.Notes[grep("Fiscal year end: June", mergedData$Special.Notes)])
