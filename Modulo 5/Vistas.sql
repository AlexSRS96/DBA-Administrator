Use TiendaPractica
Go

/*							VISTAS (VIEW)
				
	Puntual: una vista es una consulta guardada con nombre — no almacena datos propios, 
			 ejecuta el SELECT de adentro cada vez que la consultas. */

Create view VentaResumen As 
			Select v.IdVenta, c.NombreCliente, v.FechaVenta, SUM(dv.Cantidad * dv.PrecioUnitario) AS TotalVenta
			from Venta V inner join Cliente C on V.IdCliente = C.IdCliente
					     inner join DetalleVenta dv on dv.IdVenta = v.IdVenta
			group by v.IdVenta, c.NombreCliente, v.FechaVenta;

--Ver vista creada
Select * from VentaResumen

/*
	¿Para qué sirve? Simplifica consultas repetitivas — en vez de escribir ese JOIN largo cada vez, usas VentaResumen. También sirve para dar acceso limitado (ej: mostrar solo ciertas columnas a un usuario sin exponerle la tabla completa).

	📓 Para tu cuaderno
	Vista = consulta guardada, no almacena datos propios, se actualiza sola al consultarla.
	💡 Útil para simplificar JOINs repetitivos y para limitar qué columnas ve un usuario.
*/