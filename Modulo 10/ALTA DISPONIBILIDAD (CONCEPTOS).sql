/*
			ALTA DISPONIBILIDAD (CONCEPTOS)		

*/

/*	1. RTO y RPO — los dos conceptos que lo explican todo

	   RTO (Recovery Time Objective):  ¿cuánto tiempo puede estar caída la base de datos antes de
									   que sea un problema grave? (ej: "máximo 1 hora").
	   RPO (Recovery Point Objective): ¿cuántos datos puedes permitirte perder? (ej: "máximo 15 
										minutos de transacciones").

	Puntual: entre más bajos sean RTO/RPO (menos tolerancia a downtime/pérdida), más cara y compleja 
			 es la solución necesaria. Todo lo que sigue son formas de lograr RTO/RPO más bajos.
*/

/*	2. Always On Availability Groups

		Un conjunto de bases de datos replicadas en tiempo real entre varios servidores (réplicas). 
		Si el servidor principal falla, una réplica toma el control automáticamente (failover). 
		RTO/RPO muy bajos. Es el estándar actual en producción empresarial con SQL Server.
*/

/*	3. Log Shipping

		Envía backups de log de forma periódica (ej: cada 15 min) desde el servidor principal a uno 
		o más servidores secundarios. Más simple y barato que Always On, pero el failover es manual 
		y hay más posibilidad de pérdida de datos (RTO/RPO más altos).
*/

/*	4. Replication

		Copia y sincroniza datos específicos (no toda la BD) entre servidores — útil para distribuir 
		datos a sucursales, o alimentar un servidor de reportes sin afectar el de producción. No está 
		pensado principalmente para alta disponibilidad, sino para distribución de datos.
		
*/

/*	5. Clustering (Failover Cluster Instance)

		Varios servidores físicos comparten el mismo almacenamiento (storage compartido); si uno falla, 
		otro toma el control de la misma instancia de SQL Server. A diferencia de Always On, aquí no hay 
		copias de datos separadas — es un solo set de datos con varios servidores que pueden "tomarlo".
*/