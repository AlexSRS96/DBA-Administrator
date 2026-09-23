use TiendaPractica
Go

/*
			Stored Procedures (procedimientos almacenados)

	Stored Procedure = bloque de código SQL guardado con nombre, 
					   reutilizable, con parámetros de entrada/salida.
	💡 En empresas reales, casi ninguna app hace INSERT/UPDATE directo 
	a las tablas — todo pasa por procedimientos, por seguridad y control.
*/

/*	
	@Nombre → parámetro de entrada (siempre lleva @).
	AS BEGIN ... END → el bloque de código que ejecuta el procedimiento.
	Se ejecuta con EXEC:*/

/*Puntual: te muestra toda la estructura de la tabla — columnas, tipos, tamaños, si permite NULL, 
		   PK, FK — todo lo que necesitas confirmar antes de escribir el procedimiento.*/
EXEC sp_help 'Cliente';
--Úsalo siempre antes de crear un procedimiento, para que los parámetros coincidan exacto con las columnas reales.

-- Stored Procedure con parametros de ENTRADA
CREATE PROCEDURE sp_InsertarCliente
	@Nombre NVARCHAR (100)
AS
BEGIN 
	INSERT INTO Cliente(NombreCliente)VALUES (@Nombre);
END;

--comando para ejecutar procedimiento almacenado
EXEC sp_InsertarCliente @nombre = 'Pedro Gomez';
--verificando
Select * from Cliente;

-- Stored Procedure con parametros de SALIDA
--Puntual: OUTPUT → el procedimiento devuelve un valor a través de ese parámetro, no con SELECT.
CREATE PROCEDURE sp_ContarVentasCliente
		@IdCliente INT,
		@Total INT OUTPUT
AS
BEGIN 
	SELECT @total = COUNT(*) FROM Venta WHERE IdCliente = @IdCliente;
END;

--comando para ejecutar procedimiento almacenado
DECLARE @Resultado INT;
EXEC sp_ContarVentasCliente @idcliente = 1, @Total = @Resultado OUTPUT;
SELECT @Resultado;

/*	DECLARE @variable TIPO; → crea una variable local para 
	guardar un valor temporal.
	OUTPUT (al crear el procedimiento) → marca el parámetro como "de salida".
	OUTPUT (al ejecutar) → confirma que quieres recibir ese valor en tu variable.
	💡 Uso frecuente: validaciones previas, encadenar lógica, auditoría — 
	menos común que un simple SELECT de resultados, pero sí se usa seguido en sistemas reales. */

