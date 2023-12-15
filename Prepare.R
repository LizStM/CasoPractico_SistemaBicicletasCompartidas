#================================================
# ORDENAR DATOS Y COMBINAR EN UN ARCHIVO UNICO
#================================================

# Instalación e importación de librerias
install.packages("tidyverse")
install.packages("lubridate")

library(tidyverse)
library(lubridate)

# Carga de datos por cada mes
nov22 <- read.csv('202211-divvy-tripdata.csv')
dic22 <- read.csv('202212-divvy-tripdata.csv')
ene <- read.csv('202301-divvy-tripdata.csv')
feb <- read.csv('202302-divvy-tripdata.csv')
mar <- read.csv('202303-divvy-tripdata.csv')
abr <- read.csv('202304-divvy-tripdata.csv')
may <- read.csv('202305-divvy-tripdata.csv')
jun <- read.csv('202306-divvy-tripdata.csv')
jul <- read.csv('202307-divvy-tripdata.csv')
agto <- read.csv('202308-divvy-tripdata.csv')
sep <- read.csv('202309-divvy-tripdata.csv')
oct <- read.csv('202310-divvy-tripdata.csv')

# str(nov22)
# summary(nov22)
# head(nov22)
# str(feb)
# Los conjuntos de datos contienen el mismo tipo de datos en cada campo

# Encontrar posibles diferencias en los nombres de las columnas para cada dataFrame
setdiff(colnames(nov22), colnames(dic22))
setdiff(colnames(nov22), colnames(ene))
setdiff(colnames(nov22), colnames(feb))
setdiff(colnames(nov22), colnames(mar))
setdiff(colnames(nov22), colnames(abr))
setdiff(colnames(nov22), colnames(may))
setdiff(colnames(nov22), colnames(jun))
setdiff(colnames(nov22), colnames(jul))
setdiff(colnames(nov22), colnames(agto))
setdiff(colnames(nov22), colnames(sep))
setdiff(colnames(nov22), colnames(oct))
# No existen diferencias de nommbres entre los conjuntos.

# Unir en un solo conjunto todos los meses
bicicletas <- bind_rows(nov22,dic22,ene,feb,mar,abr,may,jun,jul,agto,sep,oct)
str(bicicletas)

# Seleccionar columnas que se ocuparan. Quitar (latitud, longitud y id de las estaciones)
bicicletas2 <- select(bicicletas, -start_lat, -start_lng, -end_lat, -end_lng, -start_station_id, -end_station_id)

# Eliminar filas con NAs
drop_na(bicicletas2)
str(bicicletas2)

# Guardar como csv a bicicletas2 
# (Para evitar el coste computacional posterior, al abrir una nueva sesion con el proyecto)
write.csv(bicicletas2, "bicicletas.csv")

