-- Funciones Agregadas

-- AVG() -> Average = Promedio

    -- Mostrar el promedio de los pesos de los estudiantes
SELECT AVG(peso) AS 'Promedio de Pesos' FROM estudiantes;

-- SUM() -> Suma

    -- Mostrar la suma total de los pesos de los estudiantes
SELECT SUM(peso) 'Total de pesos' FROM estudiantes;

    -- Mostrar las edades de los estudiantes, basado en la fecha de nacimiento
SELECT DATEDIFF(YY, estudiantes.fecha_nac, GETDATE()) AS 'Edad'
FROM estudiantes;
    -- Mostrar el nombre y suma de edades de los estudiantes
SELECT nombre, SUM(DATEDIFF(YY, estudiantes.fecha_nac, GETDATE()))
    AS 'Suma de edades'
FROM estudiantes;

    -- Mostrar promedio de edades de los estudiantes
SELECT AVG(DATEDIFF(YY, estudiantes.fecha_nac, GETDATE()))
    AS 'Suma de edades'
FROM estudiantes;

-- MAX() -> Maximo
-- MIN() -> Minimo

    -- Mostrar el peso maximo y edad minima de los estudiantes que hayan nacido entre 1995 y 2000
SELECT MAX(peso) AS 'Peso Maximo',
       MIN(DATEDIFF(YY, estudiantes.fecha_nac, GETDATE())) AS 'Edad Minima'
FROM estudiantes
WHERE fecha_nac BETWEEN '1995' AND '2000-12-31';


-- COUNT() -> Count = contar

SELECT * FROM tablaDeNulos;
    -- Mostrar la cantidad de colores registrados en la tabla tablaDeNulos
SELECT COUNT(color) 'total de colores' FROM tablaDeNulos;
    -- Mostrar el total de filas de la tabla tablaDeNulos
SELECT COUNT(*) AS 'Total de filas' FROM tablaDeNulos;

-- LIKE -> Como
    -- Parametro RegEx -> Regular Expression

    -- Mostrar los datos de los estudiantes cuyo apellido materno terminen en 'es'
SELECT * FROM estudiantes
WHERE ap_materno LIKE '%es';

    -- Mostrar los datos de los estudiantes cuyo apellido materno terminen en 'es' o 'ez'
SELECT * FROM estudiantes
WHERE ap_materno LIKE '%es'
   OR ap_materno LIKE '%ez';

SELECT * FROM estudiantes
WHERE ap_materno LIKE '%e[sz]';

    -- Mostrar los datos de los estudiantes cuyo nombre contenga una vocal al medio
SELECT * FROM estudiantes
WHERE nombre LIKE '%[aeiou]%';
    -- Mostrar los datos de los estudiantes cuya fecha de nacimiento este entre 1995 y 1999
SELECT * FROM estudiantes
WHERE fecha_nac BETWEEN '1995' AND '1999-12-31';

SELECT * FROM estudiantes
WHERE fecha_nac LIKE '199[5-9]%';

    -- Mostrar los datos de los estudiantes cuya fecha de nacimiento NO este entre 1995 y 1999
SELECT * FROM estudiantes
WHERE fecha_nac LIKE '[^1][^9][^9][^5-9]%';
    -- Mostrar los datos de los estudiantes cuyo nombre tenga como vocal la segunda letra
SELECT * FROM estudiantes
WHERE nombre LIKE '_[aeiou]%';
