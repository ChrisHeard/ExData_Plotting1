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

with(days,{plot(as.numeric(Global_active_power)~Datetime,type='l',
     col="black",
     main="",
     ylab = "Global active power(kilowatts)",
     xlab = "")
})

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

