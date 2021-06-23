-- TRIGGER | Disparador o Desencadenador
/*
    ddl = data definition language (lenguaje de definicion de datos)
            - CREATE
            - ALTER
            - DROP
            - TRUNCATE
            - RENAME
    dml = data manipulation language (lenguaje de manipulacion de datos)
            - INSERT
            - DELETE
            - SELECT
            - UPDATE
*/
-- CREACION DE UN TRIGGER
-- [CREATE | ALTER | CREATE OR ALTER] TRIGGER nombre_trigger
-- Trigger que muestra un mensaje cuando se insertan datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_insert
ON cliente      -- ON [nombre_tabla|nombre_vista]
AFTER INSERT      -- [FOR|AFTER|INSTEAD OF] [INSERT [,] DELETE [,] UPDATE]
AS
    PRINT 'Se insertaron datos en la tabla cliente';
GO
    -- Prueba de insercion
INSERT INTO cliente VALUES ('Martin Antequera', '67344556', NULL);
GO


-- Trigger que muestra un mensaje cuando se eliminan datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_delete
ON cliente
AFTER DELETE
AS
    PRINT 'Se eliminaron datos de la tabla cliente'
GO
    -- Prueba de eliminacion
DELETE FROM cliente WHERE id IN (13,14);
GO


-- Trigger que muestra un mensaje cuando se actualizan datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_update
ON cliente
FOR UPDATE
AS
    PRINT 'Se actualizaron datos en la tabla cliente';
GO
    -- Prueba de actualizacion
UPDATE cliente
SET fecha_nac = '2003-03-21'
WHERE id = 15;
GO

-- HABILITAR O DESHABILITAR UN TRIGGER
-- [ENABLE | DISABLE] TRIGGER nombre_trigger ON nombre_tabla
-- Deshabilitando el trigger
DISABLE TRIGGER tr_cliente_insert ON cliente;
GO
    -- Insertando un dato para verificar que el trigger esta deshabilitado
INSERT cliente VALUES ('Xiomara Rocha', '62-4-8080', NULL);
GO

-- Habilitando el trigger
ENABLE TRIGGER tr_cliente_insert ON cliente;
GO
    -- Insertando un dato para verificar que el trigger esta habilitado
INSERT cliente VALUES ('Andres Soria', '62-2-2121', NULL);
GO


-- Creacion de una tabla para el registro de cambios en la tabla cliente
CREATE TABLE registro_cambios_cliente(
    id          INT IDENTITY,
    fecha_hora  DATETIME,
    detalle     VARCHAR(MAX),
)
GO

-- Trigger que registra que se insertaron datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_insert
ON cliente
FOR INSERT
AS
    SET NOCOUNT ON
    INSERT INTO registro_cambios_cliente VALUES (GETDATE(), 'Se insertaron datos en la tabla');
GO

-- Trigger que registra que se eliminaron datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_delete
ON cliente
FOR DELETE
AS
    SET NOCOUNT ON
    INSERT INTO registro_cambios_cliente VALUES (GETDATE(), 'Se eliminaron datos de la tabla')
GO

-- Trigger que registra que se actualizaron datos en la tabla cliente
CREATE OR ALTER TRIGGER tr_cliente_update
ON cliente
FOR UPDATE
AS
    SET NOCOUNT ON
    INSERT INTO registro_cambios_cliente VALUES (GETDATE(), 'Se actualizaron datos de la tabla')
GO


    -- Probando de insercion
INSERT cliente VALUES
    ('Angela Rocha', '62-4-8080', NULL),
    ('Xiomara Rocha', '62-4-8080', NULL);
INSERT cliente VALUES
    ('Andres Pirlo', '77121234', NULL);
INSERT cliente VALUES
    ('Tito Rocha', '72121212', NULL);
GO

    -- Prueba de eleminacion
DELETE FROM cliente WHERE id IN (SELECT TOP(2) id FROM cliente ORDER BY id DESC) OR id = 20;
GO

    -- Prueba de actualizacion
UPDATE cliente
SET fecha_nac = '1990-02-23'
WHERE id IN (SELECT id FROM cliente
            WHERE nombre LIKE '%Rocha%'
            AND telefono = '62-4-8080');
GO

-- Verificando los cambios registrados
SELECT * FROM registro_cambios_cliente;
