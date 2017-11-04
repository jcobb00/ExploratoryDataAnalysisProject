#get wd
getwd()

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
data <- filter(data, Date == as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

#open png
png(file = "plot1.png")

#plot 1
hist(data$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

#close png
dev.off()
