##---------------------- RAIN4PE EXTRACT AREAL PP------------------##
#' @author Crhistian Cornejo 

rm(list = ls())
dev.off()

####' Instalar paquetes necesarios
pkg <- c("dplyr", "raster", "ncdf4", "rgdal", "lattice", "latticeExtra", "sp")

sapply(
  pkg,
  function(x) {
    is.there <- x %in% rownames(installed.packages())
    if (is.there == FALSE) {
      install.packages(x, dependencies = T)
    }
  }
)

####' cargamos los paquetes
library(dplyr)
library(ncdf4)
library(raster)
library(sp)
library(rgdal)
library(lattice)
library(latticeExtra)


####' seteamos directorio de trabajo

setwd('D:/RAIN4PE_daily_extract')
getwd()

####'---------------LEEMOS ARCHIVO NETCDF----------------------------

rain4pe.brick = brick("data/RAIN4PE_daily_0.1d_1981_2015_v1.0.nc")  
rain4pe.brick
nlayers(rain4pe.brick)
spplot(rain4pe.brick[[1:12]]) #mostramos ploteo simple de RAIN4PE para el a?o 1981


###' Extraemos la informacion en la cuenca

shp.wgs <- readOGR(dsn = "data", layer = "Tumbes_Basin")
plot(shp.wgs, col= "blue", main = "Cuenca Tumbes", axes=T, asp=1) #ploteo simple de la cuenca
shpRp   = spTransform(shp.wgs, proj4string(rain4pe.brick))
#View(shp.wgs@data)

pp.cuenca.daily <- extract(rain4pe.brick, shpRp, fun=mean)
pp.cuenca.daily
# row.names(pp.cuenca.daily) <- shpRp@data&NOMB_UH_N4
range(pp.cuenca.daily)
plot(pp.cuenca.daily[1,], type = "l", col= "blue", ylim= c(0, 130), ylab = "Precipitacion (mm/día)",
    xlab = "Dias", main= "Precipitacion Media Areal en la cuenca Tumbes (mm)")
write.csv(t(pp.cuenca.daily), "RAIN4PE_TUMBES_BASIN.csv")


###' ----- AHORA CORTAMOS EL RASTER A LA CUENCA y PLOTEAMOS LA PP MEDIA---------------------
r.tumbes <- crop(rain4pe.brick[[1:12]], shpRp, snap= 'out')
plot(r.tumbes)
r.tumbes <- mask(r.tumbes, shpRp)
names(r.tumbes)
names(r.tumbes) <- month.abb
plot(r.tumbes)

spplot(r.tumbes,col.regions = rev(terrain.colors(100)),
       at=seq(-1,4,5), scales = list(draw=TRUE))+
       layer(sp.polygons(shpRp, lwd=1, col = "darkblue"))

###'-------------AHROA PLOTEAMOS DATOS A MENSUALES Y ANUALES-------------------------

library(hydroTSM)

#CARGAMOS LOS DATOS DIARIOS DEL CSV ANTES GAURDADO

rain_daily <- read.csv("RAIN4PE_TUMBES_BASIN.csv", sep = ";") #en sep cambian segun su formato csv "," ? ";" ? "tab"
names(rain_daily)
head(rain_daily)

#funcion para convertir caracteres y objetos de calsses "POSIxlt" y "POSIxct" que representan fechas y horas del calendario

date.rain_daily <- strptime(rain_daily$date, format = "%Y-%m-%d")
head(date.rain_daily)

#creamos la serie de tiempo 
dates.rain_daily=format(date.rain_daily, "%Y-%m-%d")

#time series bases
serie.diaria <- aggregate(rain_daily$pcp, by=list(dates.rain_daily), FUN=sum)
names(serie.diaria)
names(serie.diaria) <- c("dates.rain_daily", "Precipitacion")
serie.diaria$dates.rain_daily=as.Date(serie.diaria$dates.rain_daily, "%Y-%m-%d")

plot(date.rain_daily, rain_daily$pcp, xlab="Años", ylab = "Precipitacion mm", col = "blue",
     type = "l")

#convertirmos a serie zoo
serie.diaria.ts = zoo(serie.diaria$Precipitacion, order.by = serie.diaria$dates.rain_daily)

#Ahora ploteamos la serie diaria, mensual y anual

hydroplot(serie.diaria.ts, var.type = "Precipitation", var.unit = "mm",
          xlab = "A?os", ylab= "Precipitacion en mm")

