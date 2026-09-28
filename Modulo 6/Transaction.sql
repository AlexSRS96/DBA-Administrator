USE TiendaPractica
GO
/*
					TRANSACCIONES
*/

--vamos agregar la columna stock a la abla producto porque inicialmente no lo tenia
ALTER TABLE PRODUCTO ADD stock INT NOT NULL DEFAULT 0;
--validando
Select * from Producto
--vamos actualizar el stock de un producto
Update Producto set stock = 5 where IdProducto = 1;

--BEGIN TRANSACTION → marca el inicio de un bloque de operaciones que deben ejecutarse todas juntas, o ninguna.
BEGIN TRANSACTION;
UPDATE Producto SET stock = stock -1 WHERE IdProducto = 1;
INSERT INTO Venta (IdCliente, FechaVenta) VALUES (1, GETDATE());
/*COMMIT TRANSACTION → confirma y guarda definitivamente todos los cambios del bloque. 
						Si algo falla entre medio, nada de lo anterior queda guardado (a menos que hagas*/
COMMIT TRANSACTION;

/*VERIFICANDO CON SELECT*/
select * from Producto
select * from venta

/*ROLLBACK explícito, como verás abajo) — pero ojo: sin manejo de errores, 
	SQL Server no revierte solo automáticamente en todos los casos, por eso se combina con TRY/CATCH.*/

--CON MANEJO DE ERRORES (la forma correcta y real)
BEGIN TRY
	BEGIN TRANSACTION;
	UPDATE Producto SET Stock = stock -1 where IdProducto=1;
	IF(SELECT stock FROM Producto WHERE IdProducto = 1) <0
		THROW 50000, 'Stock insuficiente', 1;
	INSERT INTO Venta (IdCliente, FechaVenta) VALUES (1, GETDATE());
	COMMIT TRANSACTION;
	PRINT 'Transaccion exitosa';
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	PRINT 'error ' + ERROR_MESSAGE();
END CATCH

/*
1 begin try y begin catch es para control de errores como el try catch que exite en c# por ejemplo.
2 begin transac... empieza el codigo a ejecutar.
3 va hacer un update a la columna stock restando -1 cuando el idpro.. es = 1.
4 el if va hacer la validacion si el stock es menor a 0 mostrara el mensaje stock insuficiente y  
  ya no ejecutara el insert into en venta.
5 el commit es final del codigo de transaccion.
6 print escribe un mensaje .
7 end try acaba el try .
8 inicia el catch y ejecuta el rollback e imprime el mensaje error mas el mensaje de error y finaliza el catch.

--en conclusion si el stock llegara a 0 se detendria en el if y ya no seguiria ejecutando y pasaria a catch

*/

SELECT COUNT(*) FROM Venta WHERE IdCliente = 1;