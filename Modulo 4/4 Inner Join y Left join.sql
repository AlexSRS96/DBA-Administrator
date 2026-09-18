Use TiendaPractica
Go

/*			UTILIZANDO INNER JOIN Y LEFT JOIN     */

--INNER JOIN
/* Puntual: combina filas de dos tablas donde la condición (ON) se cumple. c y v son alias. 
	Solo trae clientes que sí tienen ventas — si un cliente no tiene ninguna, no aparece.*/
SELECT c.NombreCliente, v.IdVenta, v.FechaVenta
FROM Cliente c
INNER JOIN Venta v ON c.IdCliente = v.IdCliente;

--LEFT JOIN
/*	Puntual: trae todos los de la tabla izquierda (Cliente), tengan o no coincidencia en Venta.
	Sin ventas → IdVenta sale NULL. Sirve para encontrar "quiénes no tienen X".
*/
SELECT c.NombreCliente, v.IdVenta
FROM Cliente c
LEFT JOIN Venta v ON c.IdCliente = v.IdCliente;

/* Ejemplo con 2 JOIN encadenados (total gastado por cliente)*/

SELECT c.NombreCliente, SUM(dv.Cantidad * dv.PrecioUnitario) AS TotalGastado
FROM Cliente c
INNER JOIN Venta v ON c.IdCliente = v.IdCliente
INNER JOIN DetalleVenta dv ON v.IdVenta = dv.IdVenta
GROUP BY c.NombreCliente;

/* Puntual: encadena Cliente→Venta→DetalleVenta, agrupa y suma. 
			Cada JOIN combina físicamente las tablas en un solo resultado 
			— a diferencia de la subconsulta que vimos, aquí sí hay una sola
			tabla resultante con columnas de las 3 tablas mezcladas.*/

--INNER JOIN: solo coincidencias en ambas tablas.
--LEFT JOIN: todo de la izquierda, coincida o no (NULL si no hay match).
--💡 Truco: para 3+ tablas, encadena varios JOIN seguidos.



--EJERCICIO 4 : Muestra cada producto vendido junto al nombre del cliente que 
		      --lo compró (Producto, DetalleVenta, Venta, Cliente — 3 JOINs).

Select  V.IdVenta, P.NombreProducto, dt.Cantidad, C.NombreCliente
From Venta V Inner Join DetalleVenta DT on V.IdVenta = DT.IdVenta
			 inner Join Cliente C on V.IdCliente = C.IdCliente
			 inner Join Producto P on DT.IdProducto = P.IdProducto;

--EJERCICIO 5 : Usa LEFT JOIN para encontrar si hay algún cliente que no tenga ninguna venta registrada.
Select  C.IdCliente, C.NombreCliente, V.IdVenta
from Cliente C left join Venta V on V.IdCliente = C.IdCliente
where v.IdVenta is null

