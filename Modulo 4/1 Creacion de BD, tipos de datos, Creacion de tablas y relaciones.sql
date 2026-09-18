/*

TIPOS DE DATOS

/*
=====================================================
TIPOS DE DATOS SQL SERVER - RESUMEN
=====================================================

--- TEXTO ---
CHAR(n)      -> Largo FIJO, sin Unicode. Uso: códigos fijos (ej "PE"). Poco usado.
VARCHAR(n)   -> Largo VARIABLE, sin Unicode. Uso: texto sin tildes/ñ garantizado. Uso medio.
NCHAR(n)     -> Largo FIJO, con Unicode. Casi no se usa.
NVARCHAR(n)  -> Largo VARIABLE, con Unicode (tildes, ñ, etc). *** EL MAS USADO HOY ***
   -> La "N" = soporta Unicode. Sin "N" = solo caracteres básicos (ASCII).

--- NUMERICOS ---
INT            -> Entero. Rango: -2,147,483,648 a 2,147,483,647. *** EL MAS USADO ***
BIGINT         -> Entero grande, para IDs con millones/billones de filas.
TINYINT        -> Entero pequeño, 0 a 255.
DECIMAL(p,e)   -> Decimal EXACTO. p = total de dígitos, e = decimales. Ej: DECIMAL(10,2)
                  *** USAR SIEMPRE PARA DINERO ***
FLOAT          -> Decimal APROXIMADO (error de redondeo). Evitar para dinero.

--- FECHAS ---
DATE       -> Solo fecha. Muy usado.
DATETIME2  -> Fecha + hora. *** EL RECOMENDADO HOY ***
DATETIME   -> Fecha + hora (versión antigua). Obsoleto en proyectos nuevos.

--- BOOLEANO ---
BIT  -> 0 (falso) o 1 (verdadero). Único tipo para esto en SQL Server.
        SQL Server NO tiene tipo BOOLEAN (a diferencia de PostgreSQL/MySQL).

=====================================================
RESUMEN RAPIDO
=====================================================
Texto en español -> NVARCHAR(n)
Dinero           -> DECIMAL(p,e)   [nunca FLOAT]
IDs/enteros      -> INT
Fechas           -> DATE (solo fecha) / DATETIME2 (fecha+hora)
Si/No            -> BIT
(n) en texto     -> restricción de cantidad máxima de caracteres
=====================================================
*/
*/


/*

CREACION DE BASE DE DATOS

	¿Para qué sirve? Crea una base de datos nueva vacía, con el nombre que le des. 
	SQL Server automáticamente crea los archivos .mdf (datos) y .ldf (log) en la ruta por defecto del servidor
	— no tuviste que especificarla como en la imagen que viste antes
	(esa era una forma más manual/explícita de hacerlo, que veremos en el Módulo 5).
*/

CREATE DATABASE TiendaPractica;
GO

/*¿Para qué sirve? Le dice a SQL Server "a partir de ahora, todo lo que ejecute aplícalo 
dentro de esta base de datos". Es obligatorio ejecutarlo antes de crear tablas — 
si no, podrías terminar creando tablas en la base de datos equivocada (por defecto, 
en master, que es una base de datos del sistema y no debe tocarse).*/

USE TiendaPractica;
GO

/* 
		CREACION DE TABLAS
*/
CREATE TABLE Cliente (
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
    NombreCliente VARCHAR(100) NOT NULL
);
/*
-CREATE TABLE Cliente (...) → crea una tabla nueva llamada Cliente.
-IdCliente INT PRIMARY KEY → define la columna IdCliente como número entero (INT) y como clave primaria.
-IDENTITY(1,1) → hace que SQL Server genere automáticamente el valor de esa columna (empezando en 1, incrementando de 1 en 1) — no necesitas escribirlo tú mismo al insertar datos.
-NombreCliente VARCHAR(100) NOT NULL → columna de texto, hasta 100 caracteres, que no puede quedar vacía (NOT NULL).*/

CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    Categoria NVARCHAR(50) NULL
);

/*
-IdProducto INT PRIMARY KEY IDENTITY(1,1) → mismo patrón que en Cliente: ID autonumérico como clave primaria.
-NombreProducto NVARCHAR(100) NOT NULL → texto obligatorio, hasta 100 caracteres.
-Categoria NVARCHAR(50) NULL → aquí uso NULL explícito (aunque es el comportamiento por defecto) 
para que quede claro que sí puede quedar vacía — no todo producto necesita categoría obligatoriamente.*/

CREATE TABLE Venta (
    IdVenta INT PRIMARY KEY IDENTITY(1,1),
    IdCliente INT NOT NULL,
    FechaVenta DATE NOT NULL,
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);
/*
-IdVenta INT PRIMARY KEY IDENTITY(1,1) → mismo patrón de siempre: ID autonumérico como PK.
-IdCliente INT NOT NULL → la columna que va a funcionar como FK. NOT NULL porque toda venta 
 debe tener un cliente asociado (no puede quedar sin dueño).
-FechaVenta DATE NOT NULL → usamos DATE (solo fecha, sin hora) porque para este ejemplo no necesitamos 
 precisión de hora — si la necesitaras, sería DATETIME2.
-CONSTRAINT FK_Venta_Cliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente) → esta es la parte nueva,
 vamos a detenernos aquí porque es importante:
-CONSTRAINT FK_Venta_Cliente → le pones un nombre a esta restricción (convención común: FK_TablaHija_TablaPadre).
 Ponerle nombre te ayuda después si necesitas eliminarla o identificarla en un error.
-FOREIGN KEY (IdCliente) → indica que la columna IdCliente de esta tabla (Venta) es una clave foránea.
-REFERENCES Cliente(IdCliente) → indica a qué tabla y columna apunta esa FK — en este caso,
 a IdCliente en la tabla Cliente.*/

 CREATE TABLE DetalleVenta (
    IdVenta INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_DetalleVenta PRIMARY KEY (IdVenta, IdProducto),
    CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (IdVenta) REFERENCES Venta(IdVenta),
    CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);
/*
-IdVenta INT NOT NULL y IdProducto INT NOT NULL → aquí no les pongo PRIMARY KEY individualmente como antes, 
 porque la PK va a ser compuesta (definida aparte, abajo).
-Cantidad INT NOT NULL → cuántas unidades de ese producto se vendieron en esa venta.
-PrecioUnitario DECIMAL(10,2) NOT NULL → el precio al que se vendió (recuerda: DECIMAL para dinero, nunca FLOAT).
-CONSTRAINT PK_DetalleVenta PRIMARY KEY (IdVenta, IdProducto) → esta es la novedad clave: así se define 
 una PK compuesta en SQL Server — le das un nombre a la restricción, y le pasas las dos columnas juntas 
 entre paréntesis. Esto es exactamente lo que practicaste tantas veces en 
 normalización (Venta+Producto como clave compuesta), ahora hecho en código real.
-CONSTRAINT FK_DetalleVenta_Venta ... y CONSTRAINT FK_DetalleVenta_Producto ... → dos FKs, una hacia cada 
tabla padre — igual que hiciste en tus diagramas ER.*/ 