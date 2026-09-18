Use ColegioPractica
go
/* Muestra el nombre del alumno junto al nombre del curso y su nota, 
para todas las matrículas registradas (necesitas Alumno, Matricula, 
Detalle_Matricula, Curso — 3 JOINs).*/

select a.Nombre_alumno,c.Nombre_curso, dm.Nota, m.fecha_matricula
from alumno a inner join Matricula m on a.id_alumno = m.id_alumno
			  inner join Detalle_Matricula dm on m.id_matricula = dm.id_matricula
			  inner join Curso c on dm.id_curso = c.id_curso

/*	Muestra el promedio de notas por alumno 
	(nombre del alumno + su promedio), usando JOIN + GROUP BY.*/

select A.Nombre_alumno,AVG(dm.Nota) AS PromedioAlumno
from Alumno A inner join Matricula M on A.id_alumno = M.id_alumno
			  inner join Detalle_Matricula dm on M.id_matricula = dm.id_matricula
group by A.id_alumno, A.Nombre_alumno

/*	Usando LEFT JOIN, encuentra si hay algún curso que nunca ha sido 
	llevado por ningún alumno (sin matrículas asociadas).*/

Select C.Nombre_curso
from Curso C left join Detalle_Matricula Dm on C.id_curso = dm.id_curso
where dm.id_curso is null

/*	Muestra solo los alumnos que tienen más de una matrícula registrada 
	(pista: JOIN + GROUP BY + HAVING COUNT(...)).*/

select a.Nombre_alumno
From Alumno A inner join Matricula dm on A.id_alumno = dm.id_alumno
group by A.id_alumno, a.Nombre_alumno
having COUNT(dm.id_matricula) > 1

select * from alumno

select * from Matricula
