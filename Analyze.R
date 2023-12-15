#======================
# ANALISIS
#======================
library(tidyverse)
library(lubridate)
library(scales)

bicicletas2 <- read.csv('bicicletas_V5.csv')
#-----------------------------------------------------------------------
bicicletas2 <- select(bicicletas2, -X.1, -X)
bicicletas2 <- bicicletas2[!(bicicletas2$duracion==0),]
bicicletas2$año <- format(as.Date(bicicletas2$started_at), '%y')
bicicletas2$numSemana <- format(as.Date(bicicletas2$started_at), '%W')
bicicletas2$hora <- hour(bicicletas2$started_at)
#-----------------------------------------------------------------------
#write.csv(bicicletas2, "bicicletas_V5.csv")


# promedio, minimo y maximo de la duración de los viajes (sec) para todos los tipos de usuario
mean(bicicletas2$duracion)#1095.991
max(bicicletas2$duracion)#5909344
min(bicicletas2$duracion)#1

# comparación entre usuarios
aggregate(duracion ~ member_casual, data = bicicletas2, mean)
aggregate(duracion ~ member_casual, data = bicicletas2, max)
aggregate(duracion ~ member_casual, data = bicicletas2, min)


# promedio de duracion por día y por tipo de usuario
bicicletas2$dia_semana <- ordered(bicicletas2$dia_semana, 
                                    levels=c("lunes", "martes", "miércoles", "jueves",
                                             "viernes", "sábado", "domingo"))
aggregate(duracion ~ member_casual + dia_semana, data = bicicletas2, mean)
# member_casual dia_semana  duracion
#        casual      lunes 1663.7356
#        member      lunes  710.6805
#        casual     martes 1493.9057
#        member     martes  719.3415
#        casual  miércoles 1459.2078
#        member  miércoles  714.5920
#        casual     jueves 1503.2994
#        member     jueves  719.7347
#        casual    viernes 1653.5159
#        member    viernes  750.4657
#        casual     sábado 1942.0389
#        member     sábado  832.7176
#        casual    domingo 1996.8097
#        member    domingo  834.5583

# cantidad de viajes por tipo de usuario y dia de la semana
aggregate(duracion ~ member_casual + dia_semana, data = bicicletas2, FUN = length)
#member_casual dia_semana duracion
#        casual      lunes   233922
#        member      lunes   487098
#        casual     martes   251874
#        member     martes   582763
#        casual  miércoles   251800
#        member  miércoles   578311
#        casual     jueves   271051
#        member     jueves   576190
#        casual    viernes   311204
#        member    viernes   518453
#        casual     sábado   402140
#        member     sábado   456385
#        casual    domingo   332274
#        member    domingo   398225



#_______________________________________________________________________________________

#::::::::::::::::::::::::::::::::::::::::::::
# GRAFICOS
#::::::::::::::::::::::::::::::::::::::::::::

# 1 Duracion promedio de viajes por tipo de usuario cada dia
DuracionXdia <- bicicletas2 %>%
  group_by(member_casual, dia_semana) %>%
  summarise(numero_viajes = n(),
            promedio_duracion = mean(duracion)) %>%
  arrange(member_casual, dia_semana)

