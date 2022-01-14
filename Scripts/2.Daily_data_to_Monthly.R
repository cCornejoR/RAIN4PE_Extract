#' ################################################################
# PROCESAMIENTO DE DATOS DIARIOS DE RAIN4PE A MENSUALES Y ANUALES
#'-------------- @author Crhistian Cornejo 
###################################################################

rm(list = ls())
dev.off()

####'-----Instalar paquetes necesarios----
pkg <- c("tidyverse", "ggplot2", "ggthemes", "dplyr")

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
library(tidyverse)
library(ggplot2)
library(ggthemes)
library(dplyr)

setwd("C:/Users/Young/OneDrive/Escritorio/RAIN4PE_Extract")
###' Cargamos los datos

data <- read.csv("Resultados/RAIN4PE_TUMBES_BASIN.csv", sep=";")
names(data) <- c("YEAR", "PRECIPITATION")
head(data)

data_diaria <- paste(data$YEAR, data$MES, data$DIA, sep = "-")
data$FECHA <- as.POSIXct(data_diaria, format = "%Y-%m-%d")

###' convertimos el valor de los datos diarios a mensuales

data$FECHAS_m <- format(data$FECHA, format = "%Y-%m")
pp_mensual <- aggregate(PRECIPITATION ~ FECHAS_m ,
                        data = data,FUN=sum)
write.csv(pp_mensual, "Resultados/RAIN4PE_MONTHLY_TUMBES_BASIN.csv")
#ahora a datos anuales

data$FECHAS_a <- format(data$FECHA, format = "%Y")
pp_anual <- aggregate(PRECIPITATION ~ FECHAS_a ,
                        data = data,FUN=sum)

write.csv(pp_anual, "Resultados/RAIN4PE_ANUAL_TUMBES_BASIN.csv")

#creamos un grafico con ggplot2 de la serie de datos
data_mensual <- data.frame(read.csv("Resultados/RAIN4PE_MONTHLY_TUMBES_BASIN.csv"))

p1_montlhy <- ggplot(data_mensual, aes(x = FECHAS_m, y = PRECIPITATION, group = 1))+geom_line(color = "steelblue", 
  size = 1,alpha=1.5, linetype = 6)+ggtitle("Precipitación media mensual en la cuenca Tumbes - Producto RAIN4PE periodo 1981 - 2015")+ 
  ylab("Precipitacion (mm)") + xlab("Tiempo")+ theme_stata()+theme(axis.text.x=element_text(angle=60, hjust=1))

p1_montlhy

data_anual <- data.frame(read.csv("Resultados/RAIN4PE_ANUAL_TUMBES_BASIN.csv"))

p2_anual <- ggplot(data_anual, aes(x = FECHAS_a, y = PRECIPITATION, group = 1))+
  geom_line(color = "steelblue", size = 1,alpha=1.5, linetype = 6)+ 
  ggtitle("Precipitación media anual en la cuenca Tumbes - Producto RAIN4PE periodo 1981 - 2015")+ 
  ylab("Precipitacion (mm)") + xlab("Tiempo")+ theme_stata()+theme(axis.text.x=element_text(angle=60, hjust=1))

p2_anual




# data_new1 <- data                                   
# data_new1$year <- strftime(data_new1$date, "%Y")    
# data_new1$month <- strftime(data_new1$date, "%m")   
# 
# data_aggr1 <- aggregate(value ~ month + year,       
#                         data_new1,
#                         FUN = sum)
# 
# data_new2 <- data                                   
# data_new2$year_month <- floor_date(data_new2$date,  
#                                    "month")
# 
# data_aggr2 <- data_new2 %＞%                         
#   group_by(year_month) %＞% 
#   dplyr::summarize(value = sum(value)) %＞% 
#   as.data.frame()
