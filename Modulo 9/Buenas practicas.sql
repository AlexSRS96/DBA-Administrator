Use TiendaPractica
Go

/*		BUENAS PRACTICAS EN SQL SERVER			*/
-- ❌ Evitar: SELECT *
SELECT * FROM Venta;

-- ✅ Mejor: solo las columnas necesarias
SELECT IdVenta, FechaVenta FROM Venta;

-- ❌ Evitar: función sobre la columna indexada (anula el índice)
SELECT * FROM Venta WHERE YEAR(FechaVenta) = 2026;

-- ✅ Mejor: rango de fechas directo
SELECT * FROM Venta WHERE FechaVenta >= '2026-01-01' AND FechaVenta < '2027-01-01';

-- ❌ Evitar: subconsultas correlacionadas innecesarias cuando un JOIN basta
-- ✅ Preferir JOIN cuando sea posible (ya lo vimos en Módulo 4)