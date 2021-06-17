-- venta (*id, id_cliente, fecha_hora)
-- producto (*id, nombre, stock, precio)
-- contiene (id_venta, id_producto, cantidad, precio_a)
-- cliente (*id, nombre, telf, fecha_nac)

CREATE DATABASE reg_ventas_usuarios;
GO
USE reg_ventas_usuarios;
GO

CREATE TABLE producto (
    id          INT IDENTITY PRIMARY KEY,
    nombre      VARCHAR(50),
    stock       INT,
    precio_unit MONEY,
)
CREATE TABLE cliente (
    id          INT IDENTITY PRIMARY KEY,
    nombre      VARCHAR(100),
    telf        VARCHAR(15),
    fecha_nac   DATE,
)
GO
CREATE TABLE venta (
    id              INT IDENTITY (100, 1) PRIMARY KEY,
    id_cliente      INT FOREIGN KEY REFERENCES cliente(id),
    fecha_hora      DATETIME,
    nombre_cliente  VARCHAR(100),
    detalle         TEXT,
    precio_total    MONEY,
)
GO
CREATE TABLE venta_producto (
    id_venta    INT FOREIGN KEY REFERENCES venta(id),
    id_producto INT FOREIGN KEY REFERENCES producto(id),
    cantidad    INT,
    precio_acum MONEY,
)
GO

INSERT cliente VALUES
    ('Alexander Zuleta', '62-2-2020', '1990-05-20'),
    ('Maria Gonzales', '79707007', '1997-01-29'),
    ('Ariana Lacoa', '62-4-1010', '2001-12-10'),
    ('Marcos Fernandez', '65505040', '1999-08-14')
GO
SELECT * FROM cliente;

INSERT producto VALUES
    ('Chocolate 1', 30, 2.5),
    ('Chocolate 2', 60, 5.0),
    ('Galletas 1', 95, 1.5),
    ('Galletas 2', 46, 4.5),
    ('Bebida 1', 20, 12),
    ('Bebida 2', 38, 5),
    ('Agua', 41, 3),
    ('Masticable', 120, 0.5),
    ('Chicle 1', 78, 1),
    ('Papas Fritas', 24, 5)
GO
SELECT * FROM producto;
GO

INSERT venta (id_cliente, fecha_hora) VALUES
    (2, CONVERT(DATETIME, '2021-04-17 12:45:19', 21)),
    (4, GETDATE());
INSERT venta (id_cliente, fecha_hora) VALUES
    (2, CONVERT(DATETIME, '2021-05-17 18:10', 121)),
    (2, GETDATE());
GO

SELECT * FROM venta;
SELECT * FROM producto;

INSERT venta_producto (id_venta, id_producto, cantidad) VALUES
    (100, 5, 2),
    (100, 2, 5),
    (100, 10, 2),
    (101, 2, 1),
    (101, 4, 5),
    (101, 7, 1),
    (101, 8, 10),
    (102, 2, 3),
    (102, 3, 2),
    (102, 6, 1),
    (102, 8, 2),
    (103, 5, 6),
    (103, 9, 12);
GO
SELECT * FROM venta_producto;

-- Actualizar el precio acumulado correspondiente de la venta con
-- id_venta 104 e id_producto 4

UPDATE venta_producto SET precio_acum = cantidad *
    (SELECT producto.precio_unit FROM producto
     WHERE producto.id = 4)
WHERE id_venta = 104 AND id_producto = 4;
GO

-- Actualizar el precio acumulado correspondiente de todos los productos en
-- la tabla venta_producto

UPDATE venta_producto
SET venta_producto.precio_acum = venta_producto.cantidad * producto.precio_unit
FROM venta_producto INNER JOIN producto
ON producto.id = venta_producto.id_producto;
GO

SELECT * FROM venta_producto;

SELECT venta_producto.cantidad, producto.precio_unit FROM venta_producto INNER JOIN producto
ON producto.id = venta_producto.id_producto;