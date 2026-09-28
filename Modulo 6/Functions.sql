Use TiendaPractica
Go

/*
					FUNCIONES

	💡 Function = calcula y devuelve algo, se usa dentro de consultas, 
				  no puede modificar datos.
	💡 Procedure = ejecuta acciones (incluye modificar datos), se llama 
				   aparte con EXEC, no se usa dentro de un SELECT.
	💡 Regla rápida:si necesitas usar el resultado dentro de otra 
					consulta → Function. Si necesitas hacer algo 
					(insertar, actualizar, lógica compleja) → Procedure.
*/

CREATE FUNCTION fn_CalcularIGV (@Monto DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
	RETURN @Monto * 0.18;
END;
/*	
	RETURNS DECIMAL(10,2) → define qué tipo de dato devuelve la función.
	RETURN → obligatorio, entrega el valor calculado.      */

/*Puntual: siempre debes anteponer el esquema (dbo.) al llamar una función 
— a diferencia de los procedimientos (EXEC), esto es obligatorio en funciones.*/
SELECT dbo.fn_CalcularIGV(100);

/*		
				Función de tabla (devuelve un conjunto de filas, como un SELECT)				*/

CREATE FUNCTION fn_VentasPorCliente (@IdCliente int)
RETURNS TABLE
AS
RETURN
(
	SELECT v.IdVenta, v.FechaVenta, dv.Cantidad, dv.PrecioUnitario 
	FROM venta v inner join DetalleVenta dv on v.IdVenta = dv.IdVenta
	WHERE v.IdCliente = @IdCliente
);
--Puntual: se usa igual que una tabla normal — puedes incluso hacerle WHERE, JOIN, etc. por encima.

--probando funcion creada
SELECT * FROM dbo.fn_VentasPorCliente(1);

/* 
	💡 Function = calcula y devuelve algo, se usa dentro de consultas, 
				  no puede modificar datos.
	💡 Procedure = ejecuta acciones (incluye modificar datos), se llama 
				  aparte con EXEC, no se usa dentro de un SELECT.
	💡 Regla rápida: si necesitas usar el resultado dentro de otra consulta → Function. 
					Si necesitas hacer algo (insertar, actualizar, lógica compleja) → Procedure.     */