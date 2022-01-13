###'------------Coonvertir información de RAIN4PE diaria a una serie acumulada mensual----------

#' @author Crhistian Cornejo 

rm(list = ls())
dev.off()

####'-----Instalar paquetes necesarios----
pkg <- c("lubridate", "dplyr")

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
library(lubridate)
setwd("C:/Users/Young/OneDrive/Escritorio/RAIN4PE_Extract")
###' Cargamos los datos

data <- read.csv("Resultados/RAIN4PE_TUMBES_BASIN.csv", sep=";")

data_new1 <- data                                   # Duplicate data
data_new1$year <- strftime(data_new1$date, "%Y")    # Create year column
data_new1$month <- strftime(data_new1$date, "%m")   # Create month column

data_aggr1 <- aggregate(value ~ month + year,       # Aggregate data
                        data_new1,
                        FUN = sum)

data_new2 <- data                                   # Duplicate data
data_new2$year_month <- floor_date(data_new2$date,  # Create year-month column
                                   "month")

data_aggr2 <- data_new2 %＞%                         # Aggregate data
  group_by(year_month) %＞% 
  dplyr::summarize(value = sum(value)) %＞% 
  as.data.frame()
