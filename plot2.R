#
#
# FILE: plot2.R
#
#
# DESCRIPTION: This script outputs a series of graphs that will help us find patterns in data and understand its properties. Our goal is simply to examine how household energy usage varies over a 2-day period in February, 2007.
#
#


library(dplyr)
library(lubridate)


#########################################
# 1. Download and upzip the data folder #
#########################################


# Download zip file from the website provided in the README.md
zipurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.txt"

if(!file.exists(zipfile)) {
  download.file(zipurl, zipfile, mode = "wb")
}

# Unzips file
if(!file.exists(zipfile)) {
  upzip(zipfile)
}


#############################################################
# 2. Reads a subset of the data file and cleans up data file#
#############################################################


# a. Initial reading into R
epc <- read.table(zipfile, na.strings = "?", sep = ";", skip = 66638, nrows = 3000)

# b. Combine the Date and Time columns
epc$DateTime <- paste(epc$V1, epc$V2)
epc <- select(epc, DateTime, everything())
epc$V1 <- dmy(epc$V1)

# c. Change dates and times to POSIXct class
epc$DateTime <- strptime(epc$DateTime, format = "%d/%m/%Y %H:%M:%S")

# d. Subset epc from 2007-02-01 to 2007-02-02
epcFinal <- subset(epc, DateTime >= "2007-02-01 00:01:00" & DateTime <= "2007-02-02 23:59:00")

# e. Insert header names
names(epcFinal) <- c("Date & Time", "Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


######################
# 3. Creating plot 2 #
######################


plot(epcFinal$`Date & Time`,epcFinal$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")


##################################
# 4. Copy the plot to a PNG file #
##################################


dev.copy(png, file = "plot2.png")

dev.off()



