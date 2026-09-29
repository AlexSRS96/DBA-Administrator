Use TiendaPractica
GO

/*
						Roles de servidor y de base de datos
	Roles de servidor (fixed server roles)
	Son roles predefinidos que aplican a todo el servidor, no a una BD específica.
*/

/*		Puntual: sysadmin es el más poderoso — control total sobre el servidor completo 
				 (todas las bases de datos, configuración, todo).
				 Casi nunca se asigna en producción, salvo al DBA principal.

		Otros roles de servidor comunes: dbcreator: (puede crear/borrar bases de datos), 
										 securityadmin: (administra logins y permisos), 
										 public: (todos los logins pertenecen a este por defecto, 
											     con permisos mínimos).*/
ALTER SERVER ROLE sysadmin ADD MEMBER Pedro;

/*	Roles de base de datos (fixed database roles)
		Son roles predefinidos que aplican solo dentro de una base de datos específica.	
		
	Puntual: db_datareader = puede leer (SELECT) todas las tablas de esa BD, nada más.
	--> Otros roles de BD comunes:
			--> db_datawriter → puede INSERT/UPDATE/DELETE en todas las tablas.
			--> db_owner → control total sobre esa base de datos específica (como un "sysadmin" pero solo de esa BD).
			--> db_denydatawriter → bloquea explícitamente cualquier escritura (útil combinado con otros roles).	*/
USE TiendaPractica
ALTER ROLE db_datareader ADD MEMBER Pedro;

-- Rol personalizado (cuando los predefinidos no alcanzan)
/* Puntual: creas un rol a tu medida, le das permisos específicos, y luego 
			agregas usuarios a ese rol. Así, si mañana entra un nuevo empleado de ventas,
			solo lo agregas al rol — no repites permisos uno por uno. */
--CREANDO ROL
CREATE ROLE rol_ventas
GRANT SELECT, INSERT ON Venta TO rol_ventas;
GRANT SELECT, INSERT ON DetalleVenta TO rol_ventas;
--Agregando usuario al rol
ALTER ROLE rol_ventas ADD MEMBER Pedro;

/*EJEMPLO PRACTICO*/

--creando usuario a nivel servidor, podra loguearse pero no podra acceder a las bd
CREATE LOGIN Alexander WITH PASSWORD = '123456'
--Agregando a usuario a la base de datos
USE TiendaPractica
CREATE USER Alexander FOR LOGIN Alexander;

--vamos a crear un rol para un programador que solo hara select, insert, update y delete de algunas tablas
USE TiendaPractica
CREATE ROLE rol_programador
GRANT SELECT , INSERT ON Cliente to rol_programador;
GRANT SELECT , INSERT ON DetalleVenta to rol_programador;
GRANT SELECT , INSERT ON Empleado to rol_programador;
GRANT SELECT , INSERT ON Factura to rol_programador;
GRANT SELECT , INSERT ON Producto to rol_programador;
GRANT SELECT , INSERT ON Venta to rol_programador;
--Agregando al usuario Alex  a ROL
ALTER ROLE rol_programador ADD MEMBER Alexander;

--Probando hacer selec a una tabla que no ha sigo incluida en la lista
 Select * from ProductoV2;
 --verificando que usuario esta conectado
	SELECT SUSER_NAME(), USER_NAME();
