Use TiendaPractica
Go

/*
								Estadísticas
	
	SQL Server usa estadísticas (distribución de valores en cada columna) para decidir el 
	mejor plan de ejecución. Si los datos cambian mucho y las estadísticas quedan desactualizadas, 
	el optimizador puede elegir planes ineficientes.
*/
--Actualiza las estadisticas de la tabla venta 
UPDATE STATISTICS Venta;

--actualiza estadísticas de toda la base de datos de una vez, en vez de tabla por tabla.
exec sp_updatestats;