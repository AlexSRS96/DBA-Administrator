USE TiendaPractica
GO

/* Stored Procedure: crea sp_ActualizarPrecio que reciba @IdProducto y @NuevoPrecio,
y actualice PrecioUnitario en DetalleVenta para ese producto (esto disparará tu trigger 
existente automáticamente — buen bonus para confirmar que ambos trabajan juntos).*/

exec sp_help 'detalleVenta';

CREATE PROCEDURE sp_ActualizarPrecio 
			@IdProducto int,
			@NuevoPrecio decimal (10,2)
AS
BEGIN 
	UPDATE DetalleVenta SET PrecioUnitario = @NuevoPrecio where IdProducto = @IdProducto 
END;

EXEC sp_ActualizarPrecio @IdProducto = 2, @NuevoPrecio = 85.80;
--eliminar un procedimiento
DROP PROCEDURE sp_ActualizarPrecio;

-- modificar un procedimiento
ALTER PROCEDURE sp_ActualizarPrecio ;
		/*.............................*/

select * from DetalleVenta
	
/*	Function: crea una función escalar fn_TotalVenta(@IdVenta) 
	que devuelva el total de una venta (cantidad × precio, sumado). 
	Pruébala con SELECT dbo.fn_TotalVenta(1);. */

/*CREATE FUNCTION fn_TotalVenta (@IdVenta int)
RETURNS TABLE
AS
		return(SELECT SUM(Cantidad*PrecioUnitario) as Total FROM DetalleVenta WHERE IdVenta = @IdVenta);*/
--eliminar funcion
drop function fn_totalVenta;

Select dbo.fn_TotalVenta(1);

CREATE FUNCTION dbo.fn_TotalVenta (@IdVenta INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = SUM(Cantidad * PrecioUnitario) FROM DetalleVenta WHERE IdVenta = @IdVenta;
    RETURN @Total;
END;
GO

/*	Trigger: crea un trigger AFTER DELETE sobre Producto que guarde en una tabla LogProductoEliminado 
	el producto que se borró (con fecha).
*/

CREATE TABLE LogProductoEliminado (
	IdLog	int identity (1,1) primary key,
	IdProducto int not null,
	NombreProducto nvarchar(100) not null,
	FechaEliminacion datetime default getdate()
)

CREATE TRIGGER trg_ProductoEliminado
ON producto
AFTER delete
AS
BEGIN
	insert into LogProductoEliminado (IdProducto, NombreProducto)
	Select d.IdProducto, d.NombreProducto
	From deleted d
END

delete from Producto
	where IdProducto = 5
 
Select * from LogProductoEliminado;

/*	Transacción: escribe una transacción con TRY/CATCH que inserte un nuevo Cliente
	y su primera Venta en un solo bloque — si algo falla, debe hacer ROLLBACK de ambos.*/

CREATE PROCEDURE sp_RegistrarClienteConVenta
	@NombreCliente nvarchar(100),
	@FechaVenta DATE
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION;
			INSERT INTO Cliente (NombreCliente) values (@NombreCliente);
			DECLARE @NuevoIdCliene int = SCOPE_IDENTITY();
			INSERT INTO Venta (IdCliente, FechaVenta) VALUES (@NuevoIdCliene, @FechaVenta);
			COMMIT TRANSACTION;
			PRINT 'Cliente y venta registrados correctamente';
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
			PRINT 'Error: ' + error_message();
	END CATCH;
END;

EXEC sp_RegistrarClienteConVenta @nombreCliente = 'Jaime Duarte', @FechaVenta = '2026-09-06'

Select * from Cliente;
select * from Venta;