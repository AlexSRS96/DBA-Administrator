use TiendaPractica
Go

--ejercicio 1
Select idventa, count(*) as CantidadProductosVendidos
from DetalleVenta
group by IdVenta

--ejercicio 3
--Muestra solo los productos (IdProducto) cuya cantidad 
--total vendida (sumando todas las ventas) sea mayor a 2.

Select IdProducto, sum(Cantidad) as CantidadProductosVendidos
from DetalleVenta
group by IdProducto 
having sum(Cantidad) > 2

