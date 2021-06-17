SELECT * FROM cliente;
SELECT * FROM producto;
SELECT * FROM venta;
SELECT * FROM rt_producto_venta;
GO

-- FUNCIONES --

-- CREATE FUNCTION    - para crear
-- ALTER FUNCTION     - para redefinir
CREATE OR ALTER FUNCTION fn_listar_ventas_cliente
(@id INT)       -- Los parametros de opcionales de la funcion
RETURNS TABLE   -- Tipo de retorno que tendra la funcion
AS              -- Empieza la definicion de la funcion que retorna una tabla inline
RETURN(
    SELECT * FROM venta
    WHERE venta.id_cliente = @id
);
GO

    -- Ejecucion de la funcion con retorno de tabla
SELECT * FROM dbo.fn_listar_ventas_cliente(6);
GO

-- Crear una funcion para calcular la edad dada una fecha de nacimiento
CREATE OR ALTER FUNCTION ufn_calcular_edad
(@id INT)
RETURNS INT
AS          -- Empieza la definicion de la funcion que retorna un valor escalar
BEGIN
    DECLARE @edad INT;
    SELECT @edad = DATEDIFF(YEAR, fecha_nac, GETDATE()) FROM cliente
        WHERE id = @id;
    RETURN (@edad);
END
GO

SELECT dbo.ufn_calcular_edad(6) AS 'Edad';

SELECT * FROM cliente;

