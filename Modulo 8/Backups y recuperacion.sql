Use TiendaPractica
Go

/*
						Modelos de recuperacion (SIMPLE, FULL, BULK-LOGGED)

--> Simple: no permite backup de log — pierdes todo desde el último backup full/diferencial si algo falla.
-->	Full: permite backup de log, recuperación hasta el minuto exacto antes de una falla — el estándar en producción.
-->	Bulk-logged: variante de Full, optimizada para cargas masivas puntuales.
*/
ALTER DATABASE TiendaPractica SET RECOVERY full;

/*
						BACKUP FULL

	copia completa de la base de datos en ese momento. Es la base de cualquier estrategia 
	de backup — todo lo demás (diferencial, log) depende de que exista un Full primero.

	Ejecútalo y confirma que se creó el archivo .bak.
*/
BACKUP DATABASE TiendaPractica
TO DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_full.bak';