###'------------PROMEDIOS MULTIANUALES MENSUALES Y CÁLCULO DE ANOMALIAS EN LA CUENCA----------

#' @author Crhistian Cornejo 

rm(list = ls())
dev.off()

####'-----Instalar paquetes necesarios----
pkg <- c("bindr", "bindrcpp", "bitops")

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
library(bindr)
library(bindrcpp)
library(bitops)
setwd("C:/Users/Young/OneDrive/Escritorio/RAIN4PE_Extract")
###' Cargamos los datos

ppm <- read.csv("Resultados/RAIN4PE_MONTHLY_TUMBES_BASIN.csv", sep=";")

#calculamos promedios mensuales multianuales 
ppm2 <- ppm[,2:13] #extraer solo los datos, no los años
prom.ppm <- colMeans(ppm2)
prom.ppm
plot(prom.ppm, col = "darkblue", type = "o", xlab="meses", ylab = "mm",
     main = "distribucion mensual promedio areal de la cuenca Tumbes", lwd = 3)

#calculamos valores anuales
ppm2$Acumulado <- rowSums(ppm2)
prom_anual <- mean(ppm2$Acumulado)

#anomalias
ppm2$Anomalias <- ((ppm2$Acumulado - prom_anual)/prom_anual)*100
Anomalia <-  round(ppm2$Anomalias,0)
plot.Anomalia <- barplot(ppm2$Anomalias, xlab = "años", ylab = "%",
                         main = "Anomalias anuales de precipitacion en la cuenca Tumbes",
                         col = ifelse(ppm2$Anomalias >0, "darkblue", "red"), names.arg = ppm$AÑO)
text(plot.Anomalia,0, Anomalia, pos=ifelse(Anomalia>0,3,1))
