use TiendaPractica
Go

/*						PLANES DE EJECUCION
						
	El plan de ejecución te muestra el camino exacto que usó SQL Server para
	resolver tu consulta (qué índices usó o no, cuánto costó cada paso) — así 
	identificas qué está lento y por qué.
*/

/*
	STATISTICS IO muestra lecturas lógicas (cuánto "trabajó" el disco/memoria), 
	STATISTICS TIME muestra tiempo de CPU/ejecución — así comparas si un índice realmente mejora una consulta, 
					no solo en teoría.

	Más visual: en SSMS, botón "Incluir el plan de ejecución real" (o Ctrl+M) antes de ejecutar una consulta
	— te muestra un diagrama con el camino que tomó SQL Server (si usó un índice, o si hizo un "Table Scan" costoso).	
*/
--FORMA MEDIANTE CODIGO
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

select * from DetalleVenta where IdProducto = 1;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

--FORMA MEDIANTE CONSOLA PRIMERO PRESIONA CONTROL + M y Luego ejecutas la consulta
select * from DetalleVenta where IdProducto = 1;
