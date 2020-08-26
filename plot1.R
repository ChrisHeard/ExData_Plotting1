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

# Plots

with(days,{hist(as.numeric(Global_active_power),15,col="red",
     main="Global Active Power",
     xlab = "Global active power(kilowatts)")
  })


dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
