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
png("plot3.png")

#Plot Line Graph of Sub_metering_1
with(house_pow_cons,plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))

#Plot Line Graph of Sub_metering_2 in red
with(house_pow_cons,lines(DateTime, Sub_metering_2, type = "l", xlab = "", col = "red"))

#Plot Line Graph of Sub_metering_3 in blue
with(house_pow_cons,lines(DateTime, Sub_metering_3, type = "l", xlab = "", col = "blue"))

#Add legend
legend(legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, x = "topright")

#Close png file to save it
dev.off()
