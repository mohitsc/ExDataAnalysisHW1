setwd("C:/Users/Mohit Singh-Chhabra/Google Drive/Mohit/Data Science/ExploratoryDataAnalysis")
library(dplyr)
library(tidyr)
library(lubridate)

#ImportDataSet, only keep data for relevant dates, delete the rest
rawdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
rawdata$Date <- dmy(rawdata$Date)

HousePowerData <- tbl_df(filter(rawdata,Date== "2007-02-01"| Date =="2007-02-02")) %>% mutate(WeekDay = wday(Date, label = TRUE))%>% mutate(Time2 = hms(Time)) 
#remove(rawdata)

HousePowerData <- HousePowerData %>% mutate(Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power))


#Plot 4
png("Plot4.png")
par(mfrow = c(2,2))
with(HousePowerData, plot(Global_active_power, type = "l", xaxt = "n", ylab = "Global Active Power"))
lablist <- c("Thu", "Fri", "Sat")
axis(1, at = c(0,1440,2880), labels = lablist)

with(HousePowerData, plot(Voltage, type = "l", xaxt = "n", ylab = "Voltage", xlab = "datetime"))
lablist <- c("Thu", "Fri", "Sat")
axis(1, at = c(0,1440,2880), labels = lablist)

with(HousePowerData, plot(Sub_metering_1, type = "n", ylab = "Energy sub metering", xaxt = "n"))
with(HousePowerData, lines(Sub_metering_1, type = "l"))
with(HousePowerData, lines(Sub_metering_2, type = "l", col = "red"))
with(HousePowerData, lines(Sub_metering_3, type = "l", col = "blue"))
axis(1, at = c(0,1440,2880), labels = lablist)
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(HousePowerData, plot(Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime"))
lablist <- c("Thu", "Fri", "Sat")
axis(1, at = c(0,1440,2880), labels = lablist)

dev.off()
