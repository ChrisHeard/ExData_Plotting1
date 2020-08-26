setwd("C:/Users/Chris/Documents/R Course/Exploratory Analysis/ExData_Plotting1")
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

par(mfrow=c(2,2),mar=c(1.5,3.9,1.5,0.8), oma=c(1,0,0,0))

with(days,{plot(as.numeric(Global_active_power)~Datetime,type='l',
     col="black",
     main="",
     ylab = "Global active power",
     xlab = "")
})

with(days,{plot(as.numeric(Voltage)~Datetime,type='l',
                col="black",
                main="",
                ylab = "Voltage",
                xlab = "")
})

with(days, {
  plot(Sub_metering_1~Datetime, type="l",
       col="Black",
       xlab="",
       ylab="Energy sub metering")
  
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  
})
legend("topright", 
       bty="n",
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, 
       lwd=2)

with(days,{plot(as.numeric(Global_reactive_power)~Datetime,type='l',
                col="black",
                main="",
                ylab = "Global reactive power",
                xlab = "")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
