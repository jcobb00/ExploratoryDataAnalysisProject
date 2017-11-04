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

#open plot 3
png(file = "plot3.png")

#plot 3
plot(powerdata$Time,  powerdata$Sub_metering_1, type = "l", xlab = '', ylab = "Energy sub metering")
  lines(powerdata$Time, powerdata$Sub_metering_2, col="Red")
  lines(powerdata$Time, powerdata$Sub_metering_3, col="Blue")
  legend("topright",lty=1,col = c("black","red","blue"),legend=(c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))
  
#close png
dev.off()
