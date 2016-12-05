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

# select just the Date, Time, and Global Active Power columns
df <- select(df, c(Date, Time, Global_active_power))

# select just the desired date range
df <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")

# convert values to allow date/numeric operations
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)


# now to build the image:
# open the graphics device
print("Creating image...")
png(filename = "plot2.png")

# create the plot
plot(
  df$DateTime, 
  df$Global_active_power, 
  type = "l", 
  xlab = NA, 
  ylab = "Global Active Power (kilowatts)"
)

#close the file
dev.off()
print("Done!")

