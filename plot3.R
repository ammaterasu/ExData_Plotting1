#download file

fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileurl,destfile="./data/household_power_consuption.zip")

fullData <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?")

## filter dataset from Feb. 1, 2007 to Feb. 2, 2007

finalData <- subset(fullData, Date %in% c("1/2/2007","2/2/2007"))
finalData$Date <- as.Date(finalData$Date, format="%d/%m/%Y")

# combine Date and Time column

datetime <- paste(as.Date(finalData$Date), finalData$Time)

# format datetime column

finalData$Datetime <- as.POSIXct(datetime)

##PLOT 3

with(finalData, {
  plot(Sub_metering_1~Datetime, type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~Datetime, col = 'red')
  lines(Sub_metering_3~Datetime, col = 'blue')
})
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = labels, col = columnlines, lty = "solid")

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
