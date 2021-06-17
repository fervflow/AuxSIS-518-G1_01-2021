SELECT * FROM cliente;
SELECT * FROM producto;
SELECT * FROM venta;
SELECT * FROM venta_producto;

-- Actualizar el dato de precio acumulado de la tabla venta_producto,
-- de la venta con id 101 e id_producto 4

UPDATE venta_producto
SET precio_acum = venta_producto.cantidad *
            (SELECT precio_unit FROM producto
            WHERE id = 4)
WHERE venta_producto.id_venta = 101
    AND venta_producto.id_producto = 4;
GO


-- Actualizar el dato de precio acumulado de la tabla venta_producto,
-- de todas las filas
    --
SELECT * FROM venta_producto, producto
WHERE venta_producto.id_producto = producto.id;

SELECT * FROM venta_producto
INNER JOIN producto
ON venta_producto.id_producto = producto.id;


UPDATE venta_producto
SET precio_acum = vp.cantidad * p.precio_unit
FROM venta_producto vp
INNER JOIN producto p
ON vp.id_producto = p.id;

-- Actualizar el dato de nombre_cliente de la tabla venta,
-- de todas las filas

SELECT * FROM cliente AS c
INNER JOIN venta AS v
ON c.id = v.id_cliente;

UPDATE venta
SET nombre_cliente = c.nombre
FROM cliente AS c
INNER JOIN venta v
ON c.id = v.id_cliente;

SELECT * FROM venta;

-- Actualizar la columna de precio_total de la tabla venta con sus datos correspondientes

SELECT * FROM venta_producto WHERE id_venta = 100;
SELECT SUM(precio_acum) FROM venta_producto WHERE id_venta = 100;


SELECT * FROM venta;

SELECT id_venta, SUM(precio_acum) AS 'precio total' FROM venta_producto
GROUP BY id_venta;

SELECT * FROM venta
INNER JOIN (SELECT id_venta, SUM(precio_acum) AS 'precio total'
            FROM venta_producto
            GROUP BY id_venta) AS sum_precios
ON venta.id = sum_precios.id_venta;

UPDATE venta
SET precio_total = sum_precios.[precio total]
FROM venta v
INNER JOIN (SELECT id_venta, SUM(precio_acum) AS 'precio total'
            FROM venta_producto
            GROUP BY id_venta) AS sum_precios
ON v.id = sum_precios.id_venta;
GO