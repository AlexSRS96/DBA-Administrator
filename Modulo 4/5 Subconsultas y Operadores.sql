Use TiendaPractica
Go

/*                  SUBCONSULTAS Y OPERADORES               */

/*
=====================================================
OPERADORES SQL - RESUMEN
=====================================================

WHERE              -> Filtra filas individuales, antes de agrupar
HAVING             -> Filtra grupos, despues de GROUP BY

IN (...)           -> Compara contra una lista de valores (o subconsulta)
NOT IN (...)       -> Excluye los valores de esa lista

LIKE 'patron'      -> Busca coincidencia de texto
                       % = cualquier cantidad de caracteres
                       _ = exactamente un caracter
NOT LIKE 'patron'  -> Excluye ese patron de texto

BETWEEN x AND y      -> Rango inclusive (>= x AND <= y)
NOT BETWEEN x AND y  -> Fuera de ese rango

IS NULL       -> Compara contra nulo (NUNCA usar = NULL)
IS NOT NULL   -> Excluye los nulos

EXISTS (subconsulta)      -> Verdadero si la subconsulta devuelve al menos 1 fila
NOT EXISTS (subconsulta)  -> Verdadero si la subconsulta NO devuelve ninguna fila

AND / OR   -> Combinan condiciones
             AND = ambas deben cumplirse
             OR  = al menos una debe cumplirse

=, <> o !=, >, <, >=, <=   -> Comparaciones estandar
                               (<> y != son equivalentes para "distinto de")

ANY / ALL   -> Compara contra cada valor de una subconsulta
               > ANY = mayor que al menos uno
               > ALL = mayor que todos
               (poco usado en el dia a dia)

=====================================================
TRUCO DE USO
=====================================================
Un solo valor          -> operadores normales (=, >, <)
Lista o rango          -> IN, BETWEEN, LIKE
Solo interesa si existe -> EXISTS
=====================================================
*/

SELECT P.NombreProducto, dv.PrecioUnitario 
FROM Producto p
INNER JOIN DetalleVenta dv ON p.IdProducto = dv.IdProducto	
WHERE dv.PrecioUnitario > (SELECT AVG(PrecioUnitario) FROM DetalleVenta);	

/* Puntual: la subconsulta (SELECT AVG...) devuelve un solo valor, y lo usas
como si fuera un número normal en el WHERE. Trae productos vendidos por encima
del precio promedio.*/

Select * from cliente
where IdCliente in (select  IdCliente from venta where FechaVenta = '2026-09-01')
/*  Puntual: IN compara contra una lista de valores — aquí la lista viene de una subconsulta
	(clientes que compraron en esa fecha específica). */

Select * from Producto
where NombreProducto like 'M%'

Select * from Cliente
where NombreCliente like '%ua%'

Select * from Producto
where Categoria like '%s'

/*	Puntual: LIKE busca patrones de texto. % = cualquier cantidad de caracteres. 
	'M%' = empieza con M. '%o' = termina en o. '%tec%' = contiene "tec" en cualquier parte.*/

Select * from DetalleVenta
where Cantidad between 1 and 2 

select  P.NombreProducto, dt.Cantidad 
from DetalleVenta dt inner join Producto P on dt.IdProducto = p.IdProducto
where dt.Cantidad between 0 and 1 

/*	Puntual: BETWEEN filtra un rango (inclusive en ambos extremos) 
	— equivale a Cantidad >= 1 AND Cantidad <= 2.*/

select * from Producto where Categoria is null

select C.IdCliente, C.NombreCliente
from cliente c left join venta v on V.IdCliente = C.IdCliente
where v.IdVenta is null

select * from  venta

/*	Puntual: para buscar NULL nunca uses = NULL (no funciona en SQL) 
	— siempre IS NULL o IS NOT NULL.*/
select * from cliente
where exists (select 1 from Venta where venta.IdCliente = Cliente.IdCliente)

/*	Puntual: EXISTS revisa si la subconsulta devuelve al menos una fila
	— no importa el valor, solo si existe o no. Es más eficiente que IN 
	cuando la subconsulta puede devolver muchas filas.*/