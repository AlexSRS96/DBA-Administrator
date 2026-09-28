Use TiendaPractica
Go
/*			
							TRIGGERS
	
	ON Producto → tabla que "vigila".
	AFTER INSERT → se dispara después de que ocurre un INSERT en esa tabla 
				   (también existen AFTER UPDATE, AFTER DELETE).
	--No se ejecuta manualmente (no hay EXEC) — se dispara solo, automáticamente, 
										      cada vez que ocurre esa acción.	
							*/

CREATE TRIGGER trg_Producto_Auditoria
ON Producto
AFTER INSERT
AS
BEGIN 
	PRINT 'Se inserto un nuevo producto';
END;

select * from Producto
--Insertamos un nuevo producto.
Insert into Producto Values ('Auriculares', 'Perifericos')

--Ejemplo real: guardar un log de cambios
CREATE TABLE LogPrecios (
		IdLog int primary key identity(1,1),
		IdProducto int,
		PrecioAnterior decimal(10,2),
		PrecioNuevo decimal(10,2),
		FechaCambio datetime2 default getdate()
);
--ejemplo real: creamos el trigger
/*
	INSERTED → tabla especial y temporal que contiene los valores nuevos (después del cambio).
	DELETED → tabla especial y temporal que contiene los valores anteriores (antes del cambio).
	En un UPDATE, ambas existen a la vez — así comparas el antes/después.
	En un INSERT, solo existe INSERTED. En un DELETE, solo existe DELETED.*/

CREATE TRIGGER trg_DetalleVenta_LogPrecio
ON DetalleVenta
AFTER UPDATE
--Se dispara automáticamente después de cualquier UPDATE sobre DetalleVenta.
AS
BEGIN
	INSERT INTO LogPrecios (idProducto, PrecioAnterior, PrecioNuevo)
	SELECT i.IdProducto, d.PrecioUnitario, i.PrecioUnitario 
	--Inserta en LogPrecios, tomando los valores del SELECT de abajo — no de valores fijos.
	FROM inserted i inner join deleted d on i.IdVenta = d.IdVenta and i.IdProducto = d.IdProducto
	/*inserted (alias i) → contiene los valores nuevos (después del UPDATE).
	  deleted (alias d) → contiene los valores anteriores (antes del UPDATE).
      Ambas son tablas temporales automáticas que SQL Server crea solo dentro del trigger, 
	        con la(s) fila(s) afectadas por ese UPDATE específico.
      El JOIN entre ambas por IdVenta + IdProducto (la PK compuesta de DetalleVenta) sirve 
			para emparejar cada fila "antes" con su misma fila "después" — así sabes que 
			estás comparando el precio viejo y nuevo de la misma fila exacta, no mezclando filas distintas.*/
	WHERE i.PrecioUnitario <> d.PrecioUnitario;
	/*	Solo registra en el log si el precio realmente cambió — si el UPDATE tocó otra columna (ej: Cantidad)
		pero no PrecioUnitario, no genera una entrada innecesaria en el log.*/
END;
/*		
		INSERTED/DELETED = tablas temporales automáticas dentro de un trigger, para comparar antes/después.
		💡 Desventaja clave de triggers: lógica "oculta" que se ejecuta sin que quien hace el INSERT/UPDATE 
										 lo sepa — dificulta mantenimiento y debugging. Úsalos con moderación. */

Select * from DetalleVenta

Update DetalleVenta Set PrecioUnitario = 40 
where IdVenta = 3

Select * from DetalleVenta;
Select * from LogPrecios;