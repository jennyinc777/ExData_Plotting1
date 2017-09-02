#
#
# FILE: plot1.R
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

# b. Change dates and times to POSIXct class
epc$V1 <- dmy(epc$V1)
epc$V2 <- hms(epc$V2)

# c. Subset epc from 2007-02-01 to 2007-02-02
epcFinal <- subset(epc, V1 >= "2007-02-01" & V1 <= "2007-02-02")

# d. Insert header names
names(epcFinal) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")


######################
# 3. Creating plot 1 #
######################


hist(epcFinal$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")


##################################
# 4. Copy the plot to a PNG file #
##################################


dev.copy(png, file = "plot1.png")

dev.off()



