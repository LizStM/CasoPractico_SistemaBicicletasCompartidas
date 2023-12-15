#=======================================
# PREPARAR PARA EL ANALISIS
#======================================
library(tidyverse)
library(lubridate)

# Carga del nuevo conjunto de datos
bicicletas <- read.csv('bicicletas.csv')
# Inspección
dim(bicicletas)
str(bicicletas)
summary(bicicletas)

# Encontrar datos únicos en las columnas 'rideable_type' y 'member_casual'
unique(bicicletas$rideable_type)#"electric_bike" "classic_bike"  "docked_bike"
unique(bicicletas$member_casual)#"member" "casual"
# Las categorias en cada campo son correctas

# Obtener mes y dias que se realizaron los viajes
bicicletas$fecha <- as.Date(bicicletas$started_at)
bicicletas$mes <- format(bicicletas$fecha, '%m')
bicicletas$dia <- format(bicicletas$fecha, '%d')
bicicletas$dia_semana <- format(bicicletas$fecha, "%A")
head(bicicletas)

# Obtener duración del viaje
bicicletas$duracion <- difftime(bicicletas$ended_at, bicicletas$started_at)
head(bicicletas)
str(bicicletas)
# Convertir a dato numerico la duracion del viaje
bicicletas$duracion <- as.numeric(bicicletas$duracion)
# Eliminar resultados negativos
bicicletas_2 <- bicicletas[!(bicicletas$duracion<0),]

# Guardar en un nuevo csv la ultima tabla
# Para evitar coste computacional en un nuevo inicio de sesión
write.csv(bicicletas_2, "bicicletasV2.csv")

