Use TiendaPractica
Go
/*
                                    Fragmentación de índices

    Puntual: con el uso (inserts/updates/deletes), los índices se fragmentan y pierden eficiencia.

    La fragmentación de índices mide qué tan "desordenados" quedaron físicamente los datos en disco 
    por el uso (inserts/updates/deletes) — a más fragmentación, más lento el índice para encontrar datos.
*/

/*  Puntual: es prácticamente siempre esa misma consulta — es la forma estándar en SQL Server de revisar
             fragmentación, usando la vista sys.dm_db_index_physical_stats. No cambia mucho entre versiones 
             ni entornos.
*/
SELECT 
    OBJECT_NAME(ips.object_id) AS Tabla,
    i.name AS Indice,
    ips.avg_fragmentation_in_percent AS Fragmentacion,
    ips.page_count AS Paginas
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) ips
INNER JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE i.name IS NOT NULL;

/*  Si supera ~10-30% de fragmentación, ejecuta REORGANIZE (leve) o REBUILD (fuerte) 
    sobre ese índice para reordenarlo y recuperar velocidad.

    Puntual: REORGANIZE = ligero, no bloquea la tabla. 
             REBUILD = reconstruye desde cero, más efectivo pero bloquea más (en Standard Edition).
*/

-- 5-30% fragmentado:
ALTER INDEX IX_Venta_IdCliente ON Venta REORGANIZE;

-- >30% fragmentado:
ALTER INDEX IX_Venta_IdCliente ON Venta REBUILD;