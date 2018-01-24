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

png(filename = "plot2.png", width = 480, height = 480)

with(PowConsSubset, plot(DateTime, Global_active_power, xlab = "", ylab = " Global Active Power (kilowatts)", type = "l"))

dev.off()
