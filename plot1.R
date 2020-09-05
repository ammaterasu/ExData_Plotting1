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

##PLOT 1

hist(finalData$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

