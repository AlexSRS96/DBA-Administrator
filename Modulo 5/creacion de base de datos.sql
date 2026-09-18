/*
			CREACION DE DATOS 

--NAME → nombre lógico del archivo (con el que SQL Server lo referencia internamente,
		 distinto del nombre físico del archivo).
--FILENAME → ruta física real en disco.
--SIZE → tamaño inicial reservado.
--MAXSIZE → tope máximo que puede crecer (si lo omites, crece "sin límite" hasta llenar el disco).
--FILEGROWTH → de cuánto en cuánto crece automáticamente cuando se llena (puede ser en MB o en %).

*/

CREATE DATABASE TiendaAvanzada
ON PRIMARY
(
	NAME = 'TiendaAvanzada_data',
	FILENAME = 'D:\SQL_DATA\TiendaAvanzada.mdf',
	SIZE = 50MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 10MB
)
LOG ON 
	(
		NAME='TiendaAvanzada_Log',
		FILENAME = 'D:\SQL_DATA\TiendaAvanzada.ldf',
		SIZE = 20MB,
		MAXSIZE = 100MB,
		FILEGROWTH = 10MB
	);

/*
	mdf = datos principales, 
	ndf = datos secundarios (opcional),
	ldf = log de transacciones.

	💡 SIZE/FILEGROWTH mal dimensionados = fragmentación. En producción 
	se calculan según crecimiento esperado, no se dejan por defecto.
*/