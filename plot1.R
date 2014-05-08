workdir <- "C:/Users/aahumada.SA/MatLab/RStudio/ExData_Plotting1"

src1    <- paste(workdir,"household_power_consumption.txt" , sep = "/")

setwd(workdir)

#------------------------------------------
#   LOAD DATA SOURCE
#------------------------------------------
#     Date                  : Date in format dd/mm/yyyy
#     Time                  : time in format hh:mm:ss
#     Global_active_power   : household global minute-averaged active power (in kilowatt)
#     Global_reactive_power : household global minute-averaged reactive power (in kilowatt)
#     Voltage               : minute-averaged voltage (in volt)
#     Global_intensity      : household global minute-averaged current intensity (in ampere)
#     Sub_metering_1        : energy sub-metering No. 1 (in watt-hour of active energy). 
#                             It corresponds to the kitchen, containing mainly a dishwasher, 
#                             an oven and a microwave (hot plates are not electric but gas powered).
#     Sub_metering_2        : energy sub-metering No. 2 (in watt-hour of active energy). 
#                             It corresponds to the laundry room, containing a washing-machine, 
#                             a tumble-drier, a refrigerator and a light.
#     Sub_metering_3        : energy sub-metering No. 3 (in watt-hour of active energy). 
#                             It corresponds to an electric water-heater and an air-conditioner.
#------------------------------------------
# EXAMPLE
#------------------------------------------
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

data <- read.table(src1
                   , header=TRUE
                   , sep=";"
                   , colClasses = "character"
)

#
# Generate datetime, convert to date and numeric
#
data$dt  <- strptime(paste(data[,1],data[,2]),"%d/%m/%Y %H:%M:%S")
data[,1] <- as.Date(  data[,1], "%d/%m/%Y")
for ( i in c(3:9) ) { data[,i] <- as.numeric(data[,i]) }

#
# Subset from 2007-02-01 to 2007-02-02
#
d.ini    <- as.Date("2007-02-01")
d.end    <- as.Date("2007-02-02")
cond     <- data$Date >= d.ini & data$Date <= d.end

#------------------------------------------
# DRAW GRAPHICS
#------------------------------------------

png( file   ="plot2.png"
     ,width  = 504
     ,height = 504 
     ,bg     = "transparent"
) 
  opar <- par(no.readonly=TRUE)
  
  with(subset(data, cond ) , 
       hist(Global_active_power
            , col="red"
            , main="Global Active Power"
            , xlab="Global Active Power (kilowatts)"
            , ylab="Frequency"
            , xlim=c(0,6)
            , ylim=c(0, 1200)
       )
  )
  
  par(opar)

dev.off()

