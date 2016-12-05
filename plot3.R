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

# select just the Date, Time, and the 3 sub-metering columns
df2 <- select(df, c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))

# select just the desired date range
df2 <- filter(df2, Date == "1/2/2007" | Date == "2/2/2007")

# convert values to allow date/numeric operations
df2$DateTime <- as.POSIXct(paste(df2$Date, df2$Time), format="%d/%m/%Y %H:%M:%S")
df2$Sub_metering_1 <- as.numeric(df2$Sub_metering_1)
df2$Sub_metering_2 <- as.numeric(df2$Sub_metering_2)
df2$Sub_metering_3 <- as.numeric(df2$Sub_metering_3)



# now to build the image:
# open the graphics device
print("Creating image...")
png(filename = "plot3.png")

# create the plot
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
  col = c("black","red","blue"), lty = 1
)

#close the file
dev.off()
print("Done!")

