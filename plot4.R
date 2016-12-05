# load required package
library(dplyr)

# download and unzip the file
print("Downloading file...")
download.file(
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  "power_consumption.zip"
)

print("Unzipping file...")
unzip("power_consumption.zip")

# now there's a data file in the working dir called "household_power_consumption.txt"
# read the file into R
print("Reading data...")

# we set the colClasses to character to avoid quirks of dealing w/factors
df <- read.table(
  "household_power_consumption.txt",header=TRUE,sep=";",colClasses="character"
)

# select just the desired date range
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")


# convert values to allow date/numeric operations
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)



# now to build the image:
# open the graphics device
print("Creating image...")
png(filename = "plot4.png")

# configure the device
par(mfcol = c(2,2), mar = c(5,4,1,2))

# create the plot
# 1st plot
plot(
  df$DateTime, 
  df$Global_active_power, 
  type = "l", 
  xlab = NA, 
  ylab = "Global Active Power"
)


# 2nd plot
# use Sub_metering_1 to set the format, as it has the widest range of values
plot(
  df2$DateTime, 
  df2$Sub_metering_1, 
  type = "n", 
  xlab = NA, 
  ylab = "Energy sub metering"
)

# now add the line for each variable
lines(df2$DateTime, df2$Sub_metering_1)
lines(df2$DateTime, df2$Sub_metering_2, col = "red")
lines(df2$DateTime, df2$Sub_metering_3, col = "blue")

# add legend
legend(
  "topright", 
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col = c("black","red","blue"), lty = 1, cex = 0.9
)


# 3rd plot
plot(
  df$DateTime, 
  df$Voltage, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Voltage"
)


# 4th plot
plot(
  df$DateTime, 
  df$Global_reactive_power, 
  type = "l", 
  xlab = "datetime", 
  ylab = "Voltage"
)



#close the file
dev.off()
print("Done!")

