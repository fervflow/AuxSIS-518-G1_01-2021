
-- EXECUTE nombre_procedimiento_almacenado @param1, @param2, @param3...;

-- EXEC nombre_procedimiento_almacenado @param1, @param2, @param3...;

SELECT * FROM rt_producto_venta;
GO
-- Renombrar la comlumna 'ppcantidad' de la tabla 'rt_producto venta' 

EXEC sp_rename 'rt_producto_venta.ppcantidad', 'precio_acum', 'COLUMN';
GO

SELECT * FROM cliente;
SELECT * FROM producto;
SELECT * FROM venta;
SELECT * FROM cliente;


-- Actualizar el nombre del cliente de la tabla venta, del registro con id 4

UPDATE venta SET nombre_cliente = (SELECT c.nombre FROM cliente c WHERE c.id = 3)
WHERE id = 4;
GO

SELECT * FROM venta, cliente WHERE venta.id_cliente = cliente.id;

SELECT * FROM venta v
INNER JOIN cliente c
ON v.id_cliente = c.id;
GO

-- Actualizacion de todos los valores de la columna 'nombre_cliente' de la tabla 'venta' con sus valores correspondientes
UPDATE venta SET venta.nombre_cliente = cliente.nombre
FROM venta
INNER JOIN cliente
ON venta.id_cliente = cliente. id;
GO

SELECT * FROM rt_producto_venta;

-- Actualizar el detalle con la concatenacion de nombre, precio unitario, cantidad y
-- precio acumulado de los productos de cada venta correspondiente (Por Terminar)
SELECT p.nombre, p.precio_unit, pv.cantidad, pv.precio_acum
FROM producto p, rt_producto_venta pv
WHERE p.id = pv.id_producto;
GO

SELECT pv.id_venta, p.nombre, p.precio_unit, pv.cantidad, pv.precio_acum
FROM producto p
INNER JOIN rt_producto_venta pv
ON p.id = pv.id_producto;
GO

    -- * Concatenado de texto
SELECT CONCAT('texto1', 'texto2', 'texto3');

SELECT 'texto1+ ' + 'texto2'+ ' ' + 'texto3';

SELECT STRING_AGG(pv.cantidad, ', ') FROM rt_producto_venta pv


SELECT pv.id_venta,
    CONCAT(p.nombre,' ', p.precio_unit,' ', pv.cantidad,' ', pv.precio_acum, ' ') AS 'detalle'
FROM producto p
INNER JOIN rt_producto_venta pv
ON p.id = pv.id_producto
GROUP BY pv.id_venta;


-- Actualizar todas las filas del precio total de la tabla 'venta' con sus valores correspondientes (Por Terminar)
SELECT * FROM venta
INNER JOIN
    (SELECT pv.id_venta, SUM(pv.precio_acum) AS 'p_total'
        FROM rt_producto_venta pv
        GROUP BY pv.id_venta) AS sumpv
ON venta.id = sumpv.id_venta


SELECT STRING_AGG(pv_agrupado.detalle_indiv, ', ') AS 'detalle'
FROM (SELECT pv.id_venta,
            CONCAT(p.nombre,' ', p.precio_unit,' ', pv.cantidad,' ', pv.precio_acum, ' ') AS 'detalle_indiv'
        FROM producto p
        INNER JOIN rt_producto_venta pv
        ON p.id = pv.id_producto) AS 'pv_agrupado';