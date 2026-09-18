/*
		CONSTRAINTS
						*/

/*
	DEFAULT 0 → si no envías valor para Stock en el INSERT, 
				toma 0 automáticamente.
	CHECK (Precio > 0) → SQL Server rechaza cualquier INSERT/UPDATE 
						 que intente poner un precio ≤ 0. Valida reglas 
						 de negocio a nivel de base de datos.
	UNIQUE → no permite valores repetidos en esa columna (a diferencia de 
			 PRIMARY KEY, sí permite NULL, y puedes tener varias columnas 
			 UNIQUE en una tabla, pero solo una PRIMARY KEY).
*/

USE TiendaAvanzada
GO

CREATE TABLE PRODUCTOS (
	Id_Producto int identity (1,1) primary key,
	Nombre_Producto nvarchar(100) not null,
	Stock int not null default (0),
	Precio decimal(10,2) not null check (Precio>0),
	Codigo nvarchar(20) unique
);

/*
	--DEFAULT valor → valor automático si no se especifica.
	--CHECK (condición) → valida una regla al insertar/actualizar.
	--UNIQUE → sin duplicados, pero sí permite NULL (a diferencia de PK).
*/

/*		
		EJEMPLO
					*/

Use TiendaPractica
Go

Create table ProductoV2 (
	Id_Producto int identity (1,1) primary key,
	Nombre_Producto nvarchar(100) not null,
	Stock int not null default (0),
	Precio decimal(10,2) not null check(precio>0),
	Codigo nvarchar(10) unique
)
--NOTA: decimal (10,2) -> el 2 viene a ser la cantidad de decimales

--PROBANDO INSERT CON VALOR MENOR A 0 EN CAMPO PRECIO
INSERT INTO ProductoV2 (Nombre_Producto, Precio, Codigo)
VALUES ('Producto Prueba2', -5, 'TEST02');
/*Puntual: esto debería fallar con un error de CHECK constraint. 
		   Pruébalo, y luego uno válido para confirmar que sí funciona:*/

--PROBANDO INSERT SIN INGRESAR VALOR EN CAMPO STOCK, debe tomar 0 por defecto
INSERT INTO ProductoV2 (Nombre_Producto, Precio, Codigo)
VALUES ('Producto Prueba', 25.50, 'TEST01');
/*Puntual: aquí no puse Stock — debería tomar 0 automáticamente por el DEFAULT. 
Verifica con SELECT * FROM ProductoV2; que efectivamente quedó en 0.*/

Select * from ProductoV2

/*
	💡 Cuando un INSERT falla con varias constraints posibles, SQL Server 
	   puede bloquear por cualquiera de ellas — revisa el mensaje de error 
	   completo (dice el nombre de la constraint, ej: CK__..., UQ__...) 
	   para saber cuál fue exactamente.
*/