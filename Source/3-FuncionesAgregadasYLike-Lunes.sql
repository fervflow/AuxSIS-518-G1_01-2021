-- Funciones Agregadas

-- AVG() -> Average = promedio

    -- Mostrar el promedio de los pesos de los estudiantes
SELECT AVG(peso) FROM estudiantes;

    -- Mostrar el promedio de los pesos de los estudiantes que pesen entre 58 y 80
SELECT AVG(peso) AS 'Promedio de pesos entre 58 y 60' FROM estudiantes
WHERE peso BETWEEN 58 AND 80;

-- SUM() -> Suma

    -- Mostrar la suma total de los pesos de los estudiantes
SELECT SUM(peso) AS 'Total de pesos' FROM estudiantes;

    -- Mostrar las edades de los estudiantes, basado en las fechas de nacimiento
SELECT DATEDIFF(YY, fecha_nac, GETDATE()) 'Edad'
FROM estudiantes;

    -- Mostrar la suma de todas las edades, basado en las fechas de nacimiento
SELECT SUM(DATEDIFF(YY, fecha_nac, GETDATE())) 'Suma de edades'
FROM estudiantes;
    
-- MAX() -> maximo

    -- Mostrar el peso maximo de los estudiantes que pesan entre 58 y 79
SELECT MAX(peso) FROM estudiantes
WHERE peso BETWEEN 58 AND 79;

    -- Insertar en la tabla estudiantes a Antinio con ru 55666
INSERT estudiantes (ru, nombre) VALUES
    (55666, 'Antonio');


-- COUNT() -> contar

    -- Mostrar el total de filas de la tabla estudiantes
SELECT COUNT(*) FROM estudiantes;

    -- Crear la tabla tablaDeNulos, con las columnas color y tamanyo,
    -- tipos varchar y numeric respectivamente e insertar datos
CREATE TABLE tablaDeNulos(
    color VARCHAR(20),
    tamanyo NUMERIC(6,2),
)
INSERT tablaDeNulos VALUES
    ('rojo', 120.23),
    ('amarillo', 90.7),
    ('verde', 68.3),
    (NULL, NULL),
    ('azul', 100),
    ('morado', 20.9),
    (NULL, NULL),
    ('gris', 150.5);

SELECT * FROM tablaDeNulos;

    -- Mostrar el total de filas de la tabla tablaDeNulos
SELECT COUNT(*) FROM tablaDeNulos;

-- LIKE -> como

    -- Mostrar los datos de los estudiantes cuyo apellido materno terminen en 'es' o 'ez'
SELECT nombre, ap_materno FROM estudiantes
WHERE ap_materno LIKE '%es'
   OR ap_materno LIKE '%ez';

SELECT nombre, ap_materno FROM estudiantes
WHERE ap_materno LIKE '%e[sz]';

    -- Mostrar los datos de los estudiantes cuya fecha de nacimiento este entre 1995 y 1999
SELECT nombre, fecha_nac FROM estudiantes
WHERE fecha_nac BETWEEN '1990' AND '1999';

    -- Mostrar los datos de los estudiantes cuya fecha de nacimiento este entre 1990 y 1999
SELECT nombre, fecha_nac FROM estudiantes
WHERE fecha_nac LIKE '199[0123456789]%';

SELECT nombre, fecha_nac FROM estudiantes
WHERE fecha_nac LIKE '199[0-9]%';