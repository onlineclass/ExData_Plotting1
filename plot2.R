## plot2.R script generates the second plot of the assignment - "Plot 2".
## To execute the script, simply source it in R/RStudio at the command prompt:
##         > source("plot2.R")
## The script performs the following tasks
##      1. Load the data from the raw data file and discards the rows we don't 
##         need: for generating the plot we keep the rows for only two 
##         days - Feb.1, 2007 and Feb. 2, 2007.
##      2. Create plot2.png - a png graphics file containing the simple time 
##         series plot of the "Global active power" variable

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
png(filename = "plot2.png", width=480, height=480, units="px", bg="white")

## 2.2 Create plot2 (the raw time series line plot of "Global_active_power" 
## variable) on the png device
plot(data$Date_Time, data$Global_active_power, type = "l", 
     main = "", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
