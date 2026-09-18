	Use TiendaPractica
	Go

	Select count(*) as cantidad_filas from Producto;
	--Puntual: cuenta filas totales.
	--el 'as' sirve para dar alias

	Select COUNT(*) from DetalleVenta where IdVenta = 1
 	--Puntual: cuenta filas que cumplen la condición — cuántos productos tiene la venta 1.
	Select * from DetalleVenta
	--comprobando

	Select SUM(Cantidad * PrecioUnitario) as Importe_total from DetalleVenta where IdVenta = 1 
	--Puntual: SUM suma valores — total de la venta 1 (calculado, no almacenado).

	select avg(PrecioUnitario) from DetalleVenta;
	--Puntual: AVG = promedio.			

	SELECT MAX(PrecioUnitario), MIN(PrecioUnitario) FROM DetalleVenta;
	--Puntual: valor más alto y más bajo.

	SELECT IdVenta, SUM(Cantidad * PrecioUnitario) AS Total
	FROM DetalleVenta
	GROUP BY IdVenta;
	--Puntual: GROUP BY agrupa filas por columna — total por cada venta, no uno solo general.

	SELECT IdVenta, SUM(Cantidad * PrecioUnitario) AS Total
	FROM DetalleVenta
	GROUP BY IdVenta
	HAVING SUM(Cantidad * PrecioUnitario) > 80;
	--Puntual: HAVING filtra grupos después de agrupar (WHERE filtra antes).

	/*
	IMPORTANTE

	-WHERE filtra filas individuales. HAVING filtra grupos (post GROUP BY).
    -💡 Si la condición usa una función de agregación, va en HAVING, no en WHERE. */