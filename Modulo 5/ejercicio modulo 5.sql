Use TiendaPractica
Go

Create table Empleado (
	Id_empleado int not null identity (1,1) Primary key,
	Nombre_empleado nvarchar(100) not null,
	Salario decimal (10,2) not null check(salario > 0),
	DNI nchar(8) not null unique,
	Email nvarchar(30) not null unique,
	Fecha_Contratacion date default (getdate())
);

Create nonclustered index IN_nombre_empleado
on Empleado(Nombre_empleado);

exec sp_helpindex empleado;

Create view Empleado_salario as 
		Select Nombre_empleado, Salario
		from Empleado
		group by Nombre_empleado, Salario

Select * from Empleado_salario;