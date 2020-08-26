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
d$Datetime <- as.POSIXct(datetime)

# Plots
lin<-1:dim(days)[1]
plot(as.numeric(days$Global_active_power)~lin,type='l',
     col="black",
     main="",
     ylab = "Global active power(kilowatts)")



