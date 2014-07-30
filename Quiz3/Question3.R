downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

gpdDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gpdDataFile <- file.path(paste(downloadDir, "getdata_data_GPD.csv", sep="/"))
download.file(gpdDataUrl, destfile=gpdDataFile, method="curl")

educationUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
educationFile <- file.path(paste(downloadDir, "getdata_data_FEDSTATS_Country.csv", sep="/"))
download.file(educationUrl, destfile=educationFile, method="curl")

gpdData <- read.csv(gpdDataFile, stringsAsFactors = FALSE, skip=4, nrows=215, col.names=c("CountryCode", "Rank", "Empty1", "Fullname", "GDP", "Empty3", "Empty4", "Empty5", "Empty6", "Empty7"))
educationData <- read.csv(educationFile, stringsAsFactors = FALSE)

mergedData <- merge(gpdData, educationData, by.x="CountryCode", by.y="CountryCode", all=FALSE)
mergedData$Rank <- gsub(",", "", mergedData$Rank)
mergedData$Rank <- as.numeric(mergedData$Rank)

nrow(mergedData[!is.na(mergedData$Rank),])
mergedData <- mergedData[order(mergedData$Rank, decreasing=TRUE, na.last = TRUE),]
mergedData$Fullname[13]