library("curl");

wd <-"~/R/exdata/ExData_Plotting1"
if(!file.exists(wd)){dir.create(wd)}
if (getwd()!=wd) {setwd(wd) }

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destzip<- "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip";
destfile <- "./data/household_power_consumption.txt"
if (!file.exists(destzip) ){
  download.file(fileUrl, destzip)
  unzip(destzip, exdir = "./data")
} 
data <- read.table(destfile, header = TRUE, sep = ';', dec = '.')
data$Dated = as.Date(data$Date,format("%d/%m/%Y"))

datass=subset(data, data$Dated == "2007-02-01"| data$Dated == "2007-02-02") 

datass$Timed=strptime(paste(as.character(datass$Dated),
                           as.character(datass$Time),sep=" ")
                     ,format="%Y-%m-%d %H:%M") 
power <- as.numeric(as.character(na.omit(datass$Global_active_power)))

plot(datass$Timed, power, #main = "Global Active power", 
     ylab = "Global Active power (kilowatts)",xlab = "",
     type = "l")

dev.copy(png, "plot2.png",width = 480, height = 480)
dev.off()