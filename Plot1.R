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
##1.1 Reubicamos el directorio de trabajo porque se crean las gráficas donde está
##    el archivo que contiene los datos para trabajar.
getwd()
##1.2 
Data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
subSetData <- Data[Data$Date %in% c("1/2/2007","2/2/2007") ,]
subSetData$Date <- as.Date(subSetData$Date, format = "%d/%m/%Y")
#str(subSetData)
Global_active_power <- as.numeric(subSetData$Global_active_power)
png("Plot1.png", width=480, height=480)
hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()