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

#Plot 1
png("Plot1.png", height = 480, width = 480)
with(HousePowerData, hist(Global_active_power, col = "red", main=title("Global Active Power"), xlab = "Global Active Power(kW)", ylab = "Frequency"))
dev.off()

