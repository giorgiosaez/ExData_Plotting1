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

datass$Timed=strptime(paste(as.character(datass$Dated)
                            ,as.character(datass$Time),sep=" ")
                            ,format="%Y-%m-%d %H:%M")
sub1 <- as.numeric(as.character(na.omit(datass$Sub_metering_1)))
sub2 <- as.numeric(as.character(na.omit(datass$Sub_metering_2)))
sub3 <- as.numeric(as.character(na.omit(datass$Sub_metering_3)))
power <- as.numeric(as.character(na.omit(datass$Global_active_power)))
reactive <-as.numeric(as.character(na.omit(datass$Global_reactive_power)))
  voltage<-as.numeric(as.character(na.omit(datass$Voltage)))

  png("Plot4.png",bg="white")
  par(mfcol=c(2,2))
  plot(datass$Timed, power,
     ylab = "Global Active power (kilowatts)",xlab = "",
     type = "l")

with(datass,plot(Timed, sub1, 
                 ylab = "Energy sub metering",xlab = "",
                 type = "l"))
with(datass, points(Timed, sub1, col = "black",type = "l"))
with(datass, points(Timed, sub2, col = "Red",type = "l"))
with(datass, points(Timed, sub3, col = "Blue",type = "l"))
legend("topright", lty=c(1,1,1),bty = "n", col = c("Black","Red","Blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(datass$Timed, voltage, ylab = "Voltage", xlab = "datetime",type = "l")
plot(datass$Timed, reactive,ylab="Global_reactive_power", xlab = "datetime",type = "l")

#dev.copy(png, "plot4.png",width = 480, height = 480)
dev.off()
