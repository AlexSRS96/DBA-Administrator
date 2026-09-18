USE TiendaPractica
GO

/* INSERTANDO VALORES

--- USAMOS INSERT Y HACEMS LA REFERENCIA A LAS TABLAS
*/
/*
	No pones IdCliente porque es IDENTITY — SQL Server lo genera solo.
	VALUES (...), (...), (...) → inserta varias filas en una sola instrucción.
*/

--insert a tabla cliente
INSERT INTO Cliente (NombreCliente)
VALUES ('Juan Pérez'), ('Ana López'), ('Carlos Ruiz');

--insert a tabla productos
INSERT INTO Producto (NombreProducto, Categoria)
VALUES ('Mouse', 'Periféricos'), ('Teclado', 'Periféricos'), ('Monitor', 'Pantallas');

--insert a tabla venta
INSERT INTO Venta (IdCliente, FechaVenta)
VALUES (1, '2026-09-01'), (1, '2026-09-03'), (2, '2026-09-04');
/*Puntual: aquí sí pones IdCliente a mano, 
porque es FK — debe existir ya en Cliente (usé 1 y 2, que ya insertaste arriba).*/

--insert a tabla detalleVenta
INSERT INTO DetalleVenta (IdVenta, IdProducto, Cantidad, PrecioUnitario)
VALUES 
(1, 1, 2, 25.00),
(1, 2, 1, 40.00),
(2, 3, 1, 300.00),
(3, 1, 3, 25.00);
/*Puntual: cada fila = un producto dentro de una venta. La venta 1 
tiene 2 líneas (Mouse + Teclado) — así se ve en la práctica lo de 
"una venta con varios productos".*/

/* CONSULTAS SELECT*/

Select * from Cliente;
--Puntual: * = todas las columnas. Trae todas las filas de Cliente.

Select NombreCliente from Cliente;
--Puntual: solo trae la columna que pides, no todas.

Select * from Cliente where IdCliente = 1
--Puntual: WHERE filtra filas según una condición.

Select * from DetalleVenta order by PrecioUnitario asc;
--Puntual: ORDER BY ordena resultados. DESC = descendente (ASC = ascendente, es el default).

Select distinct Categoria from Producto
--Puntual: DISTINCT elimina duplicados — trae cada categoría una sola vez.