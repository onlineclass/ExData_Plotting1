## plot1.R script generates the first plot of the assignment - "Plot 1".
## To execute the script, simply source it in R/RStudio at the command prompt:
##         > source("plot1.R")
## The script performs the following tasks
##      1. Load the data from the raw data file and discard the rows we don't 
##         need: for generating the plot we keep the rows for only two 
##         days - Feb.1, 2007 and Feb. 2, 2007.
##      2. Create plot1.png - a png graphics file containing the histogram of 
##         the "Global active power" variable

## 1.1 Read the data file
data <- read.table("household_power_consumption.txt", header = T, sep = ";", 
                   na.strings = "?", stringsAsFactors = F)

## 1.2 Merge the first 2 columns and convert the result in a POSIXct data type
data[,2] <- paste(data[,1], data[,2], sep = " ")
data <- data[,2:ncol(data)]
data <- cbind(strptime(data[,1], format = "%d/%m/%Y %H:%M:%S"), 
              data[,2:ncol(data)])
names(data)[1] <- "Date_Time"

## 1.3 Discard all the rows which will not be used to generate the plot
data <- data[data[,1] >= strptime("01/02/2007 00:00:00", 
                                  format = "%d/%m/%Y %H:%M:%S") & 
             data[,1] < strptime("03/02/2007 00:00:00", 
                                 format = "%d/%m/%Y %H:%M:%S"),]

## 2.1 Define the "png" device
png(filename = "plot1.png", width=480, height=480, units="px", bg="transparent")

## 2.2 Create plot1 (the histogram of "Global_active_power" variable) on the 
## png device
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
