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
  filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(DateTime = ymd_hms(paste(Date,Time)))

#plotting to png
png("plot3.png")
with(powerconsumption,{
  plot(DateTime, Sub_metering_1, xlab = "", ylab= "Energy sub metering", type = 'n',xaxt = 'n')
  points(DateTime, Sub_metering_1, type= 'l')
  points(DateTime, Sub_metering_2, type= 'l',col= 'red')
  points(DateTime, Sub_metering_3, type= 'l',col= 'blue')
})
names <- names(powerconsumption)[7:9]
legend('topright', lty = 1,col = c("black","red","blue"), legend = names)

# adjusting x axis to give weekdays
r <- as.POSIXct(round(range(powerconsumption$DateTime), "days"))
s <- seq(r[1],r[2],by="days")
axis(1, at= s, labels =  c("Thu","Fri","Sat"))

dev.off()