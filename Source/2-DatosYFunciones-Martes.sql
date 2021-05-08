CREATE DATABASE datos_funciones;
GO
USE datos_funciones;
GO
CREATE TABLE estudiantes (
    ru          INT PRIMARY KEY,
    nombre      VARCHAR(50),
    ap_paterno  VARCHAR(30),
    ap_materno  VARCHAR(30),
    fecha_nac   DATE,
    peso        NUMERIC(5, 2),
)

SELECT * FROM estudiantes;

INSERT INTO estudiantes (ru, nombre, ap_paterno, ap_materno, fecha_nac, peso)
VALUES (10101, 'Erick', 'Velasco', 'Flores', '1999-01-01', 70.5)

INSERT estudiantes VALUES
    (20202, 'Maria', 'Romay', NULL, '1995-12-25', 50.7),
    (45555, 'Jose', 'Zuleta', 'Zegarra', '1990-12-31', 80.0)

INSERT estudiantes (nombre, ap_materno, ru) VALUES
    ('Juan', 'Perez', 33333)


SELECT nombre, ru FROM estudiantes ORDER BY nombre DESC;

SELECT nombre, peso FROM estudiantes
WHERE peso >= 50 AND peso <= 70;

SELECT nombre, peso FROM estudiantes
WHERE peso BETWEEN 50 AND 80;

-- Alias
SELECT ru AS 'Registro Universitario' FROM estudiantes;

SELECT ru, nombre FROM estudiantes AS e;

SELECT ru 'registro Universitario', nombre FROM estudiantes e;


UPDATE estudiantes SET fecha_nac = '2000-02-29'
WHERE ru = 33333;

UPDATE estudiantes SET peso = 60.3
WHERE ru = (SELECT ru FROM estudiantes
            WHERE nombre = 'Juan'
            AND ap_materno = 'Perez'
            AND fecha_nac = '2000-02-29');

-- Mostrar el nombre y ap. paterno de los estudiantes que tengan el ru
-- entre 20000 y 35000, que hayan nacido en el 1998 o despues y que pesen
-- menos de 70 kg.
SELECT nombre, ap_paterno FROM estudiantes
    WHERE ru BETWEEN 20000 AND 35000
    AND fecha_nac >= '1994-01-01'
    AND peso < 70;


SELECT GETDATE();

SELECT GETDATE() AS 'Fecha y hora actual';

SELECT DATEDIFF(DAY, '2020-01-01', GETDATE());

SELECT DATEDIFF(DAY, '2020-01-01', '2021-01-01');

SELECT DATEDIFF(qq, '2018-01-01', '2019-01-01');

SELECT DATEDIFF(WEEK, '2021-01-01', GETDATE());


-- funciones matematicas
SELECT nombre, SQRT(SQUARE(peso)) FROM estudiantes
WHERE ru = 10101;

SELECT nombre, SQRT(POWER(peso, 4)) FROM estudiantes
WHERE ru = 10101;