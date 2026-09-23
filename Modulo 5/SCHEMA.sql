Use TiendaPractica
Go

/*			
							ESQUEMAS (SCHEMA)			
	Puntual: un esquema es una forma de agrupar objetos (tablas, vistas) 
	dentro de una misma base de datos — como "carpetas" lógicas. Por defecto, 
	todo lo que creaste hasta ahora vive en el esquema dbo (el que viene por 
	defecto en SQL Server).			*/

/*ACLARACION: Si existe un eschema y tabla ventas.cliente y rrhh.empleados, esto no impide
			  que ambos puedan utilizar las tablas (salvo que a nivel de seguridad tengan restricciones)*/

Create Schema ventas;

Create table ventas.Promocion (
		IdPromocion Int primary key identity (1,1),
		Descripcion Nvarchar(100)
);

/*	Puntual: así defines que esta tabla vive dentro del esquema ventas, 
			 no en dbo. Para consultarla, usas el nombre completo:  */

Select * from ventas.promocion;

/*	¿Para qué sirve en la práctica? En bases de datos grandes con muchas 
	 tablas, separas por área de negocio (ventas.Cliente, rrhh.Empleado, 
	 contabilidad.Factura) — organiza mejor y también permite dar permisos 
	 por esquema completo (ej: el equipo de RRHH solo ve el esquema rrhh).

		📓 Para tu cuaderno
		dbo = esquema por defecto en SQL Server.
		💡 Esquemas = "carpetas lógicas" para organizar tablas por área de negocio,
		y también sirven para permisos (lo verás en el Módulo 7: Seguridad).		*/






