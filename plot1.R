#load sqldf package, required for read.csv.sql
library(sqldf)

#Only read lines with required date, using SQL select command
#read.csv.sql uses sqlite, which is unable to convert single digit day of month dates. So Date is treated as a string
house_pow_cons <- read.csv.sql("household_power_consumption.txt", sep = ";", sql = "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'")

#This plot does not require date or time, so columns can be left as characters


#Instruct plot to be saved to a png file
png("plot1.png")

#Plot Histogram of Global Active Power
hist(house_pow_cons$Global_active_power, col = "red", 
        main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Close png file to save it
dev.off()
