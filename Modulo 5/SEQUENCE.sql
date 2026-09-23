Use TiendaPractica
Go

/*						
							SEQUENCE
Puntual: genera números correlativos, igual que IDENTITY, pero independiente de 
cualquier tabla — no está atada a una columna específica.  */

Create Sequence SeqFactura
Start with 1000
increment by 1;

--Puntual: cada vez que ejecutas esto, te da el siguiente número (1000, luego 1001, 1002...).
SELECT NEXT VALUE FOR SeqFactura;


--Puntual: así usas la secuencia como valor por defecto de una PK, en vez de IDENTITY.
CREATE TABLE Factura (
    IdFactura INT PRIMARY KEY DEFAULT (NEXT VALUE FOR SeqFactura),
    IdCliente INT NOT NULL
);

/*
    SEQUENCE = generador de números independiente de tablas, se puede compartir entre varias.
    IDENTITY = sigue siendo el estándar para PK simples; SEQUENCE es para casos especiales 
               (numeración compartida o necesitas el valor antes de insertar).*/