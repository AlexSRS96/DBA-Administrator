Use TiendaPractica
Go

/*
						SEGURIDAD
	LOGIN = acceso al servidor completo (a nivel de SQL Server).
	USER = acceso a una base de datos específica, vinculado a un LOGIN.
	💡 Un LOGIN sin USER en una BD = se puede conectar al servidor, pero no puede tocar esa base de datos.
*/
--Creando usuario a nivel servidor
CREATE LOGIN Pedro WITH PASSWORD = 'Clave$2026Segura';

/*Puntual: aquí vinculas el LOGIN (servidor) con un USER (dentro de esta BD específica). 
Sin este paso, Pedro podría conectarse al servidor, pero no tendría acceso a TiendaPractica.*/
USE TiendaPractica
CREATE USER Pedro FOR LOGIN Pedro;