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

# Plot 2
with(HousePowerData, plot(Global_active_power, type = "l", xaxt = "n"))
lablist <- c("Thu", "Fri", "Sat")
axis(1, at = c(0,1440,2880), labels = lablist)
dev.copy(png, file = "Plot2.png") 
dev.off() 
