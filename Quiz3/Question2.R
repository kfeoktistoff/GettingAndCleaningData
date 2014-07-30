library(jpeg)

downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
dataFile <- file.path(paste(downloadDir, "getdata_jeff.jpg", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl", mode="wb")

jpg <- readJPEG(source = dataFile, native = TRUE)
quantile(jpg, probs = c(.3,.8))