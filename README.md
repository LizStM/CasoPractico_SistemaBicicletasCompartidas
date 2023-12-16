# Caso práctico de análisis de datos de Sistema de bicicletas compartidas.

## Sobre el caso práctico.
Cyclistic, una empresa de bicicletas compartidas de Chicago, fue lanzada en 2016. Desde entonces, el programa creció hasta alcanzar una flota de 5,824 bicicletas georreferenciadas y bloqueadas en una red de 692 estaciones en toda Chicago. Las bicicletas se pueden desbloquear desde una estación y devolverse en cualquier otra estación del sistema en cualquier momento. Cyclistic también ofrece membresías anuales para el uso de las bicicletas.

La directora de marketing de Cyclistic cree que el éxito futuro de la empresa depende de maximizar la cantidad de membresías anuales.

Se quiere entender qué diferencias existen en el uso de las bicicletas Cyclistic entre los ciclistas ocasionales y los miembros anuales. Para posteriormente diseñar una nueva estrategia de marketing para convertir a los ciclistas ocasionales en miembros anuales.

## Tarea empresarial.
Analizar los datos históricos de viajes en bicicleta para identificar las tendencias de uso en dos tipos de usuarios: los que adquieren membresía anual y los ocasionales, con el fin de entender como difieren y de esa forma encontrar posibles cambios en las tácticas de marketing para conseguir que los usuarios ocasionales lleguen a ser miembros.

## Descripción de la fuente de datos
Los datos ocupados han sido proporcionados por Motivate International Inc. Provenientes del servicio de bicicletas compartidas Divvy de la compañía Lyft Bikes and Scooters, con operación en la ciudad de Chicago. Cuyos datos están disponibles al público para cualquier propósito legal, sin incluir los datos personales de los usuarios. 

Los datos están organizados en archivos mensuales comprendidos en un periodo de noviembre del 2022 a octubre del 2023, con campos que brindan información sobre el tipo de bicicleta rentada, la duración del viaje, la estación de inicio y final y el tipo de usuario.

Puedes revisar el conjunto de datos [aquí](https://divvy-tripdata.s3.amazonaws.com/index.html)

## Registro de cambios en el procesamiento de los datos.

|Numero de cambio (descendente)	| Tipo de cambio	| Cambio realizado	| Razón del cambio |
|--------------------------------|-----------------|-------------------|------------------|
|                6               | ELIMINADO |Valores negativos o iguales a cero del campo duración.|No existe viajes con duración negativa.|
|                5               | MODIFICADO |Campo nuevo: duración. Con la duración del viaje calculada con la diferencia entre la hora de inicio y fin.|Explorar diferencias entre longitud de viajes para los usuarios.|
|                4               | MODIFICADO |Campos nuevos: fecha, mes, dia, dia_semana, año, hora, numSemana. Para obtener el mes, los días y la hora en que se realizó cada viaje.|Explorar tendencias de uso basado en días.|
|                3               | ELIMINADO |Filas con valores nulos |Trabajar solo con los datos válidos.|
|                2               | ELIMINADO |Campos con id, latitud y longitud de la ubicación de cada estación|Para el propósito del análisis en R (la comparación entre los tipos de usuarios) estos datos no eran necesarios.|
|                1               | MODIFICADO |Unión en un nuevo conjunto anual los datos mensuales.|Agiliza la manipulación de los datos al tener un solo conjunto.|

## Resumen del análisis realizado.
Se pretende que el análisis arroje las diferencias entre los usuarios, para la duración del viaje, los días y la hora en que se realizan, por lo que la obtención de estos datos fue fundamental. Se obtuvieron el año, mes, numero de semana, día de la semana y la hora del viaje a partir de la fecha/hora registrada en el sistema, en la cual se realizó el préstamo de la bicicleta. Y la diferencia entre la hora de inicio y final para obtener la duración de los viajes.

Una vez que estuvo preparado el conjunto de datos para su análisis se calculó el promedio, el mínimo y el máximo de duración para los dos tipos de usuario. Después se calculó el promedio de duración y la cantidad de viajes realizados en cada día de la semana y por cada tipo de usuario.

El conjunto de datos se ha agrupado para proporcionar las siguientes tablas (y posteriormente gráficos).

* Agrupado por tipo de usuario y día de la semana
  * Duración promedio de los viajes.
  * Cantidad de viajes.
*	Agrupado por tipo de usuario.
	*	Cantidad de viajes mensuales.
 	*	Cantidad de viajes semanales.
	*	Cantidad de viajes cada hora del día.
   	* Tipo de bicicleta ocupada.


## Hallazgos clave.
*	Los usuarios que realizan mayor cantidad de viajes, ocupando el servicio de bicicletas compartidas Divvy, son los que cuentan con una membresía, además de que sus viajes se centran en días dentro de la semana (lunes a viernes). Los usuarios casuales no realizan gran cantidad de viajes, pero aumentan los prestamos los fines de semana, en especial los sábados.
*	Los usuarios casuales realizan viajes de casi el doble de duración en comparación con los que tienen membresías.
*	Los tipos de bicicleta preferida de los miembros son la clásica y la eléctrica. Los usuarios casuales prefieren eléctrica a clásica, sin embargo, los casuales son los únicos que ocupan las bicicletas acopladas.
*	Existen dos picos de actividad en los préstamos a las 8:00 y 17:00 horas. A diferencia de los miembros, los casuales solo presentan el segundo pico a las 17:00 hrs.
*	La cantidad de viajes para ambos tipos de usuario aumentan en los meses de abril a octubre y disminuyen de noviembre a marzo, coincidiendo con las estaciones del año, con aumento en verano y disminución en invierno.
*	La semana con menor actividad es la primera del año, es decir del 1 de enero al 7 de enero y la de mayor actividad en la semana 29, del 17 de julio al 23 de julio.

## Conclusiones y recomendaciones
Los usuarios con membresía ocupan el servicio de bicicletas compartidas Divvy siguiendo un horario laboral, en el que probablemente ocupen el servicio para trasladarse a su lugar de trabajo de lunes a viernes. 

Los usuarios casuales suelen ocupar el servicio de bicicletas por las tardes, y realizando viajes más largos, probablemente con el objetivo de realizar actividad física, o paseos los fines de semana.

Para ambos tipos de usuario, la cantidad de viajes realizados usando el servicio coinciden con las estaciones del año, teniendo una cantidad de viajes mínima en invierno y una cantidad de viajes máxima en verano.

Cyclistic podría incluir y promocionar:

*	Nueva membresía semestral, con el propósito de abarcar los seis meses más activos del año, entre abril y octubre, anunciándolo semanas antes de que esta temporada comience, por ejemplo, durante el mes de febrero y marzo.
*	Nueva membresía de fines de semana. Los usuarios casuales suelen ocupar el servicio los fines de semana por lo que esta membresía encajaría con este tipo de usuarios.
*	Incorporar un sistema de recompensas dentro de las membresías a usuarios que realicen viajes de mayor duración, esto correspondería con los hábitos de usuarios casuales, y los beneficiaría si obtuvieran una membresía. 

