# Course Project 1: Plot 4
# Exploratory Data Analysis
# June 2014


# Dataset for project is "household_power_consumption.txt"
#    in working directory, delimited with ';', with headers, ? for NA
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

# make fourth plot
png(file = "plot4.png", width=480, height=480, bg = "transparent")

op <- par(mfcol = c(2,2))  # save old params

plot(datetime, Global_active_power, type='l',
     xlab = '', ylab = 'Global Active Power')

plot(datetime, Sub_metering_1, type='l',
     xlab = '', ylab = 'Energy sub metering')
lines(datetime, Sub_metering_2, col='red')
lines(datetime, Sub_metering_3, col='blue')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2",
                            "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = 1,
       bty = 'n')  # no box around legend

plot(datetime, Voltage, type='l')

plot(datetime, Global_reactive_power, type='l')

par(op)  # go back to previous par settings
dev.off()


