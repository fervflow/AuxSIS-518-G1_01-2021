-- PROCEDIMIENTOS ALMACENADOS

-- CREATE PROCEDURE | PROC      - para crear
-- ALTER PROCEDURE | PROC       - para redefinir

-- Crear un procedimiento almacenado que permita registrar un cliente, controlando que sea mayor de edad
-- y si el telefono es celular debe ser unico
CREATE OR ALTER PROCEDURE up_verificar_cliente
@nombre VARCHAR(100), @telf VARCHAR(20), @fecha_nac DATE
AS
    DECLARE @insertar BIT = 'false';
    IF dbo.ufn_calcular_diferencia_anyos(@fecha_nac, GETDATE()) >= 18
    BEGIN
        IF NOT @telf LIKE '%-%-%'
        BEGIN
            IF EXISTS (SELECT * FROM cliente WHERE @telf = telefono)
            BEGIN
                PRINT 'Error: El telefono celular del cliente que intenta registrar ya se encuentra registrado para otro cliente'
                SET @insertar = 'false';
            END
            ELSE
            BEGIN
                SET @insertar = 'true';
                PRINT 'El telefono es de tipo celular';
            END
        END
        ELSE
        BEGIN
            PRINT 'El telefono es de tipo fijo';
            SET @insertar = 'true';
        END
    END
    ELSE
    BEGIN
        PRINT 'La persona que intenta registrar no es mayor de edad';
    END
    IF @insertar = 'true'
    BEGIN
        INSERT INTO cliente VALUES (@nombre, @telf, @fecha_nac);
        PRINT 'El cliente ha sido registrado correctamente';
    END
GO

    -- Prueba de insercion correcta
EXECUTE up_verificar_cliente 'Mario Perez', '61707080', '1995-02-20';
    -- Prueba de insercion de un cliente no mayor de edad
EXECUTE up_verificar_cliente 'Maria Gutierrez', '72101010', '2005-12-10';

    -- Prueba de insercion de un cliente con telefono celular ya existente
EXEC up_verificar_cliente 'Carlos Limachi', '71717171', '1970-05-25';
    -- Prueba de insercion de un cliente con telefono fijo
EXEC up_verificar_cliente 'Marcos Davis', '62-4-1010', '1990-06-25';
    -- Prueba de insercion correcta
EXEC up_verificar_cliente 'Miguel Loayza', '65202020', '1987-09-12';

GO

SELECT * FROM dbo.cliente;
SELECT * FROM dbo.producto;
SELECT * FROM dbo.venta;
SELECT * FROM dbo.rt_producto_venta;