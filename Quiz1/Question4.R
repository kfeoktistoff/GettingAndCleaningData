## Read the XML data on Baltimore restaurants from here:
##   
##   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
## 
## How many restaurants have zipcode 21231? 

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
downloadDir <- "./data"

if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

dataFile <- paste(downloadDir, "getdata_data_restaurants.xml", sep="/")
download.file(fileUrl, destfile=dataFile, method="curl")
doc <- xmlTreeParse(dataFile, useInternal=T)
rootNode <- xmlRoot(doc)
zipcodes <- xpathSApply(doc, "//zipcode", xmlValue)
length(zipcodes[zipcodes==21231])