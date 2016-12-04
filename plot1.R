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
df <- read.table(
  "household_power_consumption.txt",header=TRUE,sep=";",colClasses="character"
)

# select just the Date and Global Active Power columns
df2 <- select(df, c(Date, Global_active_power))

# select just the desired date range
df2 <- filter(df2, Date == "1/2/2007" | Date == "2/2/2007")

# convert metric to numeric
df2$Global_active_power <- as.numeric(df2$Global_active_power)



# now to build the image:
# open the graphics device
print("Creating image...")
png(filename = "plot1.png")

# create the plot
hist(
  df2$Global_active_power, 
  col="red", 
  main="Global Active Power", 
  xlab="Global Active Power (kilowatts)"
)

#close the file
dev.off()
print("Done!")

