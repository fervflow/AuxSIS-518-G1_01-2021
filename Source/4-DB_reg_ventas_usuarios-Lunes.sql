CREATE DATABASE registro_ventas_usuarios;
GO
USE registro_ventas_usuarios;
GO
CREATE TABLE cliente(
    id          INT IDENTITY(1, 1) PRIMARY KEY,
    nombre      VARCHAR(100),
    telefono    VARCHAR(20),
    fecha_nac   DATE,
)
CREATE TABLE producto(
    id          INT IDENTITY(100, 1) PRIMARY KEY,
    nombre      VARCHAR(20),
    stock       INT,
    precio_unit MONEY,
)
GO
CREATE TABLE venta(
    id              INT IDENTITY(1, 1) PRIMARY KEY,
    id_cliente      INT FOREIGN KEY REFERENCES cliente(id),
    fecha_hora      DATETIME,
    nombre_cliente  VARCHAR(100),
    detalle         TEXT,
    precio_total    MONEY,
)
GO
CREATE TABLE rt_producto_venta(
    id_venta    INT FOREIGN KEY REFERENCES venta(id),
    id_producto INT FOREIGN KEY REFERENCES producto(id),
    cantidad    INT,
    ppcantidad  MONEY,
)
GO

-- Insertando valores en la tabla 'cliente'
INSERT cliente VALUES
    ('Juan Perez', '77007700', '1995-09-09'),
    ('Alberto Ramos', '69707172', '1980-02-01'),
    ('Roberto Jimenez', '71717171', '1978-10-25'),
    ('Julio Iglesias', '76000000', '1989-01-30'),
    ('Manuel Arias', '62-2-1010', '1970-05-05'),
    ('Ariana Arteaga', '65606060', '2000-08-27'),
    ('Zulma Rojas', '68101010', '1999-12-18')
GO
SELECT * FROM cliente;

-- Insertando valores en la tabla 'producto'
INSERT producto VALUES
    ('Galletas 1', 100, 1.00),
    ('Galletas 2', 30, 5.00),
    ('Bebida 1', 45, 9.50),
    ('Bebida 2', 60, 5.50),
    ('Masticable 1', 200, 0.50),
    ('Chocolate 1', 40, 3),
    ('Chocolate 2', 89, 1.50),
    ('Agua', 100, 3)
GO
SELECT * FROM producto;

-- Insertando valores en la tabla 'venta'
INSERT venta VALUES
    (3, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (4, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (6, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (3, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (1, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (2, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (3, GETDATE(), NULL, NULL, NULL)
INSERT venta VALUES
    (7, GETDATE(), NULL, NULL, NULL)

SELECT * FROM venta;
SELECT * FROM producto;


-- Insertando valores en la tabla 'rt_producto_venta'
INSERT rt_producto_venta VALUES
    (1, 102, 1, NULL),
    (1, 105, 3, NULL),
    (1, 100, 2, NULL),
    (2, 102, 5, NULL),
    (2, 106, 5, NULL),
    (3, 103, 15, NULL),
    (4, 107, 2, NULL),
    (4, 101, 1, NULL),
    (5, 104, 15, NULL),
    (6, 100, 3, NULL),
    (6, 101, 2, NULL),
    (6, 102, 1, NULL),
    (6, 103, 4, NULL),
    (6, 105, 5, NULL),
    (6, 106, 10, NULL),
    (6, 107, 3, NULL),
    (7, 103, 1, NULL),
    (8, 102, 5, NULL),
    (8, 106, 10, NULL),
    (8, 104, 5, NULL)
GO
SELECT * FROM rt_producto_venta;


-- Actualizar el valor del precio por cantidad de la tabla 'rt_producto_venta'
UPDATE rt_producto_venta SET ppcantidad =
        (SELECT producto.precio_unit FROM producto WHERE producto.id = 100 ) *
        (SELECT rpv.cantidad FROM rt_producto_venta AS rpv WHERE rpv.id_venta = 1
                AND rpv.id_producto = 100)
WHERE rt_producto_venta.id_venta = 1
    AND rt_producto_venta.id_producto = 100;
GO

-- Actualizacion de todos los valores de la tabla con sus valores correspondientes
UPDATE rt_producto_venta 
SET ppcantidad = cantidad * producto.precio_unit
FROM rt_producto_venta
INNER JOIN producto ON producto.id = rt_producto_venta.id_producto;
GO
SELECT * FROM rt_producto_venta;
