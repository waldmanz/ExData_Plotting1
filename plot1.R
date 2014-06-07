# Course Project 1: Plot 1
# Exploratory Data Analysis
# June 2014

# Dataset for project is "household_power_consumption.txt"
#  in working directory, delimited with ';', with headers, ? for NA
# Column 1 - Date - in format %d/%m/%Y  (4 digit year)
# Column 2 - Time - in format %H:%M:%S  (hour in 24 hour format)
# Columns 3-9 are numeric

myfile <- "household_power_consumption.txt"

# read entire dataset at once
mydata <- read.table(myfile, header = TRUE,
                     sep=";", na.strings = "?", stringsAsFactors = FALSE,
                     comment.char = "")


# subset for dates of interest (still as strings)
mydates = c('1/2/2007', '2/2/2007')
mydata <- mydata[mydata$Date %in% mydates,]

# create new variable datetime in dataframe which is POSIXlt class
datetimestring <- paste(mydata$Date, mydata$Time)
mydata$datetime <- strptime(datetimestring, format = "%d/%m/%Y %H:%M:%S")

# convert Date column to Date format
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")

attach(mydata)

# make first plot
png(file = "plot1.png", width=480, height=480, bg = "transparent")

hist(Global_active_power, main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     col = 'red')

dev.off()
