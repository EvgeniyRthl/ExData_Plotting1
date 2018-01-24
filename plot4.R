# Downloading the "Individual household electric power consumption Data Set"

if(!file.exists("./Exploratory Data Analysis")){dir.create("./Exploratory Data Analysis")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./Exploratory Data Analysis/Houshold_power_consumption.zip")

# Unzipping the dataset file

setwd("./Exploratory Data Analysis")
unzip('Houshold_power_consumption.zip')

# Reading the dataset

dataFile<-"household_power_consumption.txt"
power_consumption<-read.table(dataFile, sep = ";",dec = ".", na.strings = "?", header = TRUE , stringsAsFactors=FALSE)

power_consumption$Date<-as.Date(power_consumption$Date, format="%d/%m/%Y")

# Subsetting the data

PowConsSubset <- subset(power_consumption, power_consumption$Date=="2007-02-01" | power_consumption$Date=="2007-02-02")

PowConsSubset$DateTime <- paste(PowConsSubset$Date, PowConsSubset$Time)
PowConsSubset$DateTime <-strptime(PowConsSubset$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Setting device and plotting

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

with(PowConsSubset, {
        
        plot(DateTime, Global_active_power, ylab = "Global Active Power", type = "l")
        plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
        plot(DateTime, Sub_metering_1, col="black", type = "l", xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_2, col="red", type = "l")
        lines(DateTime, Sub_metering_3, col="blue", type = "l")
        legend("topright", bty ="n", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))
        plot(DateTime, Global_reactive_power, xlab = "datetime", ylab = " Global_reactive_power", type = "l")
})

dev.off()