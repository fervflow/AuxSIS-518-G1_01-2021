SELECT * FROM dbo.cliente;
SELECT * FROM dbo.producto;
SELECT * FROM dbo.venta;
SELECT * FROM dbo.rt_producto_venta;

-- Obtener el monto total del precio de los productos de la venta con id 2
SELECT SUM(pv.precio_acum) AS "Precio total" FROM rt_producto_venta AS pv
WHERE pv.id_venta = 2;
GO

-- Actializar el precio total de la venta con id 2
UPDATE venta
SET precio_total = (SELECT SUM(pv.precio_acum)
                    FROM rt_producto_venta AS pv
                    WHERE pv.id_venta = 2)
WHERE id = 2;
GO

-- Select que muestra los datos de la tabla venta y rt_producto_venta unidos y filtrados por el id de venta
SELECT * FROM venta v, rt_producto_venta pv
WHERE v.id = pv.id_venta;
GO

SELECT * FROM venta;

-- Obtencion del monto total del precio de los productos de todas las ventas
SELECT id_venta, SUM(precio_acum) AS 'Precio total' FROm rt_producto_venta AS pv
GROUP BY id_venta;
GO

-- Actualizacion del precio total de todas las ventas a su valor correspondiente
UPDATE venta
SET precio_total = sum_precios.precio_total
FROM venta v
INNER JOIN (SELECT id_venta, SUM(precio_acum) AS 'precio_total'
            FROM rt_producto_venta AS pv
            GROUP BY id_venta) AS sum_precios
ON v.id = sum_precios.id_venta;
GO


-- Crear un procedimiento almacenado para resgistrar un producto de una venta,
-- con sus cosrrespondientes controles

CREATE OR ALTER PROCEDURE up_registro_producto_venta
    @id_venta INT = 0,
    @id_producto INT,
    @cantidad INT = 0
AS
    IF @cantidad = 0
    BEGIN
        SET @cantidad = (SELECT stock FROM producto WHERE id = @id_producto);
    END
    IF @cantidad <= (SELECT stock FROM producto WHERE @id_producto = id)
    BEGIN
        PRINT 'Existe stock para este producto'
        UPDATE producto SET stock = stock - @cantidad WHERE id = @id_producto;
        
        DECLARE @precio_acumulado MONEY = @cantidad *
                                        (SELECT precio_unit FROM producto
                                        WHERE id = @id_producto);
        
        IF @id_venta = 0
        BEGIN
            SET @id_venta = (SELECT TOP 1 id FROM venta ORDER BY id DESC)
        END

        INSERT INTO rt_producto_venta VALUES
            (@id_venta, @id_producto, @cantidad, @precio_acumulado);
        
        PRINT 'El producto de la venta fue registrado exitosamente';
    END
    ELSE
    BEGIN
        PRINT 'No existe stock suficiente para la cantidad que se desea comprar'
    END
GO

-- Registrando una nueva venta
INSERT venta (id_cliente, fecha_hora) VALUES
    (11, GETDATE());
GO

-- Prueba registrando el producto de una venta con todos los parametros
EXECUTE dbo.up_registro_producto_venta 9, 102, 3;

-- Prueba registrando el producto de una venta omitiendo el parametro de id de venta
EXEC dbo.up_registro_producto_venta @id_producto = 104, @cantidad = 5;

-- Prueba registrando el producto de una venta con solo el parametro del id de producto
EXEC dbo.up_registro_producto_venta @id_producto = 101;
