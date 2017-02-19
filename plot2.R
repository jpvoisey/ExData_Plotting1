#load sqldf package, required for read.csv.sql
library(sqldf)

#Only read lines with required date, using SQL select command
#read.csv.sql uses sqlite, which is unable to convert single digit day of month dates. So Date is treated as a string
house_pow_cons <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")


#Convert date-character to date-class
house_pow_cons$Date = as.Date(strptime(house_pow_cons$Date, "%d/%m/%Y"))

#Add DateTime Column
house_pow_cons$DateTime = as.POSIXct(paste(house_pow_cons$Date, house_pow_cons$Time))

#Instruct plot to be saved to a png file
png("plot2.png")

#Plot Line Graph of Global Active Power
with(house_pow_cons,plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#Close png file to save it
dev.off()
