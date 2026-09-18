Use master;
GO

Create Database ColegioPractica;
GO

Use ColegioPractica;
GO

create table Curso (
	id_curso int primary key identity (1,1),
	Nombre_curso varchar (80) not null,
	CreditosHoras int not null
)

create table Alumno (
	id_alumno int primary key identity (1,1),
	Nombre_alumno varchar (80) not null,
	Fecha_nacimiento datetime2
)

create table Matricula (
	id_matricula int primary key identity (1,1),
	id_alumno int not null,
	fecha_matricula datetime2 not null
		Constraint FK_Matricula_Alumno Foreign Key (id_alumno) references Alumno (id_alumno)
	)

	create table Detalle_Matricula (
		id_matricula int not null,
		id_curso int not null,
		Nota decimal (4,2) null,
		Constraint PK_Detalle_matricula Primary key (id_matricula, id_curso),
		Constraint FK_DetMatricula_Matricula Foreign Key (id_matricula) references Matricula (id_matricula),
		Constraint FK_DetMatricula_Curso Foreign Key (id_curso) references Curso (id_curso),
	)

	/*ACTUALIZANDO O MODIFICANDO EL TIPO DE VALOR DE UNA COLUMNA*/

ALTER TABLE Curso
ALTER COLUMN Nombre_curso NVARCHAR(80) NOT NULL;

ALTER TABLE Alumno
ALTER COLUMN Nombre_alumno NVARCHAR(80) NOT NULL;

ALTER TABLE Alumno
ALTER COLUMN Fecha_nacimiento DATE NULL;

/*
-ALTER TABLE X ALTER COLUMN ... → redefine el tipo de una columna que ya existe, sin borrar la tabla ni sus datos.
-Debes repetir NOT NULL (o dejarlo sin nada = permite nulos) al hacer el ALTER, porque si no lo pones, 
SQL Server elimina esa restricción.			
*/