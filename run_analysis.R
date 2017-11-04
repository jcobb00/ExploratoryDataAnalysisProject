#install dplyr
if(!"dplyr" %in% rownames(installed.packages())) {install.packages("dplyr")}

#load dplyr
if(!"dplyr" %in% rownames(.packages())) {library(dplyr)}

#install tidyr
if(!"tidyr" %in% rownames(installed.packages())) {install.packages("tidyr")}

#load tidyr
if(!"tidyr" %in% rownames(.packages())) {library(tidyr)}

#install lubridate
if(!"lubridate" %in% rownames(installed.packages())) {install.packages("lubridate")}

#load lubridate
if(!"lubridate" %in% rownames(.packages())) {library(lubridate)}

#install files to
getwd()

#create directory
if(!file.exists("./data/power")) {dir.create("./data/power")}

#download data (zip)
if(!file.exists("./data/power/power.zip")) {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./data/power/power.zip")}

#unzip data
if(!file.exists("./data/power/household_power_consumption.txt")){unzip("./data/power/power.zip",exdir = "./data/power")}

#check file size
file.size("./data/power/household_power_consumption.txt")/1073741824

#load table
data <- read.table("./data/power/household_power_consumption.txt", header = TRUE,sep=";", na.strings = "?", skipNul = TRUE )

#format date and time
data$Time <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

#format date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#filter dates
powerdata <- filter(data, Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

#open png
png(file = "plot1.png")

#plot 1
hist(powerdata$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

#close png
dev.off()

#open png
png(file = "plot2.png")

#plot 1
plot(powerdata$Time ,powerdata$Global_active_power, type = "l", xlab = '', ylab = "Global Active Power (kilowatts)")

#close png
dev.off()

#open png
png(file = "plot3.png")

#plot 2
plot(powerdata$Time,  powerdata$Sub_metering_1, type = "l", xlab = '', ylab = "Energy sub metering")
  lines(powerdata$Time, powerdata$Sub_metering_2, col="Red")
  lines(powerdata$Time, powerdata$Sub_metering_3, col="Blue")
  legend("topright",lty=1,col = c("black","red","blue"),legend=(c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
  
#close png
dev.off()

#open png
png(file = "plot4.png", length = 480, width = 480)

#plot 4
par(mfrow = c(2,2),lwd = .1)
with(powerdata, {
  plot(Time, Global_active_power, type = "l", xlab = '', ylab = "Global Active Power")
  plot(Time, Voltage, type = "l", xlab = 'datetime', ylab = "Voltage")
plot(powerdata$Time,  powerdata$Sub_metering_1, type = "l", xlab = '', ylab = "Energy sub metering")
  lines(powerdata$Time, powerdata$Sub_metering_2, col="Red")
  lines(powerdata$Time, powerdata$Sub_metering_3, col="Blue")
  legend("topright",lty=1,col = c("black","red","blue"),bty = "n",legend=(c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
  plot(Time, Global_reactive_power, type = "l", xlab = 'datetime', ylab = "Global_reactive_power")
})

#close png
dev.off()
