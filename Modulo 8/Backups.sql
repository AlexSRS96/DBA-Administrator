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

/*
						BACKUP DIFERENCIAL

	Puntual: solo guarda los cambios desde el último Full (no desde el último diferencial)
	— más rápido que otro Full, pero depende de que el Full exista.
*/
--Haz un cambio en una tabla (ej: INSERT en Cliente), luego ejecuta este backup.

Insert into Cliente  values ('Marino Rodriguez');

--Ahora generaremos el backup diferencial
BACKUP DATABASE TiendaPractica
TO DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_diff.bak'
WITH DIFFERENTIAL;

/*
						BACKUP DE LOG

	guarda las transacciones desde el último backup de log (o el Full, si es el primero). 
	Solo funciona en modelo Full (ya lo configuramos). Permite recuperar hasta el minuto
	exacto antes de una falla — el más crítico en producción real.
*/

BACKUP LOG TiendaPractica
TO DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_log.bak'