#install dplyr
if(!"dplyr" %in% rownames(installed.packages())) {install.packages("dplyr")}

#load dplyr
if(!"dplyr" %in% rownames(.packages())) {library(dplyr)}

#install tidyr
if(!"tidyr" %in% rownames(installed.packages())) {install.packages("tidyr")}

#load tidyr
if(!"tidyr" %in% rownames(.packages())) {library(tidyr)}

#create directory
if(!file.exists("./data/power")) {dir.create("./data/power")}

#download data (zip)
if(!file.exists("./data/power/power.zip")) {download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./data/power/power.zip")}

#unzip data
if(!file.exists("./data/power/household_power_consumption.txt")){unzip("./data/power/power.zip",exdir = "./data/power")}

#check file size
file.size("./data/power/household_power_consumption.txt")/1073741824

#load table
data <- read.table("./data/power/household_power_consumption.txt", header = TRUE,sep=";",nrows=10000)

1+1

