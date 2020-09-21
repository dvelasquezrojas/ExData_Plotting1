##0. Descargar y leer los archivos.
################################################################################
##0.1 Traemos el conjunto de datos arrojado en la web.Para esto le asignamos un nombre.
getwd()
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##0.2 Ubicamos el directorio en el que estamos trabajando y le asignamos un nombre
##    para llamarlo más rápidamente cuando descarguemos el archivo.
path <- getwd()
##0.3 Descargamos el arhivo y lo ubicamos en el directorio donde vamos a trabajar.
download.file(dataurl, file.path(path, "household_power_consumption.zip"))
##0.4 Descomprimimos el archivo en el directorio donde se est? trabajando.
unzip(zipfile = "household_power_consumption.zip")
################################################################################
##1. Leer los datos
################################################################################
library("data.table")
Data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
subSetData <- Data[Data$Date %in% c("1/2/2007","2/2/2007") ,]
################################################################################
##2. Elaborar la gráfica
################################################################################
Date <- strptime(paste(subSetData$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Global_active_power <- as.numeric(subSetData$Global_active_power)
Global_reactive_power <- as.numeric(subSetData$Global_reactive_power)
Voltage <- as.numeric(subSetData$Voltage)
sub_Metering_1 <- as.numeric(subSetData$Sub_metering_1)
sub_Metering_2 <- as.numeric(subSetData$Sub_metering_2)
sub_Metering_3 <- as.numeric(subSetData$Sub_metering_3)
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(Date, Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(Date, sub_Metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(Date, sub_Metering_2, type="l", col="red")
lines(Date, sub_Metering_3, type="l", col="blue")
legend("Topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(Date, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()