# load packages
library(data.table)
library(dplyr)
library(lubridate)

# download data if needed
if (!dir.exists('./data')) {dir.create('./data')}

if (!file.exists('./data/electricpowerconsumption.zip')) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,'./data/electricpowerconsumption.zip')
  unzip('./data/electricpowerconsumption.zip',exdir = './data')
}

# read data file
powerconsumption <- fread('./data/household_power_consumption.txt', na.strings = '?')

# clean and subset data frame
powerconsumption <- powerconsumption %>%
  mutate(Date = dmy(Date)) %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

# plot to png
png("plot1.png")
hist(powerconsumption$Global_active_power,main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 'red')
dev.off()