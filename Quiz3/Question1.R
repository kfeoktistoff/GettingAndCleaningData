downloadDir <- './data'
if (!file.exists(downloadDir)) {
  dir.create(downloadDir)
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
dataFile <- file.path(paste(downloadDir, "getdata_data_ss06hid.csv", sep="/"))
download.file(fileUrl, destfile=dataFile, method="curl")

data <- read.csv(dataFile)

agricultureLogical <- data$ACR==3 & data$AGS==6
agricultureLogical[is.na(agricultureLogical)] <- FALSE
which(agricultureLogical)[1:3]