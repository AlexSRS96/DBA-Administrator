use ColegioPractica
go

select * from Alumno 

insert into Alumno (Nombre_alumno, Fecha_nacimiento)
values ('Alex', '1996-11-14'),
	   ('Juan', '1986-11-18'),
	   ('Javier', '1926-11-22');

Select * from Curso

insert into Curso (Nombre_curso, CreditosHoras)
values ('Calculo 2', 4),
	   ('Transformacion Digital', 5),
	   ('Estadistica Descriptiva', 8);

Select * from Matricula

insert into Matricula (id_alumno, fecha_matricula)
values (2, '2026-04-03'),
	   (3, '2026-01-04'),
	   (4, '2025-08-22'),
	   (4, '2026-08-24');

Select * from Detalle_Matricula

insert into Detalle_Matricula (id_matricula, id_curso, Nota)
values (2, 1, 15),
		(3, 2, 18),
		(4, 3, 10),
		(5, 3, 15);

Select * from Alumno;

Select Nombre_curso from Curso where CreditosHoras >= 3;

Select * from Matricula order by fecha_matricula desc

Select distinct id_alumno from Matricula

/* LIMPIANDO TABLAS (BORRAR TODOS LOS REGISTROS)
	PARA ELLO NO DEBE HABER DEPENDENCIAS DE PK SI EN CASO FUERA ASI
	SE DEBE LIMPIAR LAS TABLAS DE LA OTRA ENTIDAD RELACIONADO AMBIEN

	*** POR ESO NO SE RECOMIENDA */

Truncate table detalle_matricula;

ALTER TABLE Detalle_Matricula DROP CONSTRAINT FK_DetMatricula_Curso;
truncate table curso;
ALTER TABLE Detalle_Matricula ADD CONSTRAINT FK_DetMatricula_Curso FOREIGN KEY (id_curso) REFERENCES Curso(id_curso);
