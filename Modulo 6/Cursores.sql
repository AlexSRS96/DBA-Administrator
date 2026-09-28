USE TiendaPractica
GO
/*
						CURSORES
														*/

DECLARE @IdProducto INT, @NombreProducto NVARCHAR(100);
DECLARE cur_Productos CURSOR FOR
SELECT IdProducto, NombreProducto FROM Producto;

OPEN cur_Productos; 
FETCH NEXT FROM cur_Productos INTO @IdProducto, @NombreProducto;

WHILE @@FETCH_STATUS = 0
BEGIN 
	PRINT 'Producto: ' + @NombreProducto;
	FETCH NEXT FROM cur_Productos INTO @IdProducto, @NombreProducto;
END
CLOSE cur_Productos;
DEALLOCATE cur_Productos;
/*
	DECLARE cur_Productos CURSOR FOR (SELECT...) → define el cursor, basado en un SELECT.
	OPEN → lo activa.
	FETCH NEXT ... INTO → trae una fila a la vez y la guarda en las variables — así procesa
						  el resultado fila por fila, no todo junto como un SELECT normal.
	@@FETCH_STATUS = 0 → variable del sistema que dice "sí hay una fila más" (0 = éxito, 
						 -1 = ya no hay más filas). Por eso el WHILE se repite mientras siga en 0.
	CLOSE → libera el cursor (pero queda declarado).
	DEALLOCATE → lo elimina completamente de memoria. Siempre debes hacer ambos al terminar.*/


	/*
		Cursor = procesa fila por fila (DECLARE → OPEN → FETCH en bucle → CLOSE → DEALLOCATE).
		💡 Pregunta clásica de entrevista: "¿por qué evitarías un cursor?" → porque SQL Server 
		está optimizado para operaciones por conjunto (set-based), y un cursor fila por fila es
		mucho más lento en tablas grandes. Se usa solo cuando no hay forma de resolverlo con una 
		operación de conjunto.
	*/