-- Crear una funcion que calcule la diferencia de años entre dos fechas
-- y que acepte como parametros ambas fechas

/*
    1. Verificar si la fecha final es menor a la fecha inicial
            Si es menor     -> Intercambiar el valor de las fechas

    2. Verificar la diferencia entre los años
            Si es igual     -> Retornar 0
            ir al paso 3

    2. Verificar la diferencia entre los meses
            Si es negativa  -> sumar la diferencia de años menos 1 al resultado
            Si es positiva  -> sumar la diferencia de años al resultado
            Si es 0         -> pasar al paso 3

    3. Verificar la diferencia entre los dias
            Si es negativa  -> sumar la diferencia de años menos 1 al resultado
            Si es 0 o mas   -> sumar la diferencia de años al resultado
    
    YEAR('2021-12-30')  -- Para extraer el año de una fecha
    MONTH('2021-12-30') -- Para extraer el mes de una fecha
    DAY('2021-12-30')   -- Para extraer el día de una fecha
*/
CREATE OR ALTER FUNCTION ufn_calcular_diferencia_anyos
(@fecha_ini DATE, @fecha_fin DATE)
RETURNS INT
AS
BEGIN
    DECLARE @anyo_ini AS INT;
    DECLARE @mes_ini AS INT;
    DECLARE @dia_ini AS INT;
    DECLARE @anyo_fin AS INT;
    DECLARE @mes_fin AS INT;
    DECLARE @dia_fin AS INT;
    DECLARE @aux AS DATE;
    DECLARE @resultado AS INT = 0;

    IF YEAR(@fecha_fin) < YEAR(@fecha_ini) 
    BEGIN
        SET @aux = @fecha_fin;
        SET @fecha_fin = @fecha_ini;
        SET @fecha_ini = @aux;
    END

    SET @anyo_ini = YEAR(@fecha_ini);
    SET @mes_ini = MONTH(@fecha_ini);
    SET @dia_ini = DAY(@fecha_ini);
    SET @anyo_fin = YEAR(@fecha_fin);
    SET @mes_fin = MONTH(@fecha_fin);
    SET @dia_fin = DAY(@fecha_fin);

    IF @anyo_fin = @anyo_ini
    BEGIN
        RETURN @resultado;    
    END
    ELSE BEGIN
        IF @mes_fin < @mes_ini
        BEGIN
            SET @resultado = @anyo_fin - @anyo_ini - 1;
        END
        ELSE
        BEGIN
            IF @mes_fin = @mes_ini
            BEGIN
                IF @dia_fin < @dia_ini
                BEGIN
                    SET @resultado = @anyo_fin - @anyo_ini - 1;
                END
                ELSE BEGIN
                    SET @resultado = @anyo_fin - @anyo_ini;
                END
            END
            ELSE BEGIN
                SET @resultado = @anyo_fin - @anyo_ini;
            END
        END
    END
    RETURN @resultado;
END
GO

SELECT dbo.ufn_calcular_diferencia_anyos('2011-01-10', '2021-01-02');
SELECT dbo.ufn_calcular_diferencia_anyos('2020-01-10', '2021-03-02');
SELECT dbo.ufn_calcular_diferencia_anyos('2021-01-02', '2011-01-12');
SELECT dbo.ufn_calcular_diferencia_anyos('2021-01-10', '2021-01-02');

GO
