/*
					RESTORE
*/

--NO EJECUTAR (EJEMPLO TEORICO)
/*
	Orden obligatorio: Full → Diferencial → Log — restaurar en otro orden falla.
	NORECOVERY → "todavía vienen más backups, no cierres la BD aún".
	RECOVERY (solo en el último) → "ya terminé, deja la BD lista para usarse".
*/
RESTORE DATABASE TiendaPractica
FROM DISK = 'C:\Backups\TiendaPractica_Full.bak'
WITH NORECOVERY;

RESTORE DATABASE TiendaPractica
FROM DISK = 'C:\Backups\TiendaPractica_Diff.bak'
WITH NORECOVERY;

RESTORE LOG TiendaPractica
FROM DISK = 'C:\Backups\TiendaPractica_Log.bak'
WITH RECOVERY;

--AHORA PROBAREMOS CON UN EJEMPLO REAL PERO VAMOS A RESTAURAR NUESTRO BKP EN UNA BD CON NOMBRE DIFERENTE
RESTORE DATABASE TiendaPractica_Restaurada
FROM DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_full.bak'
WITH MOVE 'TiendaPractica' TO 'D:\SQL_DATA\TiendaPractica_Restaurada.mdf',
	 MOVE 'TiendaPractica_Log' TO 'D:\SQL_DATA\TiendaPractica_Restaurada.ldf',
	 NORECOVERY;

--Ahora si vemos la BD dice (restaurando...) debemos terminar de restaurar con el diferencial
RESTORE DATABASE TiendaPractica_Restaurada
FROM DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_diff.bak'
WITH NORECOVERY;

--Ahora vamos a restaurar el log para culminar la restauracion
RESTORE LOG TiendaPractica_Restaurada
FROM DISK = 'C:\Users\ALEX\Documents\SQL Server Management Studio 22\TiendaPractica_log.bak'
WITH RECOVERY;

Select * from tiendaPractica_Restaurada.dbo.Cliente;