ggplot(data = DuracionXdia, 
       aes(x = dia_semana, y = promedio_duracion , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Dia de la semana",
       y = "Segundos",
       title = 'Duración promedio de los viajes', 
       subtitle = 'Por tipo de usuario y día de la semana') + 
  theme( axis.text.x  = element_text ( angle =  50 ),
         plot.title.position = 'plot',
         plot.title = element_text(size = 15,
                                   fac = 'bold'),
         plot.subtitle = element_text(size = 12,
                                   fac = 'bold',
                                   hjust = 0.15)) +
  scale_y_continuous(labels = label_number()) +
  scale_fill_discrete(NULL,labels = c("Casual", "Miembro"))

#_______________________________________________________________________________________

# 2 Numero de viajes por tipo de usuario cada dia
ggplot(data = DuracionXdia, 
       aes(x = dia_semana, y = numero_viajes , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Dia de la semana",
       y = "Conteo",
       title = 'Cantidad de viajes', 
       subtitle = 'Por tipo de usuario y día de la semana') + 
  theme( axis.text.x  = element_text ( angle =  50 ),
         plot.title.position = 'plot',
         plot.title = element_text(size = 15,
                                   face = 'bold'),
         plot.subtitle = element_text(size = 12,
                                      face = 'bold',
                                      hjust = 0.15),
         legend.position = "none") +
  scale_y_continuous(labels = label_number())

#_______________________________________________________________________________________

# 3 numero de viajes cada mes por tipo de usuario
conteo_mensual <- bicicletas2 %>%
  group_by(año, mes, member_casual) %>%
  summarise(num_viajes = n(),
            fecha = max(fecha))

ggplot(data = conteo_mensual, 
       aes(x = fecha, y = num_viajes, group = member_casual, color = member_casual)) + 
  geom_line() +
  labs(x = "Mes",
       y = "Conteo",
       title = 'Cantidad de viajes mensuales', 
       subtitle = 'noviembre 2022 - octubre 2023') + 
  theme( plot.title.position = 'plot',
         plot.title = element_text(size = 15,
                                   face = 'bold'),
         plot.subtitle = element_text(size = 12,
                                      face = 'bold',
                                      hjust = 0.15),
         legend.position = "none") +
  scale_x_discrete(label = c("nov 22", "dic", "ene 23", "feb", "mar", "abr",
                             "may", "jun", "jul", "agto", "sep", "oct23")) +
  scale_y_continuous(labels = label_number())

#_______________________________________________________________________________________

# 4 cantidad de viajes semanales por tipo de usuario
conteo_semanal <- bicicletas2 %>%
              group_by(año, numSemana, member_casual) %>%
              summarise(num_viajes = n(),
                        fecha = max(fecha))
            
ggplot(data = conteo_semanal, 
       aes(x = fecha, y = num_viajes, group = member_casual, color = member_casual)) + 
      geom_line() +
      labs(x = "Numero de semana",
           y = "Conteo",
           title = 'Cantidad de viajes semanales', 
           subtitle = 'semana 44 del 2022 - semana 44 del 2023') + 
      theme( axis.text.x  = element_text ( angle =  50 ),
             plot.title.position = 'plot',
             plot.title = element_text(size = 15,
                                       face = 'bold'),
             plot.subtitle = element_text(size = 12,
                                          face = 'bold',
                                          hjust = 0.15),
             legend.position = "none") +
      scale_x_discrete(label =  c(c(44:52),c(0:44))) +
      scale_y_continuous(labels = label_number())

#_______________________________________________________________________________________

# 5 Cantidad de viajes por hora del dia

conteo_hora <- bicicletas2 %>%
  group_by(hora, member_casual) %>%
  summarise(num_viajes = n())

ggplot(data = conteo_hora, 
       aes(x = as.factor(hora), y = num_viajes, group = member_casual, color = member_casual)) + 
  geom_line() +
  labs(x = "Hora del día",
       y = "Conteo",
       title = 'Cantidad de viajes por hora') + 
  theme( axis.text.x  = element_text ( angle =  50 ),
         plot.title.position = 'plot',
         plot.title = element_text(size = 15,
                                   face = 'bold'),
         legend.position = "none") +
  scale_x_discrete(label =  c(0:23)) +
  scale_y_continuous(labels = label_number())


#_______________________________________________________________________________________

# 6 Tipo de bicicleta por usuario
tipo_bici <- bicicletas2 %>%
  group_by(rideable_type, member_casual) %>%
  summarise(num_viajes = n())

ggplot(data = tipo_bici, 
       aes(x = rideable_type, y = num_viajes , fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(x = "Tipo de bicicleta",
       y = "Conteo",
       title = 'Cantidad de viajes', 
       subtitle = 'Por tipo de usuario y bicicleta') + 
  theme( plot.title.position = 'plot',
         plot.title = element_text(size = 15,
                                   face = 'bold'),
         plot.subtitle = element_text(size = 12,
                                      face = 'bold',
                                      hjust = 0.15),
         legend.position = "none") +
  scale_x_discrete(label =  c('clásica','acoplada','eléctrica')) +
  scale_y_continuous(labels = label_number())


