data <- data.table::fread("household_power_consumption.txt")

# Converting $Date to date format.

data$Date <- as.Date(data$Date,"%d/%m/%Y")

# Splitting the data into desired format i.e. 2 consecutive days in February 2007.

months <-split(data, format(data$Date, "%Y/%m"))
rm(data)
feb <- months[[3]]
rm(months)
days <- split(feb,feb$Date)
rm(feb)
days <- rbind(days[[1]],days[[2]])


datetime <- paste(as.Date(days$Date), days$Time)
days$Datetime <- as.POSIXct(datetime)

# Plots

with(days, {
  plot(Sub_metering_1~Datetime, type="l",
       col="Black",
       xlab="",
       ylab="Global Active Power (kilowatts)")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()