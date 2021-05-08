CREATE DATABASE datosYFunciones;

USE datosYFunciones;

CREATE TABLE estudiantes (
    ru          INT PRIMARY KEY,
    nombre      VARCHAR(50),
    ap_paterno  VARCHAR(30),
    ap_materno  VARCHAR(30),
    fecha_nac   DATE,
    peso        NUMERIC(5, 2),
)
GO

SELECT * FROM estudiantes;

INSERT INTO estudiantes (ru, nombre, ap_paterno, ap_materno, fecha_nac, peso) VALUES
    (10000, 'Erick', 'Velasco', 'Flores', '1-1-1990', 70.00)
    
INSERT estudiantes VALUES
    (20000, 'Juan', 'Perez', NULL, '25-12-2000', 80.00),
    (30000, 'Ana', 'Zuleta', 'Gomez', '1-12-1998', 50.00)

INSERT estudiantes (ru, peso, nombre) VALUES
(12312, 65.00, 'Jose')

SELECT * FROM estudiantes;
 -- Aplicando alias a columna y tabla
SELECT ru AS 'Registro Universitario', nombre FROM estudiantes;

SELECT ru FROM estudiantes AS e WHERE e.ru BETWEEN 10000 AND 20000;

SELECT ru AS 'registro univ' FROM estudiantes WHERE ru >= 10000 AND ru <= 20000;

-- Actualizamos la tabla estudiantes, la fecha_nac al ru 12123
UPDATE estudiantes SET fecha_nac = '1997-12-12' WHERE ru = 12312;

-- Select con ANDs encadenados
SELECT ru AS 'registro univ', nombre, fecha_nac birthday FROM estudiantes
WHERE ru >= 12000
    AND fecha_nac > '1995-01-01'
    AND peso BETWEEN 50 AND 70;

-- Funcion para obtener la fecha y hora actual
SELECT GETDATE() AS 'Fecha y Hora actual';

-- Obtener un valor especifico de una fecha
SELECT YEAR('1995-01-01') AS 'A~o';

SELECT MONTH('1995-01-13') AS 'Mes';

SELECT DAY('1995-01-13') AS 'Dia';


-- Obtener la diferencia entre fechas
SELECT DATEDIFF(MS, '2021-04-26 18:09:21.463', GETDATE());



-- Funciones matematicas
SELECT POWER(peso, 2) FROM estudiantes
WHERE ru = 30000;SELECT MONTH('1995-01-13') AS 'Mes';


SELECT SQUARE(peso) FROM estudiantes
WHERE ru = 30000;SELECT MONTH('1995-01-13') AS 'Mes';

SELECT SQRT( POWER(peso, 2)) FROM estudiantes
WHERE ru = 30000;SELECT MONTH('1995-01-13') AS 'Mes';

USE datosYFunciones;

SELECT * FROM estudiantes;

-- Actualizar el dato de ap_materno, de Jose que nacio
-- el 1997-12-12 y pesa 65, sin usar el valor del ru

UPDATE estudiantes SET ap_materno = 'Gonzales'
WHERE ru = (SELECT ru FROM estudiantes
            WHERE nombre = 'Jose'
            AND fecha_nac = '1997-12-12'
            AND peso = 65);


SELECT ru FROM estudiantes
WHERE nombre = 'Jose'
    AND fecha_nac = '1997-12-12'
    AND peso = 65;
