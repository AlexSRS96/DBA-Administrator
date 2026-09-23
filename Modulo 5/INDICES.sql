/*
			INDICES
							*/

Use TiendaPractica
GO

CREATE INDEX IX_Producto_NombreProducto
ON Producto (NombreProducto);

/*	Puntual: un índice es como el índice de un libro — SQL Server puede 
	encontrar filas por NombreProducto sin revisar toda la tabla (búsqueda directa, no lineal). 
	Acelera WHERE, JOIN, ORDER BY sobre esa columna.*/

/*				
							CLUSTERED vs NONCLUSTERED
	CLUSTERED: define el orden físico real en que se guardan los datos en disco. 
			   Solo puede haber uno por tabla (porque los datos físicamente solo 
			   pueden estar ordenados de una forma). Por defecto, la PRIMARY KEY 
			   ya crea un índice CLUSTERED automáticamente.

	NONCLUSTERED: una estructura aparte, como un índice de libro que apunta a la 
				  página real — no cambia el orden físico de los datos. Puedes 
				  tener varios por tabla (hasta 999). */

CREATE NONCLUSTERED INDEX IX_DetalleVenta_IdProducto
ON DetalleVenta (IdProducto);

EXEC sp_helpindex 'DetalleVenta';

/*	CLUSTERED → define el orden físico real de los datos en disco; 
				solo 1 por tabla (la PK ya lo crea automático).

	NONCLUSTERED → estructura aparte tipo "índice de libro" que apunta 
				   a los datos sin reordenarlos; puedes tener varios por 
				   tabla, se usa en columnas muy consultadas en WHERE/JOIN.
				   
				   
	En conclusion : NONCLUSTERED en Venta.IdCliente — porque a diario haces 
					WHERE IdCliente = X o JOIN con Cliente para reportes, y 
					con miles de ventas esa columna se consulta constantemente.*/

CREATE NONCLUSTERED INDEX IX_Venta_IdCliente
ON Venta (IdCliente);

/*Usando exec sp_helpindex 'tabla' podremos ver los index que tiene una tabla */
exec sp_helpindex 'Venta';