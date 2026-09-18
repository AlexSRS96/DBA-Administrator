/*
			INDICES
							*/

CREATE INDEX IX_Producto_NombreProducto
ON Producto (NombreProducto);

/*	Puntual: un índice es como el índice de un libro — SQL Server puede 
	encontrar filas por NombreProducto sin revisar toda la tabla (búsqueda directa, no lineal). 
	Acelera WHERE, JOIN, ORDER BY sobre esa columna.*/