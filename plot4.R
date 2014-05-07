## plot4.R script generates the fourth plot of the assignment - "Plot 4".
## To execute the script, simply source it in R/RStudio at the command prompt:
##         > source("plot4.R")
## The script performs the following tasks
##      1. Load the data from the raw data file and discards the rows we don't 
##         need: for generating the plot we keep the rows for only two 
##         days - Feb.1, 2007 and Feb. 2, 2007.
##      2. Create plot4.png - a png graphics file containing a set of 4 plots
##         for the following variables:
##            - top-left: Global_active_power
##            - top-right: Voltage
##            - bottom-left: Sub_metering_1, Sub_metering_2 and Sub_metering_3
##            - bottom-right: Global_reactive_power

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
png(filename = "plot4.png", width=480, height=480, units="px", bg="white")

## 2.2 Create plot4 as a set of 4 plots
par(mfrow = c(2,2))

## 2.2.1 Plot the Global_active_power
plot(data$Date_Time, data$Global_active_power, type = "l", 
     main = "", xlab = "", ylab = "Global Active Power")

## 2.2.2 Plot the Voltage
plot(data$Date_Time, data$Voltage, type = "l", 
     main = "", xlab = "datetime", ylab = "Voltage")

## 2.2.3 Plot Sub_metering_1, Sub_metering_2 and Sub_metering_3
plot(data$Date_Time, data$Sub_metering_1, type = "l", 
     main = "", xlab = "", ylab = "Energy sub metering", col = "black")
lines(data$Date_Time, data$Sub_metering_2, col = "red")
lines(data$Date_Time, data$Sub_metering_3, col = "blue")
legend("topright", names(data)[6:8], lty=1, bty="n", 
       col=c("black", "red", "blue"))

## 2.2.4 Plot the Global_reactive_power
plot(data$Date_Time, data$Global_reactive_power, type = "l", 
     main = "", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

