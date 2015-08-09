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
finalDates <- as.numeric(as.character(na.omit(data$Global_active_power[data$Dated == "2007-02-01"| data$Dated == "2007-02-02"])))
hist(finalDates, col = "red", main = "Global Active power", xlab = "Global Active power (kilowatts)", ylim = c(0,1200))

dev.copy(png, "plot1.png",width = 480, height = 480)
dev.off()
