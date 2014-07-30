library(data.table)
library(sqldf)
library(plyr)

# Creates feed name using root and dataset names
createFeedName <- function(rootName, suffix) {
  paste(paste(rootName, suffix, sep = "_"), ".txt", sep = "")
}

# Returns subset which contains only columns with 'mean()' and 'std()' in name
extractData <- function(dataFolder, subset) {
  subject_test <- read.table(paste(dataFolder, subset, createFeedName("subject", subset), sep = "/"), header = FALSE, stringsAsFactors= F, col.names = "subject")
  
  y_test <- read.table(paste(dataFolder, subset, createFeedName("y", subset), sep = "/"), header = FALSE, stringsAsFactors= F, col.names = "activityId")
  X_test <- read.table(paste(dataFolder, subset, createFeedName("X", subset), sep = "/"), header = FALSE, stringsAsFactors= F, col.names = feature$name)
  
  X_test$activity <- merge(y_test, activity, by.x = "activityId", by.y = "id", all = TRUE)$name
  X_test$subject <- subject_test$subject
  
  measurements <- c("Activity", "Subject")

  for (i in 1:ncol(X_test)) {
    if (grepl(x = colnames(X_test)[i], pattern = "mean\\.\\.") || grepl(x = colnames(X_test)[i], pattern = "std\\.\\."))
      measurements <- append(measurements, colnames(X_test)[i])
  }
  
  measurements <- gsub(x = measurements, pattern = "\\.", replacement = "_")
  
  extracted <- sqldf(paste("select", paste(measurements, collapse = ", "), "from X_test", sep = " "))
  extracted$subject <- as.numeric(extracted$subject)
  extracted
}

# Returns labels to readable form
correctLabels <- function(labels) {
  labels <- gsub(x = labels, pattern = "_+", replacement = "_")
  labels <- gsub(x = labels, pattern = "_$", replacement = "")
  labels <- gsub(x = labels, pattern = "^t", replacement = "Time")
  labels <- gsub(x = labels, pattern = "^f", replacement = "Frequency")
  labels <- gsub(x = labels, pattern = "Mag", replacement = "Magnitude")
  labels <- gsub(x = labels, pattern = "BodyBody", replacement = "Body")
}

# Downloading and unzipping data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "getdata_projectfiles_UCI HAR Dataset.zip"

if(!file.exists(fileName)){
  download.file(fileUrl,fileName, mode = "wb", method="curl")
}

unzip(fileName)

dataFolder <- "UCI HAR Dataset"
dataset1 <- "dataset1.txt"
dataset2 <- "dataset2.txt"

# Reading dictionary entities
feature <- read.table(paste(dataFolder, "./features.txt", sep = "/"), header = FALSE, col.names=c("id", "name"), stringsAsFactors= F)
activity <- read.table(paste(dataFolder, "./activity_labels.txt", sep = "/"), header = FALSE, col.names=c("id", "name"), stringsAsFactors= F)

# Reading data and cleaning datasets
testData <- extractData(dataFolder, "test")
trainData <- extractData(dataFolder, "train")
wholeDataset <- rbind(testData, trainData)
wholeDataset <- wholeDataset[order(wholeDataset$activity), ]
colnames(wholeDataset) <- correctLabels(colnames(wholeDataset))
groupedDataset <- ddply(wholeDataset, .(subject, activity), function(x) colMeans(x[,-c(1:2)]))

# Save result files
write.table(wholeDataset, dataset1)
write.table(groupedDataset, dataset2